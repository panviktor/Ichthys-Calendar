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
            Constant.gradient
            AsyncImage(
                url: url,
                placeholder: { BigIconImagePlaceholder() },
                image: { (Image(uiImage: $0).resizable()) })
                .clipped()
                .aspectRatio(contentMode: .fit)
                .padding(5)
                .background(RoundedRectangle(cornerRadius: 5)
                                .stroke(Constant.gradient, lineWidth: 5)
                                .saturation(1.8))
        }
    }
}

struct BigIconImage_Previews: PreviewProvider {
    static var previews: some View {
        BigIconImage(url: URL(string: "https://image.tmdb.org/t/p/original/pThyQovXQrw2m0s9x82twj48Jq4.jpg")!)
    }
}


