//
//  RadioRow.swift
//  Ichthys Calendar
//
//  Created by Viktor on 23.12.2020.
//

import SwiftUI

struct RadioRow: View {
    @EnvironmentObject var orientationInfo: OrientationInfo
    let station: RadioStation
    
    var screenWidth: CGFloat {
        let screenRect = UIScreen.main.bounds
        return screenRect.size.width
    }
    
    var screenHeight: CGFloat {
        let screenRect = UIScreen.main.bounds
        return screenRect.size.height
    }
    
    var body: some View {
        if orientationInfo.orientation == .portrait {
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
                        .frame(minWidth: screenWidth * 0.2,
                               maxWidth: screenWidth * 0.3,
                               minHeight: screenWidth * 0.2,
                               maxHeight: screenWidth * 0.3)
                    Text(station.name)
                        .font(.subheadline)
                        .multilineTextAlignment(.center)
                        .lineLimit(2)
                        .padding(3)
                    Spacer()
                }
            }
            .frame(minWidth: screenWidth * 0.35, idealWidth: screenWidth * 0.4, maxWidth: screenWidth * 0.5,
                   minHeight: screenWidth * 0.4, idealHeight: screenWidth * 0.4, maxHeight: screenWidth * 0.5,
                   alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .cornerRadius(15)
            .padding(6)
            .modifier(BasicNeumorphicShadow())
            .compositingGroup()
        } else {
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
                        .frame(minWidth: screenHeight * 0.2,
                               maxWidth: screenHeight * 0.3,
                               minHeight: screenHeight * 0.2,
                               maxHeight: screenHeight * 0.3)
                    Text(station.name)
                        .font(.subheadline)
                        .multilineTextAlignment(.center)
                        .lineLimit(5)
                        .padding(3)
                    Spacer()
                }
            }
            .frame(minWidth: screenHeight * 0.45, idealWidth: screenHeight * 0.5, maxWidth: screenHeight * 0.6,
                   minHeight: screenHeight * 0.45, idealHeight: screenHeight * 0.5, maxHeight: screenHeight * 0.6,
                   alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .cornerRadius(15)
            .padding(6)
            .modifier(BasicNeumorphicShadow())
            .compositingGroup()
        }
    }
}

struct RadioRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            RadioRow(station: RadioStation.mocRadio)
            RadioRow(station: RadioStation.mocRadio)
                .previewDevice("iPod touch (7th generation)")
                .preferredColorScheme(.dark)
        }
    }
}
