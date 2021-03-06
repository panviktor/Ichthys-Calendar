//
//  RadioPlayer.swift
//  Ichthys Calendar
//
//  Created by Viktor on 20.12.2020.
//

import AVFoundation
import MediaPlayer
import Network

class RadioPlayer: NSObject {
    // MARK: - Properties
    /// Returns the singleton `RadioPlayer` instance.
    static let shared = RadioPlayer()
    
    /**
     The delegate object for the `RadioPlayer`.
     Implement the methods declared by the `RadioPlayerDelegate` object to respond to user interactions and the player output.
     */
    weak var delegate: RadioPlayerDelegate?
    
    /// The player current radio URL
    var radioStation: RadioStation? {
        didSet {
            radioURLDidChange(with: radioStation?.streamURL)
            setupRadioInfo(station: radioStation)
        }
    }
    
    /// The player starts playing when the radioURL property gets set. (default == true)
    var isAutoPlay = true
    
    /// Check if the player is playing
    var isPlaying: Bool {
        switch playbackState {
        case .playing:
            return true
        case .stopped, .paused:
            return false
        }
    }
    
    var mute: Bool? {
        get {
            return player?.isMuted
        }
        set {
            guard let newValue = newValue else { return }
            player?.isMuted = newValue
        }
    }
    
    /// Player current state of type `RadioPlayerState`
    private(set) var state = RadioPlayerState.urlNotSet {
        didSet {
            guard oldValue != state else { return }
            delegate?.radioPlayer(self, playerStateDidChange: state)
        }
    }
    
    /// Playing state of type `RadioPlaybackState`
    private(set) var playbackState = RadioPlaybackState.stopped {
        didSet {
            guard oldValue != playbackState else { return }
            delegate?.radioPlayer(self, playbackStateDidChange: playbackState)
        }
    }
    
    // MARK: - Private properties
    /// AVPlayer
    private var player: AVPlayer?
    
    /// Last player item
    private var lastPlayerItem: AVPlayerItem?
    
    /// Check for headphones, used to handle audio route change
    private var headphonesConnected: Bool = false
    
    /// Default player item
    private var playerItem: AVPlayerItem? {
        didSet {
            playerItemDidChange()
        }
    }
    
    /// Reachability for network interruption handling
    let monitor = NWPathMonitor()
    let queue = DispatchQueue.global(qos: .background)
    /// Current network connectivity
    private var isConnected = false
    
    /// MPNowPlayingInfoCenter
    let nowPlayingInfoCenter = MPNowPlayingInfoCenter.default()
    
    // MARK: - Initialization
    private override init() {
        super.init()
        // Enable bluetooth playback
        let options: AVAudioSession.CategoryOptions = [.defaultToSpeaker, .allowBluetooth, .allowAirPlay]
        
        // Start audio session
        let audioSession = AVAudioSession.sharedInstance()
        try? audioSession.setCategory(AVAudioSession.Category.playback, mode: AVAudioSession.Mode.default, options: options)
        
        // Notifications
        setupNotifications()
        // Check for headphones
        checkHeadphonesConnection(outputs: AVAudioSession.sharedInstance().currentRoute.outputs)
        // Check Internet
        setupInternetMonitor()
    }
    
    //MARK: - MPNowPlayingInfoCenter
    private func setupRadioInfo(station: RadioStation?) {
        guard let station = station else { return }
        let title = station.name
        let album = station.description
        let stringImage = station.stationImage
        setupPlayingInfo(title, album, image: stringImage)
    }
    
