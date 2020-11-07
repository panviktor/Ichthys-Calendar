//
//  DayIconImages.swift
//  Ichthys Calendar
//
//  Created by Viktor on 07.11.2020.
//

import SwiftUI

struct DayIconImages: View {
    var url = URL(string: "https://image.tmdb.org/t/p/original/pThyQovXQrw2m0s9x82twj48Jq4.jpg")!
    
    var body: some View {
            AsyncImage(
                url: url,
                placeholder: { Image(systemName: "person.crop.square") },
                image: { (Image(uiImage: $0).resizable())
                })
                .aspectRatio(contentMode: .fit)
    }
}

struct DayIconImages_Previews: PreviewProvider {
    static var previews: some View {
        DayIconImages()
    }
}
