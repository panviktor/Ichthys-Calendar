//
//  DayIconImageSaved.swift
//  Ichthys Calendar
//
//  Created by Viktor on 24.11.2020.
//

import SwiftUI

struct DayIconImageSaved: View {
    let image: UIImage
    
    var body: some View {
        ZStack {
            Constant.gradientOrange
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(3)
                .clipped()
        }
        .frame(width: 120, height: 120)
        .cornerRadius(5)
    }
}
