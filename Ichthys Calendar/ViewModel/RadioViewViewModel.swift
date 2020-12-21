//
//  RadioViewViewModel.swift
//  Ichthys Calendar
//
//  Created by Viktor on 20.12.2020.
//

import Foundation
import MediaPlayer

let url = URL(string: "https://upwaveradio.ru/playlist/upwaveradio_128kb.m3u")!
let url2 = URL(string: "http://icecast.radonezh.cdnvideo.ru:8000/rad128")!

class RadioViewViewModel: ObservableObject {
    let radio = RadioPlayer.shared
    
    let RadioStation1: RadioStation = RadioStation(name: "Radonezh", streamURL: url, description: "Desc1", longDescription: "Long desk 1")
  
    let RadioStation2: RadioStation = RadioStation(name: "Radonezh22", streamURL: url2, description: "Desc22", longDescription: "Long desk 22")
    
    
    
    
    
    @Published var artistName = ""
    @Published var trackName = ""
    
    init() {
        radio.delegate = self
        setupRemoteTransportControls()
    }
    
    func changeStation1() {
        radio.radioStation = RadioStation1
    }
    
    func changeStation2() {
       radio.radioStation = RadioStation2
    }
    
    //MARK: - MPRemoteCommandCenter
    private func setupRemoteTransportControls() {
        // Get the shared MPRemoteCommandCenter
        let commandCenter = MPRemoteCommandCenter.shared()
        
        // Add handler for Play Command
        commandCenter.playCommand.addTarget { (event) -> MPRemoteCommandHandlerStatus in
            
            return .success
        }
        
      
        commandCenter.pauseCommand.addTarget { (event) -> MPRemoteCommandHandlerStatus in
            return .success
        }
        
        commandCenter.nextTrackCommand.addTarget { (event) -> MPRemoteCommandHandlerStatus in
            self.changeStation1()
            return .success
        }

        commandCenter.previousTrackCommand.addTarget { (event) -> MPRemoteCommandHandlerStatus in
            self.changeStation2()
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
