//
//  BigIconImage.swift
//  Ichthys Calendar
//
//  Created by Viktor on 11.11.2020.
//

import SwiftUI

struct BigIconImage: View {
    let gradient = LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)), Color(#colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing)
    
    let url: URL

    var body: some View {
        ZStack {
            gradient
            AsyncImage(
                url: url,
                placeholder: { BigIconImagePlaceholder() },
                image: { (Image(uiImage: $0).resizable()) })
                .aspectRatio(contentMode: .fit)
                .padding(5)
                .background(RoundedRectangle(cornerRadius: 5)
                                .stroke(gradient, lineWidth: 5)
                                .saturation(1.8))
        }
    }
}

struct BigIconImage_Previews: PreviewProvider {
    static var previews: some View {
        BigIconImage(url: URL(string: "https://image.tmdb.org/t/p/original/pThyQovXQrw2m0s9x82twj48Jq4.jpg")!)
    }
}


