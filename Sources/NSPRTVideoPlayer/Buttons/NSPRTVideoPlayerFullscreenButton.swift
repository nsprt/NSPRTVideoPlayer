//
//  NSPRTVideoPlayerFullscreenButton.swift
//  
//
//  Created by Chaz Woodall on 5/18/20.
//

import UIKit

open class NSPRTVideoPlayerFullscreenButton: NSPRTVideoPlayerStatefulButton {
    public var NSPRTButtonType: type? = .none
    public var isActive: Bool?
    
    private let shapeLayer = CAShapeLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .clear
        self.layer.addSublayer(self.shapeLayer)
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
            self.shapeLayer.path = self.minimizeShapePath().cgPath
            self.shapeLayer.fillColor = UIColor(white: 1.0, alpha: 1.0).cgColor
        } else {
            self.shapeLayer.path = self.fullScreenShapePath().cgPath
            self.shapeLayer.fillColor = UIColor(white: 1.0, alpha: 1.0).cgColor
        }
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func fullScreenShapePath() -> UIBezierPath {
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: -10.23, y: -12.5))
        bezierPath.addCurve(to: CGPoint(x: -12.5, y: -10.23), controlPoint1: CGPoint(x: -11.47, y: -12.5), controlPoint2: CGPoint(x: -12.5, y: -11.47))
        bezierPath.addLine(to: CGPoint(x: -12.5, y: -5.68))
        bezierPath.addLine(to: CGPoint(x: -12.5, y: -5.69))
        bezierPath.addCurve(to: CGPoint(x: -11.38, y: -4.53), controlPoint1: CGPoint(x: -12.51, y: -5.06), controlPoint2: CGPoint(x: -12.01, y: -4.54))
        bezierPath.addCurve(to: CGPoint(x: -10.23, y: -5.65), controlPoint1: CGPoint(x: -10.76, y: -4.52), controlPoint2: CGPoint(x: -10.24, y: -5.02))
        bezierPath.addCurve(to: CGPoint(x: -10.23, y: -5.69), controlPoint1: CGPoint(x: -10.23, y: -5.66), controlPoint2: CGPoint(x: -10.23, y: -5.67))
        bezierPath.addLine(to: CGPoint(x: -10.23, y: -10.23))
        bezierPath.addLine(to: CGPoint(x: -5.68, y: -10.23))
        bezierPath.addLine(to: CGPoint(x: -5.69, y: -10.23))
        bezierPath.addCurve(to: CGPoint(x: -4.53, y: -11.34), controlPoint1: CGPoint(x: -5.06, y: -10.22), controlPoint2: CGPoint(x: -4.54, y: -10.72))
        bezierPath.addCurve(to: CGPoint(x: -5.65, y: -12.5), controlPoint1: CGPoint(x: -4.52, y: -11.97), controlPoint2: CGPoint(x: -5.02, y: -12.49))
        bezierPath.addCurve(to: CGPoint(x: -5.69, y: -12.5), controlPoint1: CGPoint(x: -5.66, y: -12.5), controlPoint2: CGPoint(x: -5.67, y: -12.5))
        bezierPath.addLine(to: CGPoint(x: -10.23, y: -12.5))
        bezierPath.close()
        bezierPath.move(to: CGPoint(x: 5.68, y: -12.5))
        bezierPath.addLine(to: CGPoint(x: 5.69, y: -12.5))
        bezierPath.addCurve(to: CGPoint(x: 4.53, y: -11.38), controlPoint1: CGPoint(x: 5.06, y: -12.51), controlPoint2: CGPoint(x: 4.54, y: -12.01))
        bezierPath.addCurve(to: CGPoint(x: 5.65, y: -10.23), controlPoint1: CGPoint(x: 4.52, y: -10.76), controlPoint2: CGPoint(x: 5.02, y: -10.24))
        bezierPath.addCurve(to: CGPoint(x: 5.69, y: -10.23), controlPoint1: CGPoint(x: 5.66, y: -10.23), controlPoint2: CGPoint(x: 5.67, y: -10.23))
        bezierPath.addLine(to: CGPoint(x: 10.23, y: -10.23))
        bezierPath.addLine(to: CGPoint(x: 10.23, y: -5.68))
        bezierPath.addLine(to: CGPoint(x: 10.23, y: -5.69))
        bezierPath.addCurve(to: CGPoint(x: 11.34, y: -4.53), controlPoint1: CGPoint(x: 10.22, y: -5.06), controlPoint2: CGPoint(x: 10.72, y: -4.54))
        bezierPath.addCurve(to: CGPoint(x: 12.5, y: -5.65), controlPoint1: CGPoint(x: 11.97, y: -4.52), controlPoint2: CGPoint(x: 12.49, y: -5.02))
        bezierPath.addCurve(to: CGPoint(x: 12.5, y: -5.69), controlPoint1: CGPoint(x: 12.5, y: -5.66), controlPoint2: CGPoint(x: 12.5, y: -5.67))
        bezierPath.addLine(to: CGPoint(x: 12.5, y: -10.23))
        bezierPath.addCurve(to: CGPoint(x: 10.23, y: -12.5), controlPoint1: CGPoint(x: 12.5, y: -11.47), controlPoint2: CGPoint(x: 11.47, y: -12.5))
        bezierPath.addLine(to: CGPoint(x: 5.68, y: -12.5))
        bezierPath.close()
        bezierPath.move(to: CGPoint(x: -11.38, y: 4.53))
        bezierPath.addLine(to: CGPoint(x: -11.38, y: 4.53))
        bezierPath.addCurve(to: CGPoint(x: -12.5, y: 5.69), controlPoint1: CGPoint(x: -12.01, y: 4.54), controlPoint2: CGPoint(x: -12.51, y: 5.06))
        bezierPath.addLine(to: CGPoint(x: -12.5, y: 10.23))
        bezierPath.addCurve(to: CGPoint(x: -10.23, y: 12.5), controlPoint1: CGPoint(x: -12.5, y: 11.47), controlPoint2: CGPoint(x: -11.47, y: 12.5))
        bezierPath.addLine(to: CGPoint(x: -5.68, y: 12.5))
        bezierPath.addLine(to: CGPoint(x: -5.69, y: 12.5))
        bezierPath.addCurve(to: CGPoint(x: -4.53, y: 11.38), controlPoint1: CGPoint(x: -5.06, y: 12.51), controlPoint2: CGPoint(x: -4.54, y: 12.01))
        bezierPath.addCurve(to: CGPoint(x: -5.65, y: 10.23), controlPoint1: CGPoint(x: -4.52, y: 10.76), controlPoint2: CGPoint(x: -5.02, y: 10.24))
        bezierPath.addCurve(to: CGPoint(x: -5.69, y: 10.23), controlPoint1: CGPoint(x: -5.66, y: 10.23), controlPoint2: CGPoint(x: -5.67, y: 10.23))
        bezierPath.addLine(to: CGPoint(x: -10.23, y: 10.23))
        bezierPath.addLine(to: CGPoint(x: -10.23, y: 5.68))
        bezierPath.addLine(to: CGPoint(x: -10.23, y: 5.69))
        bezierPath.addCurve(to: CGPoint(x: -11.34, y: 4.53), controlPoint1: CGPoint(x: -10.22, y: 5.06), controlPoint2: CGPoint(x: -10.72, y: 4.54))
        bezierPath.addCurve(to: CGPoint(x: -11.38, y: 4.53), controlPoint1: CGPoint(x: -11.36, y: 4.53), controlPoint2: CGPoint(x: -11.37, y: 4.53))
        bezierPath.addLine(to: CGPoint(x: -11.38, y: 4.53))
        bezierPath.close()
        bezierPath.move(to: CGPoint(x: 11.35, y: 4.53))
        bezierPath.addLine(to: CGPoint(x: 11.34, y: 4.53))
        bezierPath.addCurve(to: CGPoint(x: 10.23, y: 5.69), controlPoint1: CGPoint(x: 10.72, y: 4.54), controlPoint2: CGPoint(x: 10.22, y: 5.06))
        bezierPath.addLine(to: CGPoint(x: 10.23, y: 10.23))
        bezierPath.addLine(to: CGPoint(x: 5.68, y: 10.23))
        bezierPath.addLine(to: CGPoint(x: 5.69, y: 10.23))
        bezierPath.addCurve(to: CGPoint(x: 4.53, y: 11.34), controlPoint1: CGPoint(x: 5.06, y: 10.22), controlPoint2: CGPoint(x: 4.54, y: 10.72))
        bezierPath.addCurve(to: CGPoint(x: 5.65, y: 12.5), controlPoint1: CGPoint(x: 4.52, y: 11.97), controlPoint2: CGPoint(x: 5.02, y: 12.49))
        bezierPath.addCurve(to: CGPoint(x: 5.69, y: 12.5), controlPoint1: CGPoint(x: 5.66, y: 12.5), controlPoint2: CGPoint(x: 5.67, y: 12.5))
        bezierPath.addLine(to: CGPoint(x: 10.23, y: 12.5))
        bezierPath.addCurve(to: CGPoint(x: 12.5, y: 10.23), controlPoint1: CGPoint(x: 11.47, y: 12.5), controlPoint2: CGPoint(x: 12.5, y: 11.47))
        bezierPath.addLine(to: CGPoint(x: 12.5, y: 5.68))
        bezierPath.addLine(to: CGPoint(x: 12.5, y: 5.69))
        bezierPath.addCurve(to: CGPoint(x: 11.38, y: 4.53), controlPoint1: CGPoint(x: 12.51, y: 5.06), controlPoint2: CGPoint(x: 12.01, y: 4.54))
        bezierPath.addCurve(to: CGPoint(x: 11.34, y: 4.53), controlPoint1: CGPoint(x: 11.37, y: 4.53), controlPoint2: CGPoint(x: 11.36, y: 4.53))
        bezierPath.addLine(to: CGPoint(x: 11.35, y: 4.53))
        bezierPath.close()

        return bezierPath
    }
    
    private func minimizeShapePath() -> UIBezierPath {
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: -5.69, y: -12.5))
        bezierPath.addLine(to: CGPoint(x: -5.69, y: -12.5))
        bezierPath.addCurve(to: CGPoint(x: -6.81, y: -11.35), controlPoint1: CGPoint(x: -6.32, y: -12.49), controlPoint2: CGPoint(x: -6.82, y: -11.97))
        bezierPath.addLine(to: CGPoint(x: -6.81, y: -6.81))
        bezierPath.addLine(to: CGPoint(x: -11.35, y: -6.81))
        bezierPath.addLine(to: CGPoint(x: -11.35, y: -6.81))
        bezierPath.addCurve(to: CGPoint(x: -12.5, y: -5.69), controlPoint1: CGPoint(x: -11.97, y: -6.82), controlPoint2: CGPoint(x: -12.49, y: -6.32))
        bezierPath.addCurve(to: CGPoint(x: -11.38, y: -4.54), controlPoint1: CGPoint(x: -12.51, y: -5.07), controlPoint2: CGPoint(x: -12.01, y: -4.55))
        bezierPath.addCurve(to: CGPoint(x: -11.35, y: -4.54), controlPoint1: CGPoint(x: -11.37, y: -4.54), controlPoint2: CGPoint(x: -11.36, y: -4.54))
        bezierPath.addLine(to: CGPoint(x: -5.67, y: -4.54))
        bezierPath.addLine(to: CGPoint(x: -5.67, y: -4.54))
        bezierPath.addCurve(to: CGPoint(x: -4.54, y: -5.67), controlPoint1: CGPoint(x: -5.05, y: -4.54), controlPoint2: CGPoint(x: -4.54, y: -5.05))
        bezierPath.addLine(to: CGPoint(x: -4.54, y: -11.35))
        bezierPath.addLine(to: CGPoint(x: -4.54, y: -11.35))
        bezierPath.addCurve(to: CGPoint(x: -5.65, y: -12.5), controlPoint1: CGPoint(x: -4.53, y: -11.97), controlPoint2: CGPoint(x: -5.03, y: -12.49))
        bezierPath.addCurve(to: CGPoint(x: -5.69, y: -12.5), controlPoint1: CGPoint(x: -5.67, y: -12.5), controlPoint2: CGPoint(x: -5.68, y: -12.5))
        bezierPath.addLine(to: CGPoint(x: -5.69, y: -12.5))
        bezierPath.close()
        bezierPath.move(to: CGPoint(x: 5.66, y: -12.5))
        bezierPath.addLine(to: CGPoint(x: 5.65, y: -12.5))
        bezierPath.addCurve(to: CGPoint(x: 4.54, y: -11.35), controlPoint1: CGPoint(x: 5.03, y: -12.49), controlPoint2: CGPoint(x: 4.53, y: -11.97))
        bezierPath.addLine(to: CGPoint(x: 4.54, y: -5.67))
        bezierPath.addLine(to: CGPoint(x: 4.54, y: -5.67))
        bezierPath.addCurve(to: CGPoint(x: 5.67, y: -4.54), controlPoint1: CGPoint(x: 4.54, y: -5.05), controlPoint2: CGPoint(x: 5.05, y: -4.54))
        bezierPath.addLine(to: CGPoint(x: 11.35, y: -4.54))
        bezierPath.addLine(to: CGPoint(x: 11.35, y: -4.54))
        bezierPath.addCurve(to: CGPoint(x: 12.5, y: -5.66), controlPoint1: CGPoint(x: 11.97, y: -4.53), controlPoint2: CGPoint(x: 12.49, y: -5.03))
        bezierPath.addCurve(to: CGPoint(x: 11.38, y: -6.81), controlPoint1: CGPoint(x: 12.51, y: -6.28), controlPoint2: CGPoint(x: 12.01, y: -6.8))
        bezierPath.addCurve(to: CGPoint(x: 11.35, y: -6.81), controlPoint1: CGPoint(x: 11.37, y: -6.81), controlPoint2: CGPoint(x: 11.36, y: -6.81))
        bezierPath.addLine(to: CGPoint(x: 6.81, y: -6.81))
        bezierPath.addLine(to: CGPoint(x: 6.81, y: -11.35))
        bezierPath.addLine(to: CGPoint(x: 6.81, y: -11.35))
        bezierPath.addCurve(to: CGPoint(x: 5.69, y: -12.5), controlPoint1: CGPoint(x: 6.82, y: -11.97), controlPoint2: CGPoint(x: 6.32, y: -12.49))
        bezierPath.addCurve(to: CGPoint(x: 5.65, y: -12.5), controlPoint1: CGPoint(x: 5.68, y: -12.5), controlPoint2: CGPoint(x: 5.67, y: -12.5))
        bezierPath.addLine(to: CGPoint(x: 5.66, y: -12.5))
        bezierPath.close()
        bezierPath.move(to: CGPoint(x: -11.35, y: 4.54))
        bezierPath.addLine(to: CGPoint(x: -11.35, y: 4.54))
        bezierPath.addCurve(to: CGPoint(x: -12.5, y: 5.65), controlPoint1: CGPoint(x: -11.97, y: 4.53), controlPoint2: CGPoint(x: -12.49, y: 5.03))
        bezierPath.addCurve(to: CGPoint(x: -11.38, y: 6.81), controlPoint1: CGPoint(x: -12.51, y: 6.28), controlPoint2: CGPoint(x: -12.01, y: 6.8))
        bezierPath.addCurve(to: CGPoint(x: -11.35, y: 6.81), controlPoint1: CGPoint(x: -11.37, y: 6.81), controlPoint2: CGPoint(x: -11.36, y: 6.81))
        bezierPath.addLine(to: CGPoint(x: -6.81, y: 6.81))
        bezierPath.addLine(to: CGPoint(x: -6.81, y: 11.35))
        bezierPath.addLine(to: CGPoint(x: -6.81, y: 11.35))
        bezierPath.addCurve(to: CGPoint(x: -5.69, y: 12.5), controlPoint1: CGPoint(x: -6.82, y: 11.97), controlPoint2: CGPoint(x: -6.32, y: 12.49))
        bezierPath.addCurve(to: CGPoint(x: -4.54, y: 11.38), controlPoint1: CGPoint(x: -5.07, y: 12.51), controlPoint2: CGPoint(x: -4.55, y: 12.01))
        bezierPath.addCurve(to: CGPoint(x: -4.54, y: 11.35), controlPoint1: CGPoint(x: -4.54, y: 11.37), controlPoint2: CGPoint(x: -4.54, y: 11.36))
        bezierPath.addLine(to: CGPoint(x: -4.54, y: 5.67))
        bezierPath.addLine(to: CGPoint(x: -4.54, y: 5.67))
        bezierPath.addCurve(to: CGPoint(x: -5.67, y: 4.54), controlPoint1: CGPoint(x: -4.54, y: 5.05), controlPoint2: CGPoint(x: -5.05, y: 4.54))
        bezierPath.addLine(to: CGPoint(x: -11.35, y: 4.54))
        bezierPath.close()
        bezierPath.move(to: CGPoint(x: 5.67, y: 4.54))
        bezierPath.addLine(to: CGPoint(x: 5.67, y: 4.54))
        bezierPath.addCurve(to: CGPoint(x: 4.54, y: 5.67), controlPoint1: CGPoint(x: 5.05, y: 4.54), controlPoint2: CGPoint(x: 4.54, y: 5.05))
        bezierPath.addLine(to: CGPoint(x: 4.54, y: 11.35))
        bezierPath.addLine(to: CGPoint(x: 4.54, y: 11.35))
        bezierPath.addCurve(to: CGPoint(x: 5.65, y: 12.5), controlPoint1: CGPoint(x: 4.53, y: 11.97), controlPoint2: CGPoint(x: 5.03, y: 12.49))
        bezierPath.addCurve(to: CGPoint(x: 6.81, y: 11.38), controlPoint1: CGPoint(x: 6.28, y: 12.51), controlPoint2: CGPoint(x: 6.8, y: 12.01))
        bezierPath.addCurve(to: CGPoint(x: 6.81, y: 11.35), controlPoint1: CGPoint(x: 6.81, y: 11.37), controlPoint2: CGPoint(x: 6.81, y: 11.36))
        bezierPath.addLine(to: CGPoint(x: 6.81, y: 6.81))
        bezierPath.addLine(to: CGPoint(x: 11.35, y: 6.81))
        bezierPath.addLine(to: CGPoint(x: 11.35, y: 6.81))
        bezierPath.addCurve(to: CGPoint(x: 12.5, y: 5.69), controlPoint1: CGPoint(x: 11.97, y: 6.82), controlPoint2: CGPoint(x: 12.49, y: 6.32))
        bezierPath.addCurve(to: CGPoint(x: 11.38, y: 4.54), controlPoint1: CGPoint(x: 12.51, y: 5.07), controlPoint2: CGPoint(x: 12.01, y: 4.55))
        bezierPath.addCurve(to: CGPoint(x: 11.35, y: 4.54), controlPoint1: CGPoint(x: 11.37, y: 4.54), controlPoint2: CGPoint(x: 11.36, y: 4.54))
        bezierPath.addLine(to: CGPoint(x: 5.67, y: 4.54))
        bezierPath.close()
        return bezierPath
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        self.shapeLayer.position = CGPoint(x: self.frame.width / 2.0, y: self.frame.width / 2.0)
    }
}
