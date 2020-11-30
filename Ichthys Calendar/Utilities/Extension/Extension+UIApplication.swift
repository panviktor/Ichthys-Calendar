//
//  Extension+UIApplication.swift
//  Ichthys Calendar
//
//  Created by Viktor on 30.11.2020.
//

import SwiftUI

extension UIApplication {
    var currentScene: UIWindowScene? {
        connectedScenes
            .first { $0.activationState == .foregroundActive } as? UIWindowScene
    }
}
