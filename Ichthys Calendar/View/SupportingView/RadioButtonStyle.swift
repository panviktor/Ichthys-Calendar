//
//  RadioButtonStyle.swift
//  Ichthys Calendar
//
//  Created by Viktor on 23.12.2020.
//

import SwiftUI

struct RadioButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding(25)
            .background(
                Group {
                    if configuration.isPressed {
                        RoundedRectangle(cornerRadius: 15.0)
                            .fill(Color.offWhite)
                            .shadow(color: Color.black.opacity(0.2), radius: 10, x: -5, y: -5)
                            .shadow(color: Color.white.opacity(0.7), radius: 10, x: 10, y: 10)
                    } else {
                        RoundedRectangle(cornerRadius: 15.0)
                            .fill(Color.offWhite)
                            .shadow(color: Color.black.opacity(0.2), radius: 10, x: 10, y: 10)
                            .shadow(color: Color.white.opacity(0.7), radius: 10, x: -5, y: -5)
                    }
                })
    }
}
