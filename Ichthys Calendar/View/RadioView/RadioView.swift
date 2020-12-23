//
//  RadioView.swift
//  Ichthys Calendar
//
//  Created by Viktor on 19.12.2020.
//

import SwiftUI

struct RadioView: View {
    @StateObject var viewModel: RadioViewViewModel
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                VStack {
                    ZStack {
                        WaveShape()
                            .fill(Color(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)).opacity(0.3))
                    }
                    .frame(width: geometry.size.width, height: 20)
                    .edgesIgnoringSafeArea(.top)
                }
            }
            
            
            
            
            
            VStack {
                List(viewModel.stations) { station in
                    RadioRow(station: station)
                }
                
                VStack {
                    VolumeSlider()
                        .frame(height: 40)
                        .padding(.horizontal)
                }
            }
            .padding()
            
            
        }
        
        
        
        

    }
}

struct RadioView_Previews: PreviewProvider {
    static var previews: some View {
        RadioView(viewModel: RadioViewViewModel())
    }
}
