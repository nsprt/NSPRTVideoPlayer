//
//  File.swift
//  
//
//  Created by Chaz Woodall on 5/15/20.
//

import UIKit

open class NSPRTVideoPlayerForwardButton: NSPRTVideoPlayerStatefulButton {
    public var NSPRTButtonType: type? = .none
    public var isActive: Bool?
    
    private let shapeLayer = CAShapeLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .clear
        self.layer.addSublayer(self.shapeLayer)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func changeShape() {
        self.shapeLayer.path = shapePath().cgPath
        self.shapeLayer.fillColor = UIColor.white.cgColor
    }
    
    private func shapePath() -> UIBezierPath {
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: 17.5, y: 0))
        bezierPath.addCurve(to: CGPoint(x: 0, y: 17.5), controlPoint1: CGPoint(x: 7.85, y: 0), controlPoint2: CGPoint(x: 0, y: 7.85))
        bezierPath.addCurve(to: CGPoint(x: 17.5, y: 35), controlPoint1: CGPoint(x: 0, y: 27.15), controlPoint2: CGPoint(x: 7.85, y: 35))
        bezierPath.addCurve(to: CGPoint(x: 35, y: 17.5), controlPoint1: CGPoint(x: 27.15, y: 35), controlPoint2: CGPoint(x: 35, y: 27.15))
        bezierPath.addLine(to: CGPoint(x: 35, y: 17.5))
        bezierPath.addCurve(to: CGPoint(x: 33.57, y: 16.02), controlPoint1: CGPoint(x: 35.01, y: 16.7), controlPoint2: CGPoint(x: 34.37, y: 16.04))
        bezierPath.addCurve(to: CGPoint(x: 32.08, y: 17.45), controlPoint1: CGPoint(x: 32.76, y: 16.01), controlPoint2: CGPoint(x: 32.1, y: 16.65))
        bezierPath.addCurve(to: CGPoint(x: 32.08, y: 17.5), controlPoint1: CGPoint(x: 32.08, y: 17.47), controlPoint2: CGPoint(x: 32.08, y: 17.49))
        bezierPath.addCurve(to: CGPoint(x: 17.5, y: 32.08), controlPoint1: CGPoint(x: 32.08, y: 25.57), controlPoint2: CGPoint(x: 25.57, y: 32.08))
        bezierPath.addCurve(to: CGPoint(x: 2.92, y: 17.5), controlPoint1: CGPoint(x: 9.43, y: 32.08), controlPoint2: CGPoint(x: 2.92, y: 25.57))
        bezierPath.addCurve(to: CGPoint(x: 17.5, y: 2.92), controlPoint1: CGPoint(x: 2.92, y: 9.43), controlPoint2: CGPoint(x: 9.43, y: 2.92))
        bezierPath.addCurve(to: CGPoint(x: 27.04, y: 6.5), controlPoint1: CGPoint(x: 21.16, y: 2.92), controlPoint2: CGPoint(x: 24.49, y: 4.27))
        bezierPath.addLine(to: CGPoint(x: 23.33, y: 10.21))
        bezierPath.addLine(to: CGPoint(x: 32.08, y: 10.21))
        bezierPath.addLine(to: CGPoint(x: 32.08, y: 1.46))
        bezierPath.addLine(to: CGPoint(x: 29.11, y: 4.43))
        bezierPath.addCurve(to: CGPoint(x: 17.5, y: 0), controlPoint1: CGPoint(x: 26.02, y: 1.68), controlPoint2: CGPoint(x: 21.95, y: 0))
        bezierPath.close()
        bezierPath.move(to: CGPoint(x: 21.42, y: 12.18))
        bezierPath.addCurve(to: CGPoint(x: 17.1, y: 17.57), controlPoint1: CGPoint(x: 18.77, y: 12.18), controlPoint2: CGPoint(x: 17.1, y: 14.16))
        bezierPath.addCurve(to: CGPoint(x: 21.42, y: 23.01), controlPoint1: CGPoint(x: 17.1, y: 20.97), controlPoint2: CGPoint(x: 18.75, y: 23))
        bezierPath.addCurve(to: CGPoint(x: 25.73, y: 17.57), controlPoint1: CGPoint(x: 24.08, y: 23.01), controlPoint2: CGPoint(x: 25.73, y: 20.96))
        bezierPath.addCurve(to: CGPoint(x: 21.42, y: 12.18), controlPoint1: CGPoint(x: 25.73, y: 14.16), controlPoint2: CGPoint(x: 24.06, y: 12.18))
        bezierPath.close()
        bezierPath.move(to: CGPoint(x: 11.86, y: 12.45))
        bezierPath.addLine(to: CGPoint(x: 9.25, y: 14.23))
        bezierPath.addLine(to: CGPoint(x: 9.25, y: 16.48))
        bezierPath.addLine(to: CGPoint(x: 11.73, y: 14.81))
        bezierPath.addLine(to: CGPoint(x: 11.86, y: 14.81))
        bezierPath.addLine(to: CGPoint(x: 11.86, y: 22.73))
        bezierPath.addLine(to: CGPoint(x: 14.48, y: 22.73))
        bezierPath.addLine(to: CGPoint(x: 14.48, y: 12.45))
        bezierPath.addLine(to: CGPoint(x: 11.86, y: 12.45))
        bezierPath.close()
        bezierPath.move(to: CGPoint(x: 21.42, y: 14.18))
        bezierPath.addCurve(to: CGPoint(x: 23.09, y: 17.57), controlPoint1: CGPoint(x: 22.42, y: 14.18), controlPoint2: CGPoint(x: 23.09, y: 15.31))
        bezierPath.addCurve(to: CGPoint(x: 21.42, y: 21), controlPoint1: CGPoint(x: 23.09, y: 19.84), controlPoint2: CGPoint(x: 22.42, y: 21))
        bezierPath.addCurve(to: CGPoint(x: 19.76, y: 17.57), controlPoint1: CGPoint(x: 20.42, y: 21), controlPoint2: CGPoint(x: 19.76, y: 19.84))
        bezierPath.addCurve(to: CGPoint(x: 21.42, y: 14.18), controlPoint1: CGPoint(x: 19.76, y: 15.31), controlPoint2: CGPoint(x: 20.42, y: 14.18))
        bezierPath.close()
        UIColor.white.setFill()
        bezierPath.fill()
        return bezierPath
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        self.changeShape()
    }
}
