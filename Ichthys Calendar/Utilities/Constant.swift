//
//  Constant.swift
//  Ichthys Calendar
//
//  Created by Viktor on 19.11.2020.
//

import SwiftUI

struct Constant {
    static let gradientOrange = LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)), Color(#colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing)
    
    static let gradientBackground = LinearGradient(
        gradient: Gradient(colors: [Color("BackgroundOne"), Color("BackgroundSecond")]),
        startPoint: UnitPoint(x: 0.2, y: 0.2),
        endPoint: .bottomTrailing)
    
    static let appURL = "https://apps.apple.com/app/id1539134594"
    
    static let offWhite = Color(red: 225 / 255, green: 225 / 255, blue: 235 / 255)
    
    static let radioImage = UIImage(named: "defaultRadio")!
}
