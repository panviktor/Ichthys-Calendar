//
//  TemporaryImageCache.swift
//  Ichthys Calendar
//
//  Created by Viktor on 07.11.2020.
//

import SwiftUI

struct TemporaryImageCache: ImageCache {
    private let cache = NSCache<NSURL, UIImage>()
    
    subscript(_ key: URL) -> UIImage? {
        get {
            cache.object(forKey: key as NSURL)
        }
        set {
            newValue == nil ? cache.removeObject(forKey: key as NSURL) : cache.setObject(newValue!, forKey: key as NSURL)
        }
    }
}

