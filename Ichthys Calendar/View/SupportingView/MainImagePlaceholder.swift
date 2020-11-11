//
//  MainImagePlaceholder.swift
//  Ichthys Calendar
//
//  Created by Viktor on 11.11.2020.
//

import SwiftUI

struct MainImagePlaceholder: View {
    let gradient = LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)), Color(#colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing)
    
    var body: some View {
        ZStack {
            gradient
        Image(systemName: "person.crop.square")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 100, height: 100)
            .clipped()
            .cornerRadius(5)
            .padding(5)
            .background(RoundedRectangle(cornerRadius: 5)
                            .stroke(gradient, lineWidth: 5)
                            .saturation(1.8))
            gradient
                .opacity(0.55)
        }
    }
}

struct MainImagePlaceholder_Previews: PreviewProvider {
    static var previews: some View {
        MainImagePlaceholder()
    }
}
