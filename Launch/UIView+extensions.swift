//
//  UIView+extensions.swift
//  Launch
//
//  Created by Kendall Jefferson on 3/29/17.
//  Copyright © 2017 Kendall Jefferson. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func roundedBorder(radius: CGFloat, color: UIColor, width: CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.borderWidth = width
        self.layer.borderColor = color.cgColor
        self.clipsToBounds = true
    }
}
