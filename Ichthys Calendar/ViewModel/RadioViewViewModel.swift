//
//  RadioViewViewModel.swift
//  Ichthys Calendar
//
//  Created by Viktor on 20.12.2020.
//

import Foundation

class RadioViewViewModel: ObservableObject {
    let radio = RadioPlayer.shared
    
    let url = "http://icecast.radonezh.cdnvideo.ru:8000/rad128"
    let url2 = "http://rfcmedia.streamguys1.com/Newport.mp3"
    
    
    init() {
        radio.delegate = self
        radio.radioURL = URL(string: url)
    }
}

extension RadioViewViewModel: RadioPlayerDelegate {
    func radioPlayer(_ player: RadioPlayer, playerStateDidChange state: RadioPlayerState) {
        
    }
    
    func radioPlayer(_ player: RadioPlayer, playbackStateDidChange state: RadioPlaybackState) {
        
    }
}
