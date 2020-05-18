//
//  AudioButton.swift
//  
//
//  Created by Chaz Woodall on 5/18/20.
//

import UIKit

open class NSPRTVideoPlayerAudioButton: NSPRTVideoPlayerStatefulButton {
    public var NSPRTButtonType: type? = .none
    public var isActive: Bool?
    
    private let shapeLayer = CAShapeLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .clear
        self.layer.addSublayer(self.shapeLayer)
        self.set(active: true)
    }
    
    open override func set(active: Bool? = nil) {
        if active == nil && self.isActive == nil {
            self.isActive = false
        } else if active != nil {
            self.isActive = active
        }
        
        self.shapeLayer.path = nil
        if let temp = self.isActive, temp {
            self.shapeLayer.path = self.audioOnShapePath().cgPath
            self.shapeLayer.fillColor = UIColor(white: 1.0, alpha: 1.0).cgColor
        } else {
            self.shapeLayer.path = self.audioOffShapePath().cgPath
            self.shapeLayer.fillColor = UIColor(white: 1.0, alpha: 1.0).cgColor
        }
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func audioOnShapePath() -> UIBezierPath {
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: 8.37, y: -9.79))
        bezierPath.addLine(to: CGPoint(x: 8.37, y: -9.79))
        bezierPath.addCurve(to: CGPoint(x: 7.31, y: -8.77), controlPoint1: CGPoint(x: 7.79, y: -9.8), controlPoint2: CGPoint(x: 7.32, y: -9.34))
        bezierPath.addCurve(to: CGPoint(x: 7.54, y: -8.09), controlPoint1: CGPoint(x: 7.3, y: -8.52), controlPoint2: CGPoint(x: 7.39, y: -8.28))
        bezierPath.addCurve(to: CGPoint(x: 10.42, y: 0.26), controlPoint1: CGPoint(x: 9.34, y: -5.78), controlPoint2: CGPoint(x: 10.42, y: -2.89))
        bezierPath.addCurve(to: CGPoint(x: 7.91, y: 8.11), controlPoint1: CGPoint(x: 10.42, y: 3.18), controlPoint2: CGPoint(x: 9.49, y: 5.89))
        bezierPath.addLine(to: CGPoint(x: 7.91, y: 8.1))
        bezierPath.addCurve(to: CGPoint(x: 8.09, y: 9.57), controlPoint1: CGPoint(x: 7.56, y: 8.56), controlPoint2: CGPoint(x: 7.64, y: 9.22))
        bezierPath.addCurve(to: CGPoint(x: 9.56, y: 9.39), controlPoint1: CGPoint(x: 8.55, y: 9.93), controlPoint2: CGPoint(x: 9.2, y: 9.85))
        bezierPath.addCurve(to: CGPoint(x: 9.6, y: 9.33), controlPoint1: CGPoint(x: 9.57, y: 9.37), controlPoint2: CGPoint(x: 9.59, y: 9.35))
        bezierPath.addCurve(to: CGPoint(x: 12.5, y: 0.26), controlPoint1: CGPoint(x: 11.42, y: 6.76), controlPoint2: CGPoint(x: 12.5, y: 3.63))
        bezierPath.addCurve(to: CGPoint(x: 9.18, y: -9.38), controlPoint1: CGPoint(x: 12.5, y: -3.37), controlPoint2: CGPoint(x: 11.25, y: -6.72))
        bezierPath.addLine(to: CGPoint(x: 9.18, y: -9.38))
        bezierPath.addCurve(to: CGPoint(x: 8.37, y: -9.79), controlPoint1: CGPoint(x: 8.99, y: -9.64), controlPoint2: CGPoint(x: 8.69, y: -9.79))
        bezierPath.addLine(to: CGPoint(x: 8.37, y: -9.79))
        bezierPath.close()
        bezierPath.move(to: CGPoint(x: -1.04, y: -8.38))
        bezierPath.addLine(to: CGPoint(x: -5.42, y: -4.19))
        bezierPath.addLine(to: CGPoint(x: -9.38, y: -4.19))
        bezierPath.addCurve(to: CGPoint(x: -12.5, y: -1.06), controlPoint1: CGPoint(x: -11.1, y: -4.19), controlPoint2: CGPoint(x: -12.5, y: -2.79))
        bezierPath.addLine(to: CGPoint(x: -12.5, y: 1.04))
        bezierPath.addCurve(to: CGPoint(x: -9.38, y: 4.17), controlPoint1: CGPoint(x: -12.5, y: 2.77), controlPoint2: CGPoint(x: -11.1, y: 4.17))
        bezierPath.addLine(to: CGPoint(x: -5.42, y: 4.17))
        bezierPath.addLine(to: CGPoint(x: -1.04, y: 8.36))
        bezierPath.addLine(to: CGPoint(x: -1.04, y: -8.38))
        bezierPath.close()
        bezierPath.move(to: CGPoint(x: 2.85, y: -6.71))
        bezierPath.addLine(to: CGPoint(x: 2.85, y: -6.71))
        bezierPath.addCurve(to: CGPoint(x: 1.79, y: -5.69), controlPoint1: CGPoint(x: 2.27, y: -6.72), controlPoint2: CGPoint(x: 1.8, y: -6.26))
        bezierPath.addCurve(to: CGPoint(x: 2.09, y: -4.93), controlPoint1: CGPoint(x: 1.78, y: -5.4), controlPoint2: CGPoint(x: 1.89, y: -5.13))
        bezierPath.addCurve(to: CGPoint(x: 4.17, y: 0.26), controlPoint1: CGPoint(x: 3.37, y: -3.58), controlPoint2: CGPoint(x: 4.17, y: -1.76))
        bezierPath.addCurve(to: CGPoint(x: 2.48, y: 5.01), controlPoint1: CGPoint(x: 4.17, y: 2.06), controlPoint2: CGPoint(x: 3.53, y: 3.71))
        bezierPath.addLine(to: CGPoint(x: 2.48, y: 5.01))
        bezierPath.addCurve(to: CGPoint(x: 2.58, y: 6.48), controlPoint1: CGPoint(x: 2.1, y: 5.44), controlPoint2: CGPoint(x: 2.15, y: 6.1))
        bezierPath.addCurve(to: CGPoint(x: 4.05, y: 6.38), controlPoint1: CGPoint(x: 3.02, y: 6.86), controlPoint2: CGPoint(x: 3.68, y: 6.81))
        bezierPath.addCurve(to: CGPoint(x: 4.1, y: 6.32), controlPoint1: CGPoint(x: 4.07, y: 6.36), controlPoint2: CGPoint(x: 4.08, y: 6.34))
        bezierPath.addCurve(to: CGPoint(x: 6.25, y: 0.26), controlPoint1: CGPoint(x: 5.44, y: 4.67), controlPoint2: CGPoint(x: 6.25, y: 2.55))
        bezierPath.addCurve(to: CGPoint(x: 3.59, y: -6.38), controlPoint1: CGPoint(x: 6.25, y: -2.31), controlPoint2: CGPoint(x: 5.23, y: -4.66))
        bezierPath.addLine(to: CGPoint(x: 3.59, y: -6.38))
        bezierPath.addCurve(to: CGPoint(x: 2.85, y: -6.71), controlPoint1: CGPoint(x: 3.4, y: -6.59), controlPoint2: CGPoint(x: 3.13, y: -6.71))
        bezierPath.addLine(to: CGPoint(x: 2.85, y: -6.71))
        bezierPath.close()
        UIColor.white.setFill()
        bezierPath.fill()
        return bezierPath
    }
    
    private func audioOffShapePath() -> UIBezierPath {
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: -1.93, y: -7.67))
        bezierPath.addLine(to: CGPoint(x: -5.97, y: -3.83))
        bezierPath.addLine(to: CGPoint(x: -9.62, y: -3.83))
        bezierPath.addCurve(to: CGPoint(x: -12.5, y: -0.96), controlPoint1: CGPoint(x: -11.21, y: -3.83), controlPoint2: CGPoint(x: -12.5, y: -2.55))
        bezierPath.addLine(to: CGPoint(x: -12.5, y: 0.96))
        bezierPath.addCurve(to: CGPoint(x: -9.62, y: 3.83), controlPoint1: CGPoint(x: -12.5, y: 2.55), controlPoint2: CGPoint(x: -11.21, y: 3.83))
        bezierPath.addLine(to: CGPoint(x: -5.97, y: 3.83))
        bezierPath.addLine(to: CGPoint(x: -1.93, y: 7.67))
        bezierPath.addLine(to: CGPoint(x: -1.93, y: -7.67))
        bezierPath.close()
        bezierPath.move(to: CGPoint(x: 3.83, y: -4.8))
        bezierPath.addLine(to: CGPoint(x: 3.83, y: -4.8))
        bezierPath.addCurve(to: CGPoint(x: 2.87, y: -3.84), controlPoint1: CGPoint(x: 3.3, y: -4.8), controlPoint2: CGPoint(x: 2.87, y: -4.37))
        bezierPath.addCurve(to: CGPoint(x: 3.16, y: -3.15), controlPoint1: CGPoint(x: 2.87, y: -3.58), controlPoint2: CGPoint(x: 2.97, y: -3.33))
        bezierPath.addLine(to: CGPoint(x: 6.32, y: -0))
        bezierPath.addLine(to: CGPoint(x: 3.16, y: 3.16))
        bezierPath.addLine(to: CGPoint(x: 3.16, y: 3.16))
        bezierPath.addCurve(to: CGPoint(x: 3.13, y: 4.51), controlPoint1: CGPoint(x: 2.77, y: 3.53), controlPoint2: CGPoint(x: 2.76, y: 4.13))
        bezierPath.addCurve(to: CGPoint(x: 4.49, y: 4.54), controlPoint1: CGPoint(x: 3.5, y: 4.89), controlPoint2: CGPoint(x: 4.11, y: 4.9))
        bezierPath.addCurve(to: CGPoint(x: 4.51, y: 4.51), controlPoint1: CGPoint(x: 4.5, y: 4.53), controlPoint2: CGPoint(x: 4.51, y: 4.52))
        bezierPath.addLine(to: CGPoint(x: 7.68, y: 1.36))
        bezierPath.addLine(to: CGPoint(x: 10.85, y: 4.51))
        bezierPath.addLine(to: CGPoint(x: 10.85, y: 4.51))
        bezierPath.addCurve(to: CGPoint(x: 12.21, y: 4.54), controlPoint1: CGPoint(x: 11.22, y: 4.89), controlPoint2: CGPoint(x: 11.82, y: 4.9))
        bezierPath.addCurve(to: CGPoint(x: 12.23, y: 3.18), controlPoint1: CGPoint(x: 12.59, y: 4.17), controlPoint2: CGPoint(x: 12.6, y: 3.56))
        bezierPath.addCurve(to: CGPoint(x: 12.21, y: 3.16), controlPoint1: CGPoint(x: 12.22, y: 3.17), controlPoint2: CGPoint(x: 12.21, y: 3.17))
        bezierPath.addLine(to: CGPoint(x: 9.04, y: -0))
        bezierPath.addLine(to: CGPoint(x: 12.2, y: -3.16))
        bezierPath.addLine(to: CGPoint(x: 12.2, y: -3.15))
        bezierPath.addCurve(to: CGPoint(x: 12.23, y: -4.51), controlPoint1: CGPoint(x: 12.58, y: -3.52), controlPoint2: CGPoint(x: 12.59, y: -4.13))
        bezierPath.addCurve(to: CGPoint(x: 11.5, y: -4.8), controlPoint1: CGPoint(x: 12.04, y: -4.7), controlPoint2: CGPoint(x: 11.77, y: -4.81))
        bezierPath.addLine(to: CGPoint(x: 11.5, y: -4.8))
        bezierPath.addCurve(to: CGPoint(x: 10.84, y: -4.51), controlPoint1: CGPoint(x: 11.25, y: -4.79), controlPoint2: CGPoint(x: 11.02, y: -4.69))
        bezierPath.addLine(to: CGPoint(x: 7.68, y: -1.36))
        bezierPath.addLine(to: CGPoint(x: 4.52, y: -4.51))
        bezierPath.addLine(to: CGPoint(x: 4.52, y: -4.51))
        bezierPath.addCurve(to: CGPoint(x: 3.83, y: -4.8), controlPoint1: CGPoint(x: 4.34, y: -4.7), controlPoint2: CGPoint(x: 4.09, y: -4.8))
        bezierPath.close()
        return bezierPath
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        self.shapeLayer.position = CGPoint(x: self.frame.width / 2.0, y: self.frame.width / 2.0)
    }
}
