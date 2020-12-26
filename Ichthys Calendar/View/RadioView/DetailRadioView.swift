//
//  DetailRadioView.swift
//  Ichthys Calendar
//
//  Created by Viktor on 25.12.2020.
//

import SwiftUI

struct DetailRadioView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var station: RadioStation
    
    var body: some View {
        ScrollView {
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
                    Text(station.name)
                        .font(.headline)
                        .multilineTextAlignment(.center)
                        .lineLimit(2)
                        .padding(3)
                    Divider()
                    Text(station.description)
                        .font(.subheadline)
                        .multilineTextAlignment(.leading)
                        .lineLimit(nil)
                        .padding(3)
                    Divider()
                    Text(station.longDescription)
                        .font(.callout)
                        .multilineTextAlignment(.leading)
                        .lineLimit(nil)
                        .padding(3)
                    Spacer()
                }
            }
            .cornerRadius(15)
            .padding(10)
            .modifier(BasicNeumorphicShadow())
            .compositingGroup()
        }
    }
}

struct DetailRadioView_Previews: PreviewProvider {
    static var previews: some View {
        DetailRadioView(station: RadioStation.mocRadio)
    }
}
