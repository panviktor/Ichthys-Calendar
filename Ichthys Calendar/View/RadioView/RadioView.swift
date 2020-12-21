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
            Text(viewModel.artistName).padding()
            Text(viewModel.trackName).padding()
            
            Button("play") {
                viewModel.radio.play()
            }
            .padding()
            Button("stop") {
                viewModel.radio.pause()
            }
            
            Button("fm1") {
                viewModel.changeStation1()
            }
            .padding()
            
            Button("fm2") {
                viewModel.changeStation2()
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
