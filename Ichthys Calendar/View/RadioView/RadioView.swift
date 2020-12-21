//
//  RadioView.swift
//  Ichthys Calendar
//
//  Created by Viktor on 19.12.2020.
//

import SwiftUI

import MediaPlayer
import UIKit

struct VolumeSlider: UIViewRepresentable {
   func makeUIView(context: Context) -> MPVolumeView {
      MPVolumeView(frame: .zero)
   }

   func updateUIView(_ view: MPVolumeView, context: Context) {}
}

struct RadioView: View {
    @StateObject var viewModel: RadioViewViewModel
    
    var body: some View {
        VStack {
            Image(uiImage: viewModel.stationImage)
                .resizable()
                .clipped()
                .frame(width: 100, height: 100)
            Text(viewModel.artistName).padding()
            Text(viewModel.trackName).padding()
            
            Button("play") {
                viewModel.play()
            }
            .padding()
            
            Button("pause") {
                viewModel.pause()
            }
            .padding()
            
            Button("stop") {
                viewModel.stop()
            }
            
            Button(">>>") {
                viewModel.nextStation()
            }
            .padding()
            
            Button("<<<") {
                viewModel.previousStation()
            }
            .padding()
            
            Group {
                Button("mute") {
                    viewModel.mute()
                }
                .padding()
                
                VolumeSlider()
                   .frame(height: 40)
                   .padding(.horizontal)
            }
      
        }
        .padding()
    }
}

struct RadioView_Previews: PreviewProvider {
    static var previews: some View {
        RadioView(viewModel: RadioViewViewModel())
    }
}
