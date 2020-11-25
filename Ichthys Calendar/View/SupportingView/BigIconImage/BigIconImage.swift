//
//  BigIconImage.swift
//  Ichthys Calendar
//
//  Created by Viktor on 11.11.2020.
//

import SwiftUI

struct BigIconImage: View {    
    let url: URL

    var body: some View {
        ZStack {
            Constant.gradientOrange
            AsyncImage(
                url: url,
                placeholder: { BigIconImagePlaceholder() },
                image: { (Image(uiImage: $0).resizable()) })
                .aspectRatio(contentMode: .fit)
                .clipped()
                .background(RoundedRectangle(cornerRadius: 5)
                                .stroke(Constant.gradientOrange, lineWidth: 5)
                                .saturation(1.8))
                .padding(8)
        }
        .cornerRadius(5)
        .frame(width: 350, height: 350)
    }
}

struct BigIconImage_Previews: PreviewProvider {
    static var previews: some View {
        BigIconImage(url: URL(string: "https://image.tmdb.org/t/p/original/pThyQovXQrw2m0s9x82twj48Jq4.jpg")!)
    }
}



