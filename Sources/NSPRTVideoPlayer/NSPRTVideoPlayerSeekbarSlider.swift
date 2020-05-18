//
//  SeekbarSlider.swift
//  
//
//  Created by Chaz Woodall on 5/18/20.
//

import UIKit

open class NSPRTVideoPlayerSeekbarSlider: UISlider {

    private var trackHeight: CGFloat = 3
    private var thumbRadius: CGFloat = 15

    private lazy var thumbView: UIView = {
        let thumb = UIView()
        thumb.backgroundColor = .white
        thumb.layer.borderWidth = 0.4
        thumb.layer.borderColor = UIColor.darkGray.cgColor
        return thumb
    }()

    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        let thumb = self.thumbImage(radius: self.thumbRadius)
        self.setThumbImage(thumb, for: .normal)
        
        self.minimumTrackTintColor = .white
        self.maximumTrackTintColor = UIColor(white: 0.7, alpha: 0.5)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func thumbImage(radius: CGFloat) -> UIImage {
        self.thumbView.frame = CGRect(x: 0, y: radius / 2, width: radius, height: radius)
        self.thumbView.layer.cornerRadius = radius / 2
        
        let renderer = UIGraphicsImageRenderer(bounds: self.thumbView.bounds)
        return renderer.image { rendererContext in
            self.thumbView.layer.render(in: rendererContext.cgContext)
        }
    }

    open override func trackRect(forBounds bounds: CGRect) -> CGRect {
        var newRect = super.trackRect(forBounds: bounds)
        newRect.size.height = self.trackHeight
        return newRect
    }
}
