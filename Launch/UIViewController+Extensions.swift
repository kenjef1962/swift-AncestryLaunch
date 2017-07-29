//
//  UIViewController+Extensions.swift
//  Launch
//
//  Created by Kendall Jefferson on 3/15/17.
//  Copyright © 2017 Kendall Jefferson. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func setTiledBackground(tiledImageName: String) {
        guard let patternImage = UIImage(named: tiledImageName) else { return }

        view.backgroundColor = UIColor(patternImage: patternImage)
    }
    
    func setGradientBackground(center: CGPoint? = nil, radius: CGFloat? = nil, colors: [UIColor]? = nil) {
        let gradientLayer = RadialGradientLayer()
        gradientLayer.frame = view.bounds
        
        if let center = center {
            gradientLayer.center = center
        }
        
        if let radius = radius {
            gradientLayer.radius = radius
        }
        
        if let colors = colors {
            gradientLayer.colors = colors
        }
        
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
}
