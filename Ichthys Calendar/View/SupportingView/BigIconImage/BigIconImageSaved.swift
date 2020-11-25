//
//  BigIconImageSaved.swift
//  Ichthys Calendar
//
//  Created by Viktor on 24.11.2020.
//

import SwiftUI

struct BigIconImageSaved: View {
    let image: UIImage
    
    var body: some View {
        ZStack {
            Constant.gradientOrange
            Image(uiImage: image)
                .resizable()
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
