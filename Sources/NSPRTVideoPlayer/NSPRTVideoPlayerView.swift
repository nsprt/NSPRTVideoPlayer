//
//  NSPRTVideoPlayerView.swift
//  NSPRTVideoPlayer
//
//  Created by Chaz Woodall on 3/19/19.
//  Copyright © 2019 NSPRT. All rights reserved.
//

import AVFoundation
import AVKit
import CoreMedia
import UIKit

public typealias PIPProtocol = AVPictureInPictureControllerDelegate

open class NSPRTVideoPlayerView: UIView, PIPProtocol {
    /// AVPlayer used in NSPRTVideoPlayer implementation
    public var player: NSPRTVideoPlayer!
    
    /// NSPRTVideoPlayerControls instance being used to display controls
    public var controls: NSPRTVideoPlayerControls?
    
    /// NSPRTVideoPlayerPlaybackDelegate instance
    public weak var playbackDelegate: NSPRTVideoPlayerPlaybackDelegate?
    
    /// NSPRTPlayerRenderingView instance
    public var renderingView: NSPRTPlayerRenderingView!
    
    /// NSPRTVideo initial container
    private weak var nonFullscreenContainer: UIView!
    
    /// AVPictureInPictureController instance
    public var pipController: AVPictureInPictureController?
    
    /// Whether player is prepared
    public var ready: Bool = false
    
    /// When player is ready it will seek to 25% of duration for preview image
    public var shouldSeekForPreview = true
    
    /// When this is true the player is fresh off initialization
    public var onStart = true
    
    /// Whether it should autoplay when adding a PlayerItem
    public var autoplay: Bool = false
    
    /// Whether Player is currently playing
    public var isPlaying: Bool = false
    
    /// Whether Player is seeking time
    public var isSeeking: Bool = false
    
    /// Whether video is muted
    public var isMuted: Bool = false
    
    /// Whether Player is presented in Fullscreen
    public var isFullscreenModeEnabled: Bool = false
    
    /// Whether PIP Mode is enabled via pipController
    public var isPipModeEnabled: Bool = false
    
    /// Whether Player is Fast Forwarding
    public var isForwarding: Bool {
        return self.player.rate > 1
    }
    
    /// Whether Player is Rewinding
    public var isRewinding: Bool {
        return self.player.rate < 0
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.prepare()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.prepare()
    }
    
    /// NSPRTVideoControls instance to display controls in player, using NSPRTVideoPlayerGestureRecieverView instance
    /// to handle gestures
    ///
    /// - Parameters:
    ///     - controls: NSPRTVideoControls instance used to display controls
    ///     - gestureReciever: Optional gesture reciever view to be used to recieve gestures
    public func use(controls: NSPRTVideoPlayerControls, with gestureReciever: NSPRTVideoPlayerGestureRecieverView? = nil) {
        self.controls = controls
        let coordinator = NSPRTVideoPlayerControlsCoordinator()
        coordinator.player = self
        coordinator.controls = controls
        coordinator.gestureReciever = gestureReciever
        controls.controlsCoordinator = coordinator
        addSubview(coordinator)
        bringSubviewToFront(coordinator)
    }
    
    /// Update controls to specified time
    ///
    /// - Parameters:
    ///     - time: Time to be updated to
    public func updateControls(toTime time: CMTime) {
        self.controls?.timeDidChange(toTime: time)
    }
    
    /// Prepares the player to play
    open func prepare() {
        self.ready = true
        self.player = NSPRTVideoPlayer()
        self.player.handler = self
        self.player.preparePlayerPlaybackDelegate()
        self.layer.backgroundColor = UIColor.black.cgColor
        self.renderingView = NSPRTPlayerRenderingView(with: self)
        self.layout(view: self.renderingView, into: self)
    }
    
