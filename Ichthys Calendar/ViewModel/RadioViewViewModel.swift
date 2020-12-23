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


extension Bundle {
    func decode<T: Decodable>(_ type: T.Type, from file: String, dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .deferredToDate, keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle.")
        }

        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle.")
        }

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = dateDecodingStrategy
        decoder.keyDecodingStrategy = keyDecodingStrategy

        do {
            return try decoder.decode(T.self, from: data)
        } catch DecodingError.keyNotFound(let key, let context) {
            fatalError("Failed to decode \(file) from bundle due to missing key '\(key.stringValue)' not found – \(context.debugDescription)")
        } catch DecodingError.typeMismatch(_, let context) {
            fatalError("Failed to decode \(file) from bundle due to type mismatch – \(context.debugDescription)")
        } catch DecodingError.valueNotFound(let type, let context) {
            fatalError("Failed to decode \(file) from bundle due to missing \(type) value – \(context.debugDescription)")
        } catch DecodingError.dataCorrupted(_) {
            fatalError("Failed to decode \(file) from bundle because it appears to be invalid JSON")
        } catch {
            fatalError("Failed to decode \(file) from bundle: \(error.localizedDescription)")
        }
    }
}
