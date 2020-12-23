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
            ZStack(alignment: .leading)  {
                WaveShape()
                    .fill(Constant.gradientBackground)
                    HStack {
                        Image(uiImage: UIImage(named: station.stationImage!) ?? Constant.radioImage)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding(3)
                            .clipped()
                            .frame(width: 135, height: 135)
                        VStack {
                            Text(station.name)
                                .font(.title)
                                .layoutPriority(10)
                        }
                    }
            }
    }
}

struct RadioRow_Previews: PreviewProvider {
    static var previews: some View {
        RadioRow(station: RadioStation.mocRadio)
            .previewLayout(.fixed(width: 600, height: 400))
    }
}
