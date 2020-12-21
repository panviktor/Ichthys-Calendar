//
//  RadioViewViewModel.swift
//  Ichthys Calendar
//
//  Created by Viktor on 20.12.2020.
//

import Foundation
import MediaPlayer

class RadioViewViewModel: ObservableObject {
    let radio = RadioPlayer.shared
    
    let url2 = "http://icecast.radonezh.cdnvideo.ru:8000/rad128"
    let url = "https://upwaveradio.ru/playlist/upwaveradio_128kb.m3u"
    
    @Published var artistName = ""
    @Published var trackName = ""
    
    init() {
        radio.delegate = self
        setupRemoteTransportControls()
    }
    
    func changeStation1() {
        radio.radioURL = URL(string: url)
    }
    
    func changeStation2() {
        radio.radioURL = URL(string: url2)
    }
    
    private func setupRemoteTransportControls() {
        // Get the shared MPRemoteCommandCenter
        let commandCenter = MPRemoteCommandCenter.shared()
        
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
