//
//  BasicNeumorphicShadow.swift
//  Ichthys Calendar
//
//  Created by Viktor on 25.11.2020.
//

import SwiftUI

struct BasicNeumorphicShadow: ViewModifier {
    func body(content: Content) -> some View {
        return content
            .shadow(color: Color("LightShadow"), radius: 8, x: -8, y: -8)
            .shadow(color: Color("DarkShadow"), radius: 8, x: 8, y: 8)
            .blendMode(.hue)
    }
}
