//
//  HolidayIcon.swift
//  Ichthys Calendar
//
//  Created by Viktor on 26.11.2020.
//

import SwiftUI

struct HolidayIcon: View {
    let url: URL
    
    var body: some View {
        ZStack {
            Constant.gradientBackground
            AsyncImage(
                url: url,
                placeholder: { Constant.gradientBackground.opacity(0.8) },
                image: { (Image(uiImage: $0).resizable()) })
                .aspectRatio(contentMode: .fit)
                .clipped()
                .padding(0.5)
        }
        .cornerRadius(5)
        .frame(width: 60, height: 60)
        .modifier(BasicNeumorphicShadow())
    }
    
}

struct HolidayIcon_Previews: PreviewProvider {
    static var previews: some View {
        HolidayIcon(url: URL(string: "https://image.tmdb.org/t/p/original/pThyQovXQrw2m0s9x82twj48Jq4.jpg")!)
    }
}
