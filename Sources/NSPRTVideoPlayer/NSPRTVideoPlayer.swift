//
//  NSPRTVideoPlayer.swift
//  NSPRTVideoPlayer
//
//  Created by Chaz Woodall on 3/19/19.
//  Copyright © 2019 NSPRT. All rights reserved.
//

import AVFoundation

public typealias NSPRTPlayerItem = AVPlayerItem

open class NSPRTVideoPlayer: AVPlayer, AVAssetResourceLoaderDelegate {
    private let queue = DispatchQueue(label: "NSPRT.videoplayer")
    
    /// Notification key to extract info
    public enum PlayerNotificationInfoKey: String {
        case time = "NSPRT_PLAYER_TIME"
    }
    
    /// Notification name to post
    public enum PlayerNotificationName: String {
        case assetLoaded = "NSPRT_ASSET_ADDED"
        case timeChanged = "NSPRT_TIME_CHANGED"
        case willPlay = "NSPRT_PLAYER_STATE_WILL_PLAY"
        case play = "NSPRT_PLAYER_STATE_PLAY"
        case pause = "NSPRT_PLAYER_STATE_PAUSE"
        case buffering = "NSPRT_PLAYER_BUFFERING"
        case endBuffering = "NSPRT_PLAYER_END_BUFFERING"
        case didEnd = "NSPRT_PLAYER_END_PLAYING"
        
        /// Notification name representation
        public var notification: Notification.Name {
            return Notification.Name(self.rawValue)
        }
    }
    
    public weak var handler: NSPRTVideoPlayerView!
    public var isBuffering: Bool = false
    
    /// Play content
    override open func play() {
        handler.playbackDelegate?.playbackWillBegin(player: self)
        NotificationCenter.default.post(name: PlayerNotificationName.willPlay.notification, object: self, userInfo: nil)
        
        guard handler.playbackDelegate?.playbackShouldBegin(player: self) ?? true else { return }
        NotificationCenter.default.post(name: PlayerNotificationName.play.notification, object: self, userInfo: nil)
        super.play()
        handler.playbackDelegate?.playbackDidBegin(player: self)
    }
    
    /// Pause content
    override open func pause() {
        handler.playbackDelegate?.playbackWillPause(player: self)
        NotificationCenter.default.post(name: PlayerNotificationName.pause.notification, object: self, userInfo: nil)
        super.pause()
        handler.playbackDelegate?.playbackDidPause(player: self)
    }
    
    /// Replace current item with a new one
    ///
    /// - Parameters:
    ///     - item: AVPlayer item instance to be added
    override open func replaceCurrentItem(with item: AVPlayerItem?) {
        super.pause()
        if let asset = item?.asset as? AVURLAsset {
            asset.resourceLoader.setDelegate(self, queue: queue)
        }
        
        if currentItem != nil {
            currentItem!.removeObserver(self, forKeyPath: "playbackBufferEmpty")
            currentItem!.removeObserver(self, forKeyPath: "playbackLikelyToKeepUp")
            currentItem!.removeObserver(self, forKeyPath: "playbackBufferFull")
            currentItem!.removeObserver(self, forKeyPath: "status")
        }
        
        super.replaceCurrentItem(with: item)
        NotificationCenter.default.post(name: PlayerNotificationName.assetLoaded.notification, object: self, userInfo: nil)
        if item != nil {
            currentItem!.addObserver(self, forKeyPath: "playbackBufferEmpty", options: .new, context: nil)
            currentItem!.addObserver(self, forKeyPath: "playbackLikelyToKeepUp", options: .new, context: nil)
            currentItem!.addObserver(self, forKeyPath: "playbackBufferFull", options: .new, context: nil)
            currentItem!.addObserver(self, forKeyPath: "status", options: .new, context: nil)
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: Notification.Name.AVPlayerItemTimeJumped, object: self)
        NotificationCenter.default.removeObserver(self, name: Notification.Name.AVPlayerItemDidPlayToEndTime, object: self)
    }
}

