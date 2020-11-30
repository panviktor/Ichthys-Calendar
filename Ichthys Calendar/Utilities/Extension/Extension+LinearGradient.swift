//
//  Extension+LinearGradient.swift
//  Ichthys Calendar
//
//  Created by Viktor on 01.12.2020.
//

import SwiftUI

extension LinearGradient {
    init(_ colors: Color...) {
        self.init(gradient: Gradient(colors: colors), startPoint: .topLeading, endPoint: .bottomTrailing)
    }
}
