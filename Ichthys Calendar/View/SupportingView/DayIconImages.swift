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
            AsyncImage(
                url: url,
                placeholder: { Image(systemName: "person.crop.square")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150, height: 150, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                },
                image: { (Image(uiImage: $0).resizable())
                })
                .aspectRatio(contentMode: .fit)
                .frame(width: 150, height: 150, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
    }
}

struct DayIconImages_Previews: PreviewProvider {
    static var previews: some View {
        DayIconImages(url: URL(string: "https://image.tmdb.org/t/p/original/pThyQovXQrw2m0s9x82twj48Jq4.jpg")!)
    }
}
