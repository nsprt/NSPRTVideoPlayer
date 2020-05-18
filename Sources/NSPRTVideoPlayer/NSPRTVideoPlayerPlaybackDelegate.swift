//
//  NSPRTPlayerPlaybackDelegate.swift
//  NSPRTVideoPlayer
//
//  Created by Chaz Woodall on 3/19/19.
//  Copyright © 2019 NSPRT. All rights reserved.
//

import AVFoundation

public protocol NSPRTVideoPlayerPlaybackDelegate: class {
    /// Notifies when playback time changes
    ///
    /// - Parameters:
    ///     - player: NSPRTVideoPlayer being used
    ///     - time: Current time
    func timeDidChange(player: NSPRTVideoPlayer, to time: CMTime)
    
    /// Whether if playback should begin on specified player
    ///
    /// - Parameters:
    ///     - player: NSPRTVideoPlayer being used
    ///
    /// - Returns: Boolean to validate if should play
    func playbackShouldBegin(player: NSPRTVideoPlayer) -> Bool
    
    /// Whether if playback is skipping frames
    ///
    /// - Parameters:
    ///     - player: NSPRTVideoPlayer being used
    func playbackDidJump(player: NSPRTVideoPlayer)
    
    /// Notifies when player will begin playback
    ///
    /// - Parameters:
    ///     - player: NSPRTVideoPlayer being used
    func playbackWillBegin(player: NSPRTVideoPlayer)
    
    /// Notifies when playback is ready to play
    ///
    /// - Parameters:
    ///     - player: NSPRTVideoPlayer being used
    func playbackReady(player: NSPRTVideoPlayer)
    
    /// Notifies when playback did begin
    ///
    /// - Parameters:
    ///     - player: NSPRTVideoPlayer being used
    func playbackDidBegin(player: NSPRTVideoPlayer)
    
    /// Notifies when player ended playback
    ///
    /// - Parameters:
    ///     - player: NSPRTVideoPlayer being used
    func playbackDidEnd(player: NSPRTVideoPlayer)
    
    /// Notifies when player starts buffering
    ///
    /// - Parameters:
    ///     - player: NSPRTVideoPlayer being used
    func startBuffering(player: NSPRTVideoPlayer)
    
    /// Notifies when player ends buffering
    ///
    /// - Parameters:
    ///     - player: NSPRTVideoPlayer being used
    func endBuffering(player: NSPRTVideoPlayer)
    
    /// Notifies when playback fails with an error
    ///
    /// - Parameters:
    ///     - error: playback error
    func playbackDidFailed(with error: NSPRTVideoPlayerPlaybackError)
    
    /// Notifies when player will pause playback
    ///
    /// - Parameters:
    ///     - player: NSPRTVideoPlayer being used
    func playbackWillPause(player: NSPRTVideoPlayer)
    
    /// Notifies when player did pause playback
    ///
    /// - Parameters:
    ///     - player: NSPRTVideoPlayer being used
    func playbackDidPause(player: NSPRTVideoPlayer)
    
}

/// Making Delegate methods optional
public extension NSPRTVideoPlayerPlaybackDelegate {
    func timeDidChange(player: NSPRTVideoPlayer, to time: CMTime) {}
    
    func playbackShouldBegin(player: NSPRTVideoPlayer) -> Bool { return true }
    
    func playbackDidJump(player: NSPRTVideoPlayer) {}
    
    func playbackWillBegin(player: NSPRTVideoPlayer) {}
    
    func playbackReady(player: NSPRTVideoPlayer) {}
    
    func playbackDidBegin(player: NSPRTVideoPlayer) {}
    
    func playbackDidEnd(player: NSPRTVideoPlayer) {}
    
    func startBuffering(player: NSPRTVideoPlayer) {}
    
    func endBuffering(player: NSPRTVideoPlayer) {}
    
    func playbackDidFailed(with error: NSPRTVideoPlayerPlaybackError) {}
    
    func playbackWillPause(player: NSPRTVideoPlayer) {}
    
    func playbackDidPause(player: NSPRTVideoPlayer) {}
}
