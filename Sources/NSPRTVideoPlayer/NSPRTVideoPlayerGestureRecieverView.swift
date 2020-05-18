//
//  NSPRTVideoPlayerGestureRecieverView.swift
//  NSPRTVideoPlayer
//
//  Created by Chaz Woodall on 3/19/19.
//  Copyright © 2019 NSPRT. All rights reserved.
//

import UIKit

open class NSPRTVideoPlayerGestureRecieverView: UIView {
    /// NSPRTVideoPlayerGestureRecieverViewDelegate instance
    public weak var delegate: NSPRTVideoPlayerGestureRecieverViewDelegate? = nil
    
    /// Single tap UITapGestureRecognizer
    public var tapGesture: UITapGestureRecognizer? = nil
    
    /// Double tap UITapGestureRecognizer
    public var doubleTapGesture: UITapGestureRecognizer? = nil
    
    /// UIPanGestureRecognizer
    public var panGesture: UIPanGestureRecognizer? = nil
    
    /// UIPinchGestureRecognizer
    public var pinchGesture: UIPinchGestureRecognizer? = nil
    
    /// Whether or not reciever view is ready
    public var ready: Bool = false
    
    /// Pan gesture initial point
    public var panGestureInitialPoint: CGPoint = CGPoint.zero
    
    override open func didMoveToSuperview() {
        super.didMoveToSuperview()
        translatesAutoresizingMaskIntoConstraints = false
        guard let parent = superview else { return }
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: parent.topAnchor),
            leftAnchor.constraint(equalTo: parent.leftAnchor),
            rightAnchor.constraint(equalTo: parent.rightAnchor),
            bottomAnchor.constraint(equalTo: parent.bottomAnchor)
            ])
        
        if !ready {
            prepare()
        }
    }
    
    /// Prepare the view gesture recognizers
    open func prepare() {
        ready = true
        isUserInteractionEnabled = true
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapHandler(with:)))
        tapGesture?.numberOfTapsRequired = 1
        
        doubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(doubleTapHandler(with:)))
        doubleTapGesture?.numberOfTapsRequired = 2
        
        tapGesture?.require(toFail: doubleTapGesture!)
        
        pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(pinchHandler(with:)))
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(panHandler(with:)))
        panGesture?.minimumNumberOfTouches = 1
        
        addGestureRecognizer(tapGesture!)
        addGestureRecognizer(doubleTapGesture!)
        addGestureRecognizer(panGesture!)
        addGestureRecognizer(pinchGesture!)
    }
    
    
    @objc open func tapHandler(with sender: UITapGestureRecognizer) {
        delegate?.didTap(at: sender.location(in: self))
    }
    
    @objc open func doubleTapHandler(with sender: UITapGestureRecognizer) {
        delegate?.didDoubleTap(at: sender.location(in: self))
    }
    
    @objc open func pinchHandler(with sender: UIPinchGestureRecognizer) {
        if sender.state == .ended {
            delegate?.didPinch(with: sender.scale)
        }
    }
    
    @objc open func panHandler(with sender: UIPanGestureRecognizer) {
        if sender.state == .began {
            panGestureInitialPoint = sender.location(in: self)
        }
        delegate?.didPan(with: sender.translation(in: self), initially: panGestureInitialPoint)
    }
}
