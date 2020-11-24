//
//  DayIconImages.swift
//  Ichthys Calendar
//
//  Created by Viktor on 07.11.2020.
//

import SwiftUI

struct DayIconImages: View {
    let url: URL
    
    var body: some View {
        ZStack {
            Constant.gradient
            AsyncImage(
                url: url,
                placeholder: { MainImagePlaceholder() },
                image: { (Image(uiImage: $0).resizable()) })
                .aspectRatio(contentMode: .fit)
                .padding(3)
                .clipped()
        }
        .frame(width: 120, height: 120)
        .cornerRadius(5)
    }
}

struct DayIconImages_Previews: PreviewProvider {
    static var previews: some View {
        DayIconImages(url: URL(string: "https://image.tmdb.org/t/p/original/pThyQovXQrw2m0s9x82twj48Jq4.jpg")!)
    }
}
