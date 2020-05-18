//
//  NSPRTPlayerRenderingView.swift
//  NSPRTVideoPlayer
//
//  Created by Chaz Woodall on 3/19/19.
//  Copyright © 2019 NSPRT. All rights reserved.
//

import UIKit
import AVKit

open class NSPRTPlayerRenderingView: UIView {
    /// NSPRTVideoPlayer instance used to render player content
    public var renderingLayer: NSPRTVideoPlayerLayer!
    
    /// NSPRTVideoPlayer instance being rendered by renderingLayer
    public weak var player: NSPRTVideoPlayerView!
    
    /// Constructor
    ///
    /// - Parameters:
    ///     - player: NSPRTVideoPlayer instance to render.
    public init(with player: NSPRTVideoPlayerView) {
        super.init(frame: CGRect.zero)
        self.initializeRenderingLayer(with: player)
        self.player = player
    }
    
    private func initializeRenderingLayer(with player: NSPRTVideoPlayerView) {
        self.renderingLayer = NSPRTVideoPlayerLayer(with: player)
        self.layer.addSublayer(self.renderingLayer.playerLayer)
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        self.renderingLayer.playerLayer.frame = bounds
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
