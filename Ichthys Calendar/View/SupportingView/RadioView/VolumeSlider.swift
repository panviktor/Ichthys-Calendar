//
//  VolumeSlider.swift
//  Ichthys Calendar
//
//  Created by Viktor on 23.12.2020.
//

import SwiftUI
import MediaPlayer

struct VolumeSlider: UIViewRepresentable {
   func makeUIView(context: Context) -> MPVolumeView {
      MPVolumeView(frame: .zero)
   }

   func updateUIView(_ view: MPVolumeView, context: Context) {}
}
