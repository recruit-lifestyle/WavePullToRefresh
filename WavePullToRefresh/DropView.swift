//
//  DropView.swift
//  WavePullToRefresh
//
//  Created by Daisuke Kobayashi on 2016/02/23.
//  (C) 2016 RECRUIT LIFESTYLE CO., LTD.
//

import UIKit

class DropView: UIView{
    // MARK:- Properties
    private let shapeLayer = CAShapeLayer()
    var indicatorLayer: CAShapeLayer?
    var indicatorImageView: UIImageView?
    private var angle: CGFloat = 0
    
    var animating = false {
        didSet {
            if !self.animating {
                self.indicatorImageView?.transform = CGAffineTransformMakeRotation(0)
                self.angle = 0
            }
        }
    }

    // MARK:- Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    // MARK:- Internal Methods
    func layoutSubviews(height: CGFloat, percent: CGFloat) {
        let radius = self.radius(height)
        guard let superview = self.superview else { return }
        
        // self
        self.center = CGPointMake(superview.frame.size.width / 2, superview.frame.size.height)
        self.bounds = CGRectMake(0, 0, radius, radius)
        self.shapeLayer.path = self.path(self.bounds(self.animating))
        
        // layout image view or indicator
        if let indicatorImageView = self.indicatorImageView {
            let width = self.bounds.width
            let height = self.bounds.height
            indicatorImageView.frame = CGRectMake(width * 0.15, height * 0.15, width * 0.7, height * 0.7)
            indicatorImageView.alpha = height / WavePullToRefreshConst.height
        } else if let indicatorLayer = self.indicatorLayer {
            indicatorLayer.lineWidth = 3.0 * (percent)
            let radius = self.bounds(self.animating).size.width * 0.5
            indicatorLayer.path = self.indicatorPath(self.angle, radius: radius, percent: percent)
            layoutSubviews()
        }
    }
    
    /**
     Set options
     - parameter 
        options: DropView's option
     */
    func setOptions(options: WavePullToRefreshOption) {
        self.shapeLayer.fillColor = options.fillColor
        self.shapeLayer.actions = ["path" : NSNull(), "position" : NSNull(), "bounds" : NSNull()]
        self.layer.addSublayer(self.shapeLayer)
        
        if let imageView = options.indicatorImageView {
            self.indicatorImageView = imageView
            imageView.frame = self.bounds
            self.addSubview(imageView)
        } else {
            self.indicatorLayer = CAShapeLayer()
            guard let indicatorLayer = self.indicatorLayer else { return }
            indicatorLayer.strokeColor = options.indicatorColor
            indicatorLayer.fillColor = UIColor.clearColor().CGColor
            indicatorLayer.actions = ["path" : NSNull(), "position" : NSNull(), "bounds" : NSNull()]
            indicatorLayer.lineWidth = 0
            self.layer.addSublayer(indicatorLayer)
        }
    }
    
    /**
     Call when animating
     Rotate image view or indicator
     */
    func updateLayers() {
        self.shapeLayer.path = self.path(self.bounds(self.animating))
        self.angle += CGFloat(M_PI) * WavePullToRefreshConst.spinSpeed
        if let imageView = self.indicatorImageView {
            imageView.transform = CGAffineTransformMakeRotation(self.angle)
        } else if let indicatorLayer = self.indicatorLayer {
            indicatorLayer.lineWidth = 2.6 * (self.bounds(animating).size.width / WavePullToRefreshConst.maxIndicatorRadius)
            let radius = self.bounds(self.animating).size.width * 0.5
            indicatorLayer.path = self.indicatorPath(self.angle, radius: radius, percent: 1.0)
        }
    }
    
    /**
     Remove all animation and add reducing animation
     - parameter 
        completion: callback to WavePullToRefreshView
     */
    func stopAnimation(completion: ()->()) {
        self.layer.removeAllAnimations()
        
        self.indicatorLayer?.hidden = true
        self.indicatorImageView?.hidden = true
        UIView.animateWithDuration(0.5, delay: 0,
            usingSpringWithDamping: 1.0, initialSpringVelocity: 0.0, options: .CurveEaseIn,
            animations: {
                self.bounds.size = CGSizeZero
            },
            completion: { _ in
                if let superview = self.superview as? WavePullToRefreshView {
                    completion()
                    self.center = CGPoint(x: superview.bounds.width/2, y: 0)
                    self.indicatorLayer?.hidden = false
                    self.indicatorImageView?.hidden = false
                }
            }
        )
    }

    // MARK:- Private Methods
    private func path(rect: CGRect) -> CGPath {
        let path = UIBezierPath(ovalInRect: rect)
        return path.CGPath
    }
    
    /**
     Get path for indicator
     - parameter 
        angle: start angle
        radius: radius of indicator
        percent: percentage of arc length( max: length of the circumference * 0.8 )
     - returns: path for indicator
     */
    private func indicatorPath(angle: CGFloat, radius: CGFloat, percent: CGFloat) -> CGPath {
        let path = UIBezierPath()
        path.addArcWithCenter(CGPointMake(radius, radius),
            radius: radius * 0.55,
            startAngle: angle,
            endAngle: (CGFloat(M_PI * 2) * min(percent, 1.0) * 0.8) + angle,
            clockwise: true)
        return path.CGPath
    }
    
    private func radius(height: CGFloat) -> CGFloat {
        return min(height, WavePullToRefreshConst.maxIndicatorRadius)
    }
    
}
