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
                    .fill(Constant.gradientBackground)
                HStack {
                    ZStack {
                        RoundedRectangle(cornerRadius: 25, style: .continuous)
                            .fill(Constant.gradientBackground)
                        VStack {
                            if let url = saintImageURL {
                                DayIconImages(url: url)
                            } else if let image = saintSavedImage {
                                DayIconImageSaved(image: image)
                            } else {
                              MainImagePlaceholder()
                            }
                        }
                        .blendMode(.normal)
                    }
                    .frame(width: 135, height: 135)
                    VStack(alignment: .leading) {
                        Text(saintName)
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .lineLimit(4)
                            .layoutPriority(1)
                    }
                    .padding(.horizontal, 5)
                }
                .padding(10)
            }
            .cornerRadius(15)
            .modifier(BasicNeumorphicShadow())
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SaintRow(saintName: "мц. Кла́вдия Анкирская (Коринфская), дева", saintImageURL:  URL(string: "https://image.tmdb.org/t/p/original/pThyQovXQrw2m0s9x82twj48Jq4.jpg")!)
            .previewLayout(.fixed(width: 600, height: 200))
    }
}
