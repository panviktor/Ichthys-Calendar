//
//  WaveShape.swift
//  Ichthys Calendar
//
//  Created by Viktor on 18.11.2020.
//

import SwiftUI

struct WaveShape : Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: .zero)
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addCurve(to: CGPoint(x: rect.minX, y: rect.maxY),
                              control1: CGPoint(x: rect.maxX * 0.65, y: rect.maxY * 0.4),
                              control2: CGPoint(x: rect.maxX * 0.35, y: rect.maxY * 2))
        return path
    }
}