    //MARK: - Internet Monitor
    private func setupInternetMonitor() {
        monitor.start(queue: queue)
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                self.isConnected = true
                // Check if the internet connection was lost
                self.checkNetworkInterruption()
            } else {
                self.isConnected = false
                self.pause()
                print("No connection.")
            }
        }
    }
    
    // MARK: - Control Methods
    /**
     Trigger the play function of the radio player
     */
    func play() {
        guard let player = player else { return }
        if player.currentItem == nil, playerItem != nil {
            player.replaceCurrentItem(with: playerItem)
        }
        
        player.play()
        playbackState = .playing
    }
    
    /**
     Trigger the pause function of the radio player
     */
    func pause() {
        guard let player = player else { return }
        player.pause()
        playbackState = .paused
    }
    
    /**
     Trigger the stop function of the radio player
     */
    func stop() {
        guard let player = player else { return }
        playbackState = .stopped
        player.replaceCurrentItem(with: nil)
        timedMetadataDidChange(rawValue: nil)
    }
    
    /**
     Toggle isPlaying state
     */
    func togglePlaying() {
        isPlaying ? pause() : play()
    }
    
    // MARK: - Private helpers
    private func radioURLDidChange(with url: URL?) {
        resetPlayer()
        guard let url = url else { state = .urlNotSet; return }
        state = .loading
        
        preparePlayer(with: AVAsset(url: url)) { (success, asset) in
            guard success, let asset = asset else {
                self.resetPlayer()
                self.state = .error
                return
            }
            self.setupPlayer(with: asset)
        }
    }
    
    private func setupPlayer(with asset: AVAsset) {
        if player == nil {
            player = AVPlayer()
            // Removes black screen when connecting to appleTV
            player?.allowsExternalPlayback = false
        }
        
        playerItem = AVPlayerItem(asset: asset)
        let metadataOutput = AVPlayerItemMetadataOutput(identifiers: nil)
        metadataOutput.setDelegate(self, queue: DispatchQueue.main)
        playerItem?.add(metadataOutput)
    }
    
    /** Reset all player item observers and create new ones
     */
    private func playerItemDidChange() {
        guard lastPlayerItem != playerItem else { return }
        if let item = lastPlayerItem {
            pause()
            NotificationCenter.default.removeObserver(self, name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: item)
            item.removeObserver(self, forKeyPath: "status")
            item.removeObserver(self, forKeyPath: "playbackBufferEmpty")
            item.removeObserver(self, forKeyPath: "playbackLikelyToKeepUp")
        }
        
        lastPlayerItem = playerItem
        timedMetadataDidChange(rawValue: nil)
        
        if let item = playerItem {
            item.addObserver(self, forKeyPath: "status", options: NSKeyValueObservingOptions.new, context: nil)
            item.addObserver(self, forKeyPath: "playbackBufferEmpty", options: NSKeyValueObservingOptions.new, context: nil)
            item.addObserver(self, forKeyPath: "playbackLikelyToKeepUp", options: NSKeyValueObservingOptions.new, context: nil)
            
            player?.replaceCurrentItem(with: item)
            if isAutoPlay { play() }
        }
        
        delegate?.radioPlayer?(self, itemDidChange: radioStation?.streamURL)
    }
    
    /** Prepare the player from the passed AVAsset
     */
    private func preparePlayer(with asset: AVAsset?, completionHandler: @escaping (_ isPlayable: Bool, _ asset: AVAsset?)->()) {
        guard let asset = asset else {
            completionHandler(false, nil)
            return
        }

        let requestedKey = ["playable"]

        asset.loadValuesAsynchronously(forKeys: requestedKey) {
            DispatchQueue.main.async {
                var error: NSError?
                let keyStatus = asset.statusOfValue(forKey: "playable", error: &error)
                if keyStatus == AVKeyValueStatus.failed || !asset.isPlayable {
                    completionHandler(false, nil)
                    return
                }

                completionHandler(true, asset)
            }
        }
    }
    
    private func timedMetadataDidChange(rawValue: String?) {
        let metadataCleaned = cleanMetadata(rawValue)
        let parts = metadataCleaned?.components(separatedBy: " - ")
        delegate?.radioPlayer?(self, metadataDidChange: parts?.first, trackName: parts?.last)
        delegate?.radioPlayer?(self, metadataDidChange: rawValue)
        
        guard let partFirst = parts?.first else { return }
        guard let partLast = parts?.last else { return }
        
        setupPlayingInfo(partFirst, partLast)
    }
    
    private func setupPlayingInfo(_ partFirst: String, _ partLast: String, image: String? = nil) {
        var nowPlayingInfo = nowPlayingInfoCenter.nowPlayingInfo ?? [String: Any]()
        if !partFirst.isEmpty {
            nowPlayingInfo[MPMediaItemPropertyTitle] = partFirst
        }
        
        if !partLast.isEmpty {
            nowPlayingInfo[MPMediaItemPropertyAlbumTitle] = partLast
        }
        
        if let unrappedImage = image, let image = UIImage(named: unrappedImage) {
            nowPlayingInfo[MPMediaItemPropertyArtwork] = MPMediaItemArtwork(boundsSize: image.size, requestHandler: { size -> UIImage in
                return image
            })
        } else {
            nowPlayingInfo[MPMediaItemPropertyArtwork] = MPMediaItemArtwork(boundsSize: Constant.radioImage.size, requestHandler: { size -> UIImage in
                Constant.radioImage
            })
        }
        
        nowPlayingInfoCenter.nowPlayingInfo = nowPlayingInfo
    }
    
    private func cleanMetadata(_ rawValue: String?) -> String? {
        guard let rawValue = rawValue else { return nil }
        return rawValue.replacingOccurrences(
            of: #"(\(.*?\)\w*)|(\[.*?\]\w*)"#,
            with: "",
            options: .regularExpression
        )
    }
    
    private func reloadItem() {
        player?.replaceCurrentItem(with: nil)
        player?.replaceCurrentItem(with: playerItem)
    }
    
    private func resetPlayer() {
        stop()
        playerItem = nil
        lastPlayerItem = nil
        player = nil
    }
    
    deinit {
        resetPlayer()
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Notifications
    private func setupNotifications() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(handleInterruption), name: AVAudioSession.interruptionNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(handleRouteChange), name: AVAudioSession.routeChangeNotification, object: nil)
    }
    
    // MARK: - Responding to Interruptions
    @objc private func handleInterruption(notification: Notification) {
        guard let userInfo = notification.userInfo,
              let typeValue = userInfo[AVAudioSessionInterruptionTypeKey] as? UInt,
              let type = AVAudioSession.InterruptionType(rawValue: typeValue) else {
            return
        }
        switch type {
        case .began:
            DispatchQueue.main.async { self.pause() }
        case .ended:
            guard let optionsValue = userInfo[AVAudioSessionInterruptionOptionKey] as? UInt else { break }
            let options = AVAudioSession.InterruptionOptions(rawValue: optionsValue)
            DispatchQueue.main.async { options.contains(.shouldResume) ? self.play() : self.pause() }
        @unknown default:
            break
        }
    }
    
    // Check if the playback could keep up after a network interruption
    private func checkNetworkInterruption() {
        guard let item = playerItem, !item.isPlaybackLikelyToKeepUp, isConnected else { return }
        player?.pause()
        
        // Wait 1 sec to recheck and make sure the reload is needed
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            if !item.isPlaybackLikelyToKeepUp { self.reloadItem() }
            self.isPlaying ? self.player?.play() : self.player?.pause()
        }
    }
    
    // MARK: - Responding to Route Changes
    private func checkHeadphonesConnection(outputs: [AVAudioSessionPortDescription]) {
        for output in outputs where output.portType == .headphones {
            headphonesConnected = true
            break
        }
        headphonesConnected = false
    }
    
    @objc private func handleRouteChange(notification: Notification) {
        guard let userInfo = notification.userInfo,
              let reasonValue = userInfo[AVAudioSessionRouteChangeReasonKey] as? UInt,
              let reason = AVAudioSession.RouteChangeReason(rawValue:reasonValue) else { return }
        
        switch reason {
        case .newDeviceAvailable:
            checkHeadphonesConnection(outputs: AVAudioSession.sharedInstance().currentRoute.outputs)
        case .oldDeviceUnavailable:
            guard let previousRoute = userInfo[AVAudioSessionRouteChangePreviousRouteKey] as? AVAudioSessionRouteDescription else { return }
            checkHeadphonesConnection(outputs: previousRoute.outputs);
            DispatchQueue.main.async { self.headphonesConnected ? () : self.pause() }
        default: break
        }
    }
    
    // MARK: - KVO
    /// :nodoc:
    override func observeValue(forKeyPath keyPath: String?, of object: Any?,
                               change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if let item = object as? AVPlayerItem, let keyPath = keyPath, item == self.playerItem {
            switch keyPath {
            case "status":
                if player?.status == AVPlayer.Status.readyToPlay {
                    self.state = .readyToPlay
                } else if player?.status == AVPlayer.Status.failed {
                    self.state = .error
                }
            case "playbackBufferEmpty":
                if item.isPlaybackBufferEmpty {
                    self.state = .loading
                    self.checkNetworkInterruption()
                }
            case "playbackLikelyToKeepUp":
                self.state = item.isPlaybackLikelyToKeepUp ? .loadingFinished : .loading
            default:
                break
            }
        }
    }
}

extension RadioPlayer: AVPlayerItemMetadataOutputPushDelegate {
    public func metadataOutput(_ output: AVPlayerItemMetadataOutput,
                               didOutputTimedMetadataGroups groups: [AVTimedMetadataGroup],
                               from track: AVPlayerItemTrack?) {
        
        // make this an AVMetadata item
        guard let item = groups.first?.items.first else {
            timedMetadataDidChange(rawValue: nil)
            return
        }
        
        timedMetadataDidChange(rawValue: item.value as? String)
    }
}
