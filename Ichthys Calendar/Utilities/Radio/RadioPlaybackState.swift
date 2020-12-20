//
//  RadioPlaybackState.swift
//  Ichthys Calendar
//
//  Created by Viktor on 20.12.2020.
//

import Foundation

@objc enum RadioPlaybackState: Int {
    /// Player is playing
    case playing
    /// Player is paused
    case paused
    /// Player is stopped
    case stopped
    
    /// Return a readable description
     var description: String {
        switch self {
        case .playing: return "Player is playing"
        case .paused: return "Player is paused"
        case .stopped: return "Player is stopped"
        }
    }
}
