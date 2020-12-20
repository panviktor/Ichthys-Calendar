//
//  RadioPlayerDelegate.swift
//  Ichthys Calendar
//
//  Created by Viktor on 20.12.2020.
//

import Foundation

/**
 The `RadioPlayerDelegate` protocol defines methods you can implement to respond to playback events associated with an `RadioPlayer` object.
 */

@objc protocol RadioPlayerDelegate {
    /**
     Called when player changes state
     - parameter player: RadioPlayer
     - parameter state: RadioPlayerState
     */
    func radioPlayer(_ player: RadioPlayer, playerStateDidChange state: RadioPlayerState)
    /**
     Called when the player changes the playing state
     - parameter player: RadioPlayer
     - parameter state: RadioPlaybackState
     */
    func radioPlayer(_ player: RadioPlayer, playbackStateDidChange state: RadioPlaybackState)
    /**
     Called when player changes the current player item
     - parameter player: RadioPlayer
     - parameter url: Radio URL
     */
    @objc optional func radioPlayer(_ player: RadioPlayer, itemDidChange url: URL?)
    /**
     Called when player item changes the timed metadata value, it uses (separatedBy: " - ") to get the artist/song name, if you want more control over the raw metadata, consider using `metadataDidChange rawValue` instead
     
     - parameter player: RadioPlayer
     - parameter artistName: The artist name
     - parameter trackName: The track name
     */
    @objc optional func radioPlayer(_ player: RadioPlayer, metadataDidChange artistName: String?, trackName: String?)
    /**
     Called when player item changes the timed metadata value
     - parameter player: RadioPlayer
     - parameter rawValue: metadata raw value
     */
    @objc optional func radioPlayer(_ player: RadioPlayer, metadataDidChange rawValue: String?)
    /**
     Called when the player gets the artwork for the playing song
     - parameter player: RadioPlayer
     - parameter artworkURL: URL for the artwork from iTunes
     */
    @objc optional func radioPlayer(_ player: RadioPlayer, artworkDidChange artworkURL: URL?)
}
