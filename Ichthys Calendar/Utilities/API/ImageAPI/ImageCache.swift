//
//  ImageCache.swift
//  Ichthys Calendar
//
//  Created by Viktor on 07.11.2020.
//

import SwiftUI

protocol ImageCache {
    subscript(_ url: URL) -> UIImage? { get set }
}
