//
//  RadioView.swift
//  Ichthys Calendar
//
//  Created by Viktor on 19.12.2020.
//

import SwiftUI

struct RadioView: View {
    @StateObject var viewModel: RadioViewViewModel
    
    var body: some View {
        VStack {
            Button("play") {
                viewModel.radio.play()
            }
            .padding()
            Button("stop") {
                viewModel.radio.pause()
            }
            .padding()
        }
        .padding()
    }
}

struct RadioView_Previews: PreviewProvider {
    static var previews: some View {
        RadioView(viewModel: RadioViewViewModel())
    }
}
