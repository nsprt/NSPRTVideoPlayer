//
//  PlayPauseButton.swift
//  
//
//  Created by Chaz Woodall on 5/18/20.
//

import UIKit

open class NSPRTVideoPlayerPlayPauseButton: NSPRTVideoPlayerStatefulButton {
    public var NSPRTButtonType: type? = .play
    public var isActive: Bool?
    
    private var shapeLayer = CAShapeLayer()
    private var blurView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.blurView.isUserInteractionEnabled = false
        self.layer.addSublayer(self.shapeLayer)
        self.insertSubview(self.blurView, at: 0)
        self.set(active: false)
    }
    
    open override func set(active: Bool? = nil) {
        if active == nil && self.isActive == nil {
            self.isActive = false
        } else if active != nil {
            self.isActive = active
        }
        
        self.shapeLayer.path = nil
        if let temp = self.isActive, temp {
            self.shapeLayer.path = self.pauseShapePath().cgPath
            self.shapeLayer.fillColor = UIColor(white: 0.0, alpha: 0.5).cgColor
        } else {
            self.shapeLayer.path = self.playShapePath().cgPath
            self.shapeLayer.fillColor = UIColor(white: 0.0, alpha: 0.5).cgColor
        }
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func playShapePath() -> UIBezierPath {
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: -10.85, y: -17.5))
        bezierPath.addLine(to: CGPoint(x: -10.85, y: -17.5))
        bezierPath.addCurve(to: CGPoint(x: -12.33, y: -16.04), controlPoint1: CGPoint(x: -11.67, y: -17.5), controlPoint2: CGPoint(x: -12.33, y: -16.85))
        bezierPath.addLine(to: CGPoint(x: -12.33, y: -16.04))
        bezierPath.addLine(to: CGPoint(x: -12.33, y: -0))
        bezierPath.addLine(to: CGPoint(x: -12.33, y: 16.04))
        bezierPath.addLine(to: CGPoint(x: -12.33, y: 16.04))
        bezierPath.addLine(to: CGPoint(x: -12.33, y: 16.04))
        bezierPath.addCurve(to: CGPoint(x: -10.85, y: 17.5), controlPoint1: CGPoint(x: -12.33, y: 16.85), controlPoint2: CGPoint(x: -11.67, y: 17.5))
        bezierPath.addLine(to: CGPoint(x: -10.85, y: 17.5))
        bezierPath.addCurve(to: CGPoint(x: -10, y: 17.24), controlPoint1: CGPoint(x: -10.55, y: 17.5), controlPoint2: CGPoint(x: -10.25, y: 17.41))
        bezierPath.addLine(to: CGPoint(x: -9.98, y: 17.23))
        bezierPath.addLine(to: CGPoint(x: 19.47, y: 1.32))
        bezierPath.addLine(to: CGPoint(x: 19.48, y: 1.32))
        bezierPath.addCurve(to: CGPoint(x: 20.33, y: -0), controlPoint1: CGPoint(x: 20, y: 1.08), controlPoint2: CGPoint(x: 20.33, y: 0.57))
        bezierPath.addLine(to: CGPoint(x: 20.33, y: -0))
        bezierPath.addCurve(to: CGPoint(x: 19.43, y: -1.34), controlPoint1: CGPoint(x: 20.33, y: -0.59), controlPoint2: CGPoint(x: 19.98, y: -1.11))
        bezierPath.addLine(to: CGPoint(x: -9.98, y: -17.23))
        bezierPath.addLine(to: CGPoint(x: -9.99, y: -17.23))
        bezierPath.addLine(to: CGPoint(x: -10, y: -17.24))
        bezierPath.addCurve(to: CGPoint(x: -10.85, y: -17.5), controlPoint1: CGPoint(x: -10.25, y: -17.41), controlPoint2: CGPoint(x: -10.54, y: -17.5))
        bezierPath.close()
        return bezierPath
    }
    
    private func pauseShapePath() -> UIBezierPath {
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: -11.28, y: -17.5))
        bezierPath.addCurve(to: CGPoint(x: -14.5, y: -14.32), controlPoint1: CGPoint(x: -13.06, y: -17.5), controlPoint2: CGPoint(x: -14.5, y: -16.08))
        bezierPath.addLine(to: CGPoint(x: -14.5, y: 14.32))
        bezierPath.addCurve(to: CGPoint(x: -11.28, y: 17.5), controlPoint1: CGPoint(x: -14.5, y: 16.08), controlPoint2: CGPoint(x: -13.06, y: 17.5))
        bezierPath.addLine(to: CGPoint(x: -8.06, y: 17.5))
        bezierPath.addCurve(to: CGPoint(x: -4.83, y: 14.32), controlPoint1: CGPoint(x: -6.28, y: 17.5), controlPoint2: CGPoint(x: -4.83, y: 16.08))
        bezierPath.addLine(to: CGPoint(x: -4.83, y: -14.32))
        bezierPath.addCurve(to: CGPoint(x: -8.06, y: -17.5), controlPoint1: CGPoint(x: -4.83, y: -16.08), controlPoint2: CGPoint(x: -6.28, y: -17.5))
        bezierPath.addLine(to: CGPoint(x: -11.28, y: -17.5))
        bezierPath.close()
        bezierPath.move(to: CGPoint(x: 8.06, y: -17.5))
        bezierPath.addCurve(to: CGPoint(x: 4.83, y: -14.32), controlPoint1: CGPoint(x: 6.28, y: -17.5), controlPoint2: CGPoint(x: 4.83, y: -16.08))
        bezierPath.addLine(to: CGPoint(x: 4.83, y: 14.32))
        bezierPath.addCurve(to: CGPoint(x: 8.06, y: 17.5), controlPoint1: CGPoint(x: 4.83, y: 16.08), controlPoint2: CGPoint(x: 6.28, y: 17.5))
        bezierPath.addLine(to: CGPoint(x: 11.28, y: 17.5))
        bezierPath.addCurve(to: CGPoint(x: 14.5, y: 14.32), controlPoint1: CGPoint(x: 13.06, y: 17.5), controlPoint2: CGPoint(x: 14.5, y: 16.08))
        bezierPath.addLine(to: CGPoint(x: 14.5, y: -14.32))
        bezierPath.addCurve(to: CGPoint(x: 11.28, y: -17.5), controlPoint1: CGPoint(x: 14.5, y: -16.08), controlPoint2: CGPoint(x: 13.06, y: -17.5))
        bezierPath.addLine(to: CGPoint(x: 8.06, y: -17.5))
        bezierPath.close()
        return bezierPath
    }
    
    override open func layoutSubviews() {
        if NSPRTButtonType == .play {
            self.blurView.frame = bounds
            self.blurView.layer.cornerRadius = frame.width / 2
            self.blurView.layer.masksToBounds = true
            self.shapeLayer.position = CGPoint(x: self.frame.width / 2.0, y: self.frame.width / 2.0)
        } else {
            super.layoutSubviews()
        }
    }
}

