//
//  MainImagePlaceholder.swift
//  Ichthys Calendar
//
//  Created by Viktor on 11.11.2020.
//

import SwiftUI

struct MainImagePlaceholder: View {
    var body: some View {
        ZStack {
            Constant.gradient
        Image(systemName: "person.crop.square")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .clipped()
            .cornerRadius(5)
            .padding(5)
            .background(RoundedRectangle(cornerRadius: 5)
                            .stroke(Constant.gradient, lineWidth: 5)
                            .saturation(1.8))
            Constant.gradient
                .opacity(0.55)
        }
        .frame(width: 120, height: 120)
    }
}

struct MainImagePlaceholder_Previews: PreviewProvider {
    static var previews: some View {
        MainImagePlaceholder()
    }
}
