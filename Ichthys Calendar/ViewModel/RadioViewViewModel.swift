//
//  RadioViewViewModel.swift
//  Ichthys Calendar
//
//  Created by Viktor on 20.12.2020.
//

import SwiftUI
import MediaPlayer

class RadioViewViewModel: ObservableObject {
    let radio = RadioPlayer.shared
    @AppStorage("currentStation") private var currentStationIndex = 0
    
    // MARK: - Lists
    @Published var stations = [RadioStation]()
    @Published var artistName = ""
    @Published var trackName = ""
    @Published var stationImage = UIImage()
    var isPlaying: Bool {
        radio.isPlaying
    }

    init() {
        radio.delegate = self
        setupRemoteTransportControls()
        fetchRadioStaionList()
    }
    
    private func fetchRadioStaionList() {
        stations = Bundle.main.decode([RadioStation].self, from: "stations.json")
    }
    
    //MARK: - Contol Station
    func nextStation() {
        guard !stations.isEmpty else { return }
        if currentStationIndex < (stations.count - 1) {
            currentStationIndex += 1
            playRadioStation(stations[currentStationIndex])
        } else {
            currentStationIndex = 0
            playRadioStation(stations[0])
        }
    }
    
    func previousStation() {
        guard !stations.isEmpty else { return }
        if currentStationIndex > 0 {
            currentStationIndex -= 1
            playRadioStation(stations[currentStationIndex])
        } else {
            currentStationIndex = (stations.count - 1)
            playRadioStation(stations[currentStationIndex])
        }
    }
    
    func playRadioStation(_ station: RadioStation) {
        radio.radioStation = station
        
        if let unrappedImage = station.stationImage {
            stationImage = UIImage(named: unrappedImage) ?? Constant.radioImage
        } else {
            stationImage = Constant.radioImage
        }
    }
    
    func togglePlaying() {
        radio.togglePlaying()
    }
    
    func stop() {
        radio.stop()
    }
    
    //MARK: - Volume
    func mute() {
        radio.mute?.toggle()
    }
    
    //MARK: - MPRemoteCommandCenter
    private func setupRemoteTransportControls() {
        // Get the shared MPRemoteCommandCenter
        let commandCenter = MPRemoteCommandCenter.shared()
        // Add handler for Play Command
        commandCenter.playCommand.addTarget { (event) -> MPRemoteCommandHandlerStatus in
            self.radio.play()
            return .success
        }
        commandCenter.pauseCommand.addTarget { (event) -> MPRemoteCommandHandlerStatus in
            self.radio.pause()
            return .success
        }
        commandCenter.nextTrackCommand.addTarget { (event) -> MPRemoteCommandHandlerStatus in
            self.nextStation()
            return .success
        }
        commandCenter.previousTrackCommand.addTarget { (event) -> MPRemoteCommandHandlerStatus in
            self.previousStation()
            return .success
        }
    }
}

extension RadioViewViewModel: RadioPlayerDelegate {
    func radioPlayer(_ player: RadioPlayer, playerStateDidChange state: RadioPlayerState) {}
    func radioPlayer(_ player: RadioPlayer, playbackStateDidChange state: RadioPlaybackState) {}
    func radioPlayer(_ player: RadioPlayer, metadataDidChange artistName: String?, trackName: String?) {
        self.artistName = artistName ?? ""
        self.trackName = trackName ?? ""
    }
}
