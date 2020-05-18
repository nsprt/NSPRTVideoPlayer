//
//  NSPRTVideoPlayerStatefulButton.swift
//  NSPRTVideoPlayer
//
//  Created by Chaz Woodall on 3/19/19.
//  Copyright © 2019 NSPRT. All rights reserved.
//

import UIKit

public typealias Button = UIButton

open class NSPRTVideoPlayerStatefulButton: Button {
    public enum type {
        case play
    }
    
    public var activeImage: UIImage?
    public var inactiveImage: UIImage? {
        didSet {
            self.setImage(self.inactiveImage, for: .normal)
        }
    }
    
    open func set(active: Bool) {
        if active {
            self.setImage(self.activeImage, for: .normal)
        } else {
            self.setImage(self.inactiveImage, for: .normal)
        }
    }
}