    /// Layout a view within another view stretching to edges
    ///
    /// - Parameters:
    ///     - view: The view to layout.
    ///     - into: The container view.
    open func layout(view: UIView, into: UIView? = nil) {
        guard let into = into else { return }
        
        into.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: into.topAnchor),
            view.leftAnchor.constraint(equalTo: into.leftAnchor),
            view.rightAnchor.constraint(equalTo: into.rightAnchor),
            view.bottomAnchor.constraint(equalTo: into.bottomAnchor)
            ])
    }
    
    /// Enables or disables PIP when available (when device is supported)
    ///
    /// - Parameters:
    ///     - enabled: Whether or not to enable
    open func setNativePip(enabled: Bool) {
        guard self.pipController == nil && renderingView != nil else { return }
        let controller = AVPictureInPictureController(playerLayer: self.renderingView!.renderingLayer.playerLayer)
        controller?.delegate = self
        self.pipController = controller
        enabled ? self.pipController?.startPictureInPicture() : self.pipController?.stopPictureInPicture()
    }
    
    /// Enables or disables fullscreen
    ///
    /// - Parameters:
    ///     - enabled: Whether or not to enable
    open func setFullscreen(enabled: Bool) {
        guard enabled != self.isFullscreenModeEnabled else { return }
        if enabled {
            guard let window = UIApplication.shared.keyWindow else { return }
            self.nonFullscreenContainer = self.superview
            self.removeFromSuperview()
            
            let value = UIInterfaceOrientation.landscapeRight.rawValue
            UIDevice.current.setValue(value, forKey: "orientation")
            self.layout(view: self, into: window)
        } else {
            self.removeFromSuperview()
            let value = UIInterfaceOrientation.portrait.rawValue
            UIDevice.current.setValue(value, forKey: "orientation")
            self.layout(view: self, into: self.nonFullscreenContainer)
        }
        
        self.isFullscreenModeEnabled = enabled
    }
    
    /// Sets the item to be played
    ///
    /// - Parameters:
    ///     - item: The NSPRTPlayerItem instance to add to player.
    open func set(item: NSPRTPlayerItem?) {
        if !ready {
            prepare()
        }
        
        player.replaceCurrentItem(with: item)
        if shouldSeekForPreview {
            player.seek(to: CMTimeMake(value: 30, timescale: 1))
        }
        
        if autoplay && item?.error == nil {
            play()
        }
    }
    
    /// Play
    open func play(sender: Any? = nil) {
        guard playbackDelegate?.playbackShouldBegin(player: player) ?? true else { return }
        if onStart {
            player.seek(to: player.startTime())
            onStart = false
        }
        
        player.play()
        controls?.playPauseButton.set(active: true)
        isPlaying = true
    }
    
    /// Pause
    open func pause(sender: Any? = nil) {
        self.player.pause()
        self.controls?.playPauseButton.set(active: false)
        self.isPlaying = false
    }
    
    /// Toggle Playback
    open func togglePlayback(sender: Any? = nil) {
        self.isPlaying ? self.pause() : self.play()
    }
    
    open func reset() {
        self.onStart = true
        self.setFullscreen(enabled: false)
        if self.shouldSeekForPreview {
            self.player.seek(to: CMTimeMake(value: 30, timescale: 1))
        }
        self.controls?.behaviour.show()
    }
    
    open func pictureInPictureControllerDidStopPictureInPicture(_ pictureInPictureController: AVPictureInPictureController) {
        print("stopped")
        //hide fallback
    }
    
    open func pictureInPictureControllerDidStartPictureInPicture(_ pictureInPictureController: AVPictureInPictureController) {
        print("started")
        //show fallback
    }
    
    open func pictureInPictureControllerWillStopPictureInPicture(_ pictureInPictureController: AVPictureInPictureController) {
        self.isPipModeEnabled = false
        self.controls?.controlsCoordinator.isHidden = false
    }
    
    open func pictureInPictureControllerWillStartPictureInPicture(_ pictureInPictureController: AVPictureInPictureController) {
        self.controls?.controlsCoordinator.isHidden = true
        self.isPipModeEnabled = true
    }
    
    public func pictureInPictureController(_ pictureInPictureController: AVPictureInPictureController, failedToStartPictureInPictureWithError error: Error) {
        print(error.localizedDescription)
    }
    
    public func pictureInPictureController(_ pictureInPictureController: AVPictureInPictureController, restoreUserInterfaceForPictureInPictureStopWithCompletionHandler completionHandler: @escaping (Bool) -> Void) {}
}