extension NSPRTVideoPlayer {
    /// Start time
    ///
    /// - Returns: Player's current item start time as CMTime
    open func startTime() -> CMTime {
        guard let item = currentItem else {
            return CMTime(seconds: 0, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
        }
        
        guard item.reversePlaybackEndTime.isValid else {
            return CMTime(seconds: 0, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
        }
        
        return item.reversePlaybackEndTime
    }
    
    /// End time
    ///
    /// - Returns: Player's current item end time as CMTime
    open func endTime() -> CMTime {
        guard let item = currentItem else {
            return CMTime(seconds: 0, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
        }
        
        if item.forwardPlaybackEndTime.isValid {
            return item.forwardPlaybackEndTime
        } else {
            guard item.duration.isValid && !item.duration.isIndefinite else {
                return item.currentTime()
            }
            
            return item.duration
        }
    }
    
    /// Prepare players playback delegate observers
    open func preparePlayerPlaybackDelegate() {
        NotificationCenter.default.addObserver(forName: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: nil, queue: OperationQueue.main) { [weak self] (notification) in
            guard let self = self else { return }
            NotificationCenter.default.post(name: PlayerNotificationName.didEnd.notification, object: self, userInfo: nil)
            self.handler?.reset()
            self.handler?.playbackDelegate?.playbackDidEnd(player: self)
        }
        NotificationCenter.default.addObserver(forName: NSNotification.Name.AVPlayerItemTimeJumped, object: self, queue: OperationQueue.main) { [weak self] (notification) in
            guard let self = self else { return }
            self.handler?.playbackDelegate?.playbackDidJump(player: self)
        }
        addPeriodicTimeObserver(
            forInterval: CMTime(
                seconds: 1,
                preferredTimescale: CMTimeScale(NSEC_PER_SEC)
            ),
            queue: DispatchQueue.main) { [weak self] (time) in
                guard let self = self else { return }
                NotificationCenter.default.post(name: PlayerNotificationName.timeChanged.notification, object: self, userInfo: [PlayerNotificationInfoKey.time.rawValue: time])
                self.handler?.playbackDelegate?.timeDidChange(player: self, to: time)
        }
        
        addObserver(self, forKeyPath: "status", options: NSKeyValueObservingOptions.new, context: nil)
    }
    
    /// Value observer
    override open func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if let obj = object as? NSPRTVideoPlayer, obj == self {
            guard keyPath == "status" else { return }
            switch status {
            case AVPlayer.Status.readyToPlay:
                handler.playbackDelegate?.playbackReady(player: self)
            case AVPlayer.Status.failed:
                handler.playbackDelegate?.playbackDidFailed(with: NSPRTVideoPlayerPlaybackError.unknown)
            default:
                break
            }
        } else {
            switch keyPath ?? "" {
            case "status":
                guard let value = change?[.newKey] as? Int else { return }
                guard let status = AVPlayerItem.Status(rawValue: value) else { return }
                guard let item = object as? AVPlayerItem else { return }
                
                guard status == .failed else { return }
                guard let error = item.error as NSError? else { return }
                guard let underlyingError = error.userInfo[NSUnderlyingErrorKey] as? NSError else { return }
                let playbackError: NSPRTVideoPlayerPlaybackError
                
                switch underlyingError.code {
                case -12937:
                    playbackError = .authenticationError
                case -16840:
                    playbackError = .unauthorized
                case -12660:
                    playbackError = .forbidden
                case -12938:
                    playbackError = .notFound
                case -12661:
                    playbackError = .unavailable
                case -12645, -12889:
                    playbackError = .mediaFileError
                case -12318:
                    playbackError = .bandwidthExceeded
                case -12642:
                    playbackError = .playlistUnchanged
                case -12911:
                    playbackError = .decoderMalfunction
                case -12913:
                    playbackError = .decoderTemporarilyUnavailable
                case -1004:
                    playbackError = .wrongHostIP
                case -1003:
                    playbackError = .wrongHostDNS
                case -1000:
                    playbackError = .badURL
                case -1202:
                    playbackError = .invalidRequest
                default:
                    playbackError = .unknown
                }
                
                handler.playbackDelegate?.playbackDidFailed(with: playbackError)
            case "playbackBufferEmpty":
                isBuffering = true
                NotificationCenter.default.post(name: PlayerNotificationName.buffering.notification, object: self, userInfo: nil)
                handler.playbackDelegate?.startBuffering(player: self)
            case "playbackLikelyToKeepUp":
                isBuffering = false
                NotificationCenter.default.post(name: PlayerNotificationName.endBuffering.notification, object: self, userInfo: nil)
                handler.playbackDelegate?.endBuffering(player: self)
            case "playbackBufferFull":
                isBuffering = false
                NotificationCenter.default.post(name: PlayerNotificationName.endBuffering.notification, object: self, userInfo: nil)
                handler.playbackDelegate?.endBuffering(player: self)
            default:
                break
            }
        }
    }
}
