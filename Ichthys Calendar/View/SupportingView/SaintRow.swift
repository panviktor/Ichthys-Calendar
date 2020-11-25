//
//  SwiftUIView.swift
//  Ichthys Calendar
//
//  Created by Viktor on 19.11.2020.
//

import SwiftUI

struct SaintRow: View {
    @State var saintName: String
    @State var saintImageURL: URL?
    @State var saintSavedImage: UIImage?
    
    var body: some View {
    
            ZStack(alignment: .leading)  {
                WaveShape()
                    .fill(Color(#colorLiteral(red: 0.9625987411, green: 0.713997066, blue: 0.4738479257, alpha: 1)).opacity(0.3))
                HStack {
                    ZStack {
                        RoundedRectangle(cornerRadius: 25, style: .continuous)
                            .fill(Constant.gradientOrange)
                        VStack {
                            if let url = saintImageURL {
                                DayIconImages(url: url)
                            } else if let image = saintSavedImage {
                                DayIconImageSaved(image: image)
                            } else {
                              MainImagePlaceholder()
                            }
                        }
                    }
                    .frame(width: 135, height: 135)
                    VStack(alignment: .leading) {
                        Text(saintName)
                            .font(.headline)
                            .fontWeight(.bold)
                            .lineLimit(4)
                            .layoutPriority(1)
                    }
                    .padding(.horizontal, 5)
                }
                .padding(15)
            }
            .clipShape(RoundedRectangle(cornerRadius: 15))
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SaintRow(saintName: "мц. Кла́вдия Анкирская (Коринфская), дева", saintImageURL:  URL(string: "https://image.tmdb.org/t/p/original/pThyQovXQrw2m0s9x82twj48Jq4.jpg")!)
    }
}
