//
//  NSPRTVideoPlayerControlsCoordinator.swift
//  NSPRTVideoPlayer
//
//  Created by Chaz Woodall on 3/19/19.
//  Copyright © 2019 NSPRT. All rights reserved.
//

import UIKit
import CoreMedia
import AVFoundation

open class NSPRTVideoPlayerControlsCoordinator: UIView, NSPRTVideoPlayerGestureRecieverViewDelegate {
    /// NSPRTVideoPlayer instance being used
    weak var player: NSPRTVideoPlayerView!
    
    /// NSPRTVideoPlayerControls instance being used
    weak public var controls: NSPRTVideoPlayerControls!
    
    /// NSPRTVideoPlayerGestureRecieverView instance being used
    public var gestureReciever: NSPRTVideoPlayerGestureRecieverView!
    
    open override func didMoveToSuperview() {
        super.didMoveToSuperview()
        configureView()
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        stretchToEdges()
    }
    
    public func configureView() {
        guard let h = superview as? NSPRTVideoPlayerView else { return }
        stretchToEdges()
        player = h
        if controls != nil {
            addSubview(controls)
        }
        
        guard gestureReciever == nil else { return }
        gestureReciever = NSPRTVideoPlayerGestureRecieverView()
        gestureReciever.delegate = self
        addSubview(gestureReciever)
        sendSubviewToBack(gestureReciever)
    }
    
    public func stretchToEdges() {
        guard let parent = superview else { return }
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: parent.topAnchor),
            leftAnchor.constraint(equalTo: parent.leftAnchor),
            rightAnchor.constraint(equalTo: parent.rightAnchor),
            bottomAnchor.constraint(equalTo: parent.bottomAnchor)
            ])
    }
    
    /// Notifies when pinch was recognized
    ///
    /// - Parameters:
    ///     - scale: CGFloat value
    open func didPinch(with scale: CGFloat) {}
    
    /// Notifies when tap was recognized
    ///
    /// - Parameters:
    ///     - point: CGPoint at which tap was recognized
    open func didTap(at point: CGPoint) {
        if controls.behaviour.showingControls {
            controls.behaviour.hide()
        } else {
            controls.behaviour.show()
        }
    }
    
    /// Notifies when tap was recognized
    ///
    /// - Parameters:
    ///     - point: CGPoint at which tap was recognized
    open func didDoubleTap(at point: CGPoint) {
        if player.renderingView.renderingLayer.playerLayer.videoGravity == AVLayerVideoGravity.resizeAspect {
            player.renderingView.renderingLayer.playerLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        } else {
            player.renderingView.renderingLayer.playerLayer.videoGravity = AVLayerVideoGravity.resizeAspect
        }
    }
    
    /// Notifies when pan was recognized
    ///
    /// - Parameters:
    ///     - translation: translation of pan in CGPoint representation
    ///     - at: initial point recognized
    open func didPan(with translation: CGPoint, initially at: CGPoint) {}
}
