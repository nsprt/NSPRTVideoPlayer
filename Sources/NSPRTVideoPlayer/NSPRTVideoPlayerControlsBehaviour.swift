//
//  NSPRTVideoPlayerControlsBehaviour.swift
//  NSPRTVideoPlayer
//
//  Created by Chaz Woodall on 3/19/19.
//  Copyright © 2019 NSPRT. All rights reserved.
//

import UIKit

open class NSPRTVideoPlayerControlsBehaviour {
    /// NSPRTVideoPlayerControls instance being controlled
    public weak var controls: NSPRTVideoPlayerControls!
    
    /// Whether controls are being displayed
    public var showingControls: Bool = true
    
    /// Whether controls should be hidden when showingControls is true
    public var shouldHideControls: Bool = true
    
    /// Whether controls should be shown when showingControls is false
    public var shouldShowControls: Bool = true
    
    /// Elapsed time between controls being shown and current time
    public var elapsedTime: TimeInterval = 0
    
    /// Last time when controls were shown
    public var activationTime: TimeInterval = 0
    
    /// At which TimeInterval controls hide automatically
    public var deactivationTimeInterval: TimeInterval = 3
    
    /// Custom deactivation block
    public var deactivationBlock: ((NSPRTVideoPlayerControls) -> Void)? = nil
    
    /// Custom activation block
    public var activationBlock: ((NSPRTVideoPlayerControls) -> Void)? = nil
    
    /// Constructor
    ///
    /// - Parameters:
    ///     - controls: NSPRTVideoPlayerControls to be controlled.
    public init(with controls: NSPRTVideoPlayerControls) {
        self.controls = controls
    }
    
    /// Update UI based on time
    ///
    /// - Parameters:
    ///     - time: TimeInterval to check whether to update controls.
    open func update(with time: TimeInterval) {
        self.elapsedTime = time
        guard self.showingControls else { return }
        guard self.shouldHideControls else { return }
        guard !self.controls.handler.player.isBuffering else { return }
        guard !self.controls.handler.isSeeking else { return }
        guard self.controls.handler.isPlaying else { return }
        
        let timediff = self.elapsedTime - self.activationTime
        guard timediff >= self.deactivationTimeInterval else { return }
        self.hide()
    }
    
    /// Default activation block
    open func defaultActivationBlock() {
        self.controls.isHidden = false
        UIView.animate(withDuration: 0.3) {
            self.controls.alpha = 1
        }
    }
    
    /// Default deactivation block
    open func defaultDeactivationBlock() {
        UIView.animate(withDuration: 0.3, animations: {
            self.controls.alpha = 0
        }) {
            if $0 {
                self.controls.isHidden = true
            }
        }
    }
    
    /// Hide the controls
    open func hide() {
        self.deactivationBlock != nil ? self.deactivationBlock!(self.controls) : self.defaultDeactivationBlock()
        self.showingControls = false
    }
    
    /// Show the controls
    open func show() {
        guard self.shouldShowControls else { return }
        self.activationTime = self.elapsedTime
        
        if self.activationBlock != nil {
            self.activationBlock!(self.controls)
        } else {
            self.controls.skipForwardButton.isHidden = self.controls.handler.onStart
            self.controls.skipBackwardButton.isHidden = self.controls.handler.onStart
            self.controls.seekbarSlider.isHidden = self.controls.handler.onStart
            self.defaultActivationBlock()
        }
        
        self.showingControls = true
    }
}

