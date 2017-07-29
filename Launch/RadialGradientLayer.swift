//
//  RadialGradientLayer.swift
//  Launch
//
//  Created by Kendall Jefferson on 3/15/17.
//  Copyright © 2017 Kendall Jefferson. All rights reserved.
//

import Foundation
import UIKit

class RadialGradientLayer: CALayer {
    
    var center: CGPoint?
    var radius: CGFloat?
    
    var colors: [UIColor] = [.gray, .black] {
        didSet {
            setNeedsDisplay()
        }
    }
    
    var cgColors: [CGColor] {
        return colors.map({ (color) -> CGColor in color.cgColor })
    }
    
    override init() {
        super.init()
        
        needsDisplayOnBoundsChange = true
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init()
    }
    
    override func draw(in ctx: CGContext) {
        ctx.saveGState()
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let locations: [CGFloat] = [0.0, 1.0]
        
        guard let gradient = CGGradient(colorsSpace: colorSpace, colors: cgColors as CFArray, locations: locations) else { return }
        
        if center == nil {
            center = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
        }
        
        if radius == nil {
            radius = (bounds.width + bounds.height) / 2
        }
        
        ctx.drawRadialGradient(gradient, startCenter: center!, startRadius: 0.0, endCenter: center!, endRadius: radius!, options: CGGradientDrawingOptions(rawValue: 0))
    }
}
