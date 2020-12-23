//
//  RadioRow.swift
//  Ichthys Calendar
//
//  Created by Viktor on 23.12.2020.
//

import SwiftUI

struct RadioRow: View {
    let station: RadioStation
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Rectangle()
                    .fill(Constant.gradientBackground)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .edgesIgnoringSafeArea(.all)
                
                VStack(alignment: .center) {
                    Image(uiImage: UIImage(named: station.stationImage!) ?? Constant.radioImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(1)
                        .frame(minWidth: geometry.size.width * 0.25,
                               maxWidth: geometry.size.width * 0.35,
                               minHeight: geometry.size.width * 0.25,
                               maxHeight: geometry.size.width * 0.35)
                    Text(station.name)
                        .font(.subheadline)
                        .multilineTextAlignment(.center)
                        .lineLimit(2)
                        .padding(2)
                }
            }
            .frame(width: geometry.size.width * 0.44, height: geometry.size.width * 0.44)
            .cornerRadius(15)
            .padding(6)
            .modifier(BasicNeumorphicShadow())
        }
    }
}

struct RadioRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            RadioRow(station: RadioStation.mocRadio)
            RadioRow(station: RadioStation.mocRadio)
                .preferredColorScheme(.dark)
        }
    }
}
