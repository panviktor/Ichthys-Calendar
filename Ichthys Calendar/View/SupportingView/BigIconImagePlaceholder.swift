//
//  BigIconImagePlaceholder.swift
//  Ichthys Calendar
//
//  Created by Viktor on 11.11.2020.
//

import SwiftUI

struct BigIconImagePlaceholder: View {
    let gradient = LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)), Color(#colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1))]),
                                  startPoint: .topLeading, endPoint: .bottomTrailing)
    var body: some View  {
        ZStack {
            gradient
                .opacity(0.5)
        }
    }
}