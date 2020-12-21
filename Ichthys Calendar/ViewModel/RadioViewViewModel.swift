//
//  RadioViewViewModel.swift
//  Ichthys Calendar
//
//  Created by Viktor on 20.12.2020.
//

import SwiftUI
import MediaPlayer

let url = URL(string: "https://upwaveradio.ru/playlist/upwaveradio_128kb.m3u")!
let url2 = URL(string: "http://icecast.radonezh.cdnvideo.ru:8000/rad128")!

let radioStation1: RadioStation = RadioStation(name: "Radonezh", streamURL: url,
                                               description: "Desc1", longDescription: "Long desk 1")

let radioStation2: RadioStation = RadioStation(name: "Радио Радонеж", streamURL: url2,
                                               description: "Desc22", longDescription: "Long desk 22", stationStringImage: "Radonez")


class RadioViewViewModel: ObservableObject {
    let radio = RadioPlayer.shared
    @AppStorage("currentStation") private var currentStationIndex = 0
    
    // MARK: - Lists
    @Published var stations = [RadioStation]()
    @Published var artistName = ""
    @Published var trackName = ""
    @Published var stationImage = UIImage()
    
    init() {
        radio.delegate = self
        setupRemoteTransportControls()
        fetchRadioStaionList()
    }
    
    private func fetchRadioStaionList() {
        stations.append(radioStation1)
        stations.append(radioStation2)
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
        
        if let unrappedImage = station.stationStringImage {
            stationImage = UIImage(named: unrappedImage) ?? Constant.radioImage
        } else {
            stationImage = Constant.radioImage
        }
       
    }
    
    func play() {
        radio.play()
    }
    
    func pause() {
        radio.pause()
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
