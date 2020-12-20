//
//  RadioView.swift
//  Ichthys Calendar
//
//  Created by Viktor on 19.12.2020.
//

import SwiftUI
import AVFoundation




class RadioEngine {
    static var instance = RadioEngine()
    private init() {}
    
    let url = "http://icecast.radonezh.cdnvideo.ru:8000/rad128"
    
    var player = AVPlayer()
    
    func initPlayer() {
         guard let url = URL(string: url) else { return }
         let playerItem = AVPlayerItem(url: url)
         player = AVPlayer(playerItem: playerItem)
         playAudioBackground()
     }
    
    func playAudioBackground() {
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback, mode: AVAudioSession.Mode.default, options: [.mixWithOthers, .allowAirPlay])
            print("Playback OK")
            try AVAudioSession.sharedInstance().setActive(true)
            print("Session is Active")
        } catch {
            print(error)
        }
    }
    
    func pause(){
        player.pause()
    }
    
    func play() {
        player.play()
    }
    
    
}


struct RadioView: View {
    let radioEngine = RadioEngine.instance
    
    var body: some View {
        VStack {
            Button("play") {
                radioEngine.play()
            }
            .padding()
            Button("stop") {
                radioEngine.play()
            }
            .padding()
        }
        .padding()
    }
}

struct RadioView_Previews: PreviewProvider {
    static var previews: some View {
        RadioView()
    }
}
