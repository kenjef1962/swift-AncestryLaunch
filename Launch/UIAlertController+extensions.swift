//
//  UIAlertController+extensions.swift
//  Launch
//
//  Created by Kendall Jefferson on 3/29/17.
//  Copyright © 2017 Kendall Jefferson. All rights reserved.
//

import Foundation
import UIKit

extension UIAlertController {
    class func showBasicAlert(_ sender: UIViewController, title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))

        sender.present(alert, animated: true, completion: nil)
    }
}
