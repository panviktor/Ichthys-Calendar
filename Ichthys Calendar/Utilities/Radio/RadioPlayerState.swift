//
//  RadioPlayerState.swift
//  Ichthys Calendar
//
//  Created by Viktor on 20.12.2020.
//

import Foundation

@objc  enum RadioPlayerState: Int {
    /// URL not set
    case urlNotSet
    /// Player is ready to play
    case readyToPlay
    /// Player is loading
    case loading
    /// The loading has finished
    case loadingFinished
    /// Error with playing
    case error
    
    /// Return a readable description
     var description: String {
        switch self {
        case .urlNotSet: return "URL is not set"
        case .readyToPlay: return "Ready to play"
        case .loading: return "Loading"
        case .loadingFinished: return "Loading finished"
        case .error: return "Error"
        }
    }
}
