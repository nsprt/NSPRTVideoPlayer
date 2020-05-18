//
//  NSPRTPlayerLayer.swift
//  NSPRTVideoPlayer
//
//  Created by Chaz Woodall on 3/19/19.
//  Copyright © 2019 NSPRT. All rights reserved.
//

import AVFoundation
import AVKit

open class NSPRTVideoPlayerLayer: CALayer {
    /// Player Layer to be used
    public var playerLayer: AVPlayerLayer!
    
    /// NSPRTVideoPlayer instance being rendered
    public weak var handler: NSPRTVideoPlayerView!
    
    override public init(layer: Any) {
        super.init(layer: layer)
    }
    
    override public init() {
        super.init()
    }
    
    public convenience init(with player: NSPRTVideoPlayerView) {
        self.init()
        playerLayer = AVPlayerLayer.init(player: player.player)
        addSublayer(playerLayer)
    }
    
    override open func layoutSublayers() {
        super.layoutSublayers()
        playerLayer.frame = bounds
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
