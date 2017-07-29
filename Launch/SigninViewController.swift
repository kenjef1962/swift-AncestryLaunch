//
//  SigninViewController.swift
//  Launch
//
//  Created by Kendall Jefferson on 2/15/17.
//  Copyright © 2017 Kendall Jefferson. All rights reserved.
//

import UIKit

class SigninViewController: UIViewController {
    
    @IBOutlet weak var logoSmall: UIImageView!
    @IBOutlet weak var logoLarge: UIView!
    
    @IBOutlet weak var formView: UIView!
    
    @IBOutlet weak var usernameView: UIView!
    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var forgotButton: UIButton!
    @IBOutlet weak var showHideButton: UIButton!
    
    @IBOutlet weak var signinButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.title = "Sign in"
        
        formView.roundedBorder(radius: 5, color: .gray, width: 1)
        usernameView.roundedBorder(radius: 0, color: .gray, width: 1)
        passwordView.roundedBorder(radius: 0, color: .gray, width: 1)
        
        signinButton.roundedBorder(radius: 5, color: .clear, width: 1)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        runPrimaryAnimation()
    }
    
    @IBAction func forgotButtonTapped(_ sender: Any) {
        UIAlertController.showBasicAlert(self, title: "Sign in", message: #function)
    }
    
    @IBAction func showHideButtonTapped(_ sender: Any) {
        passwordTextField.isSecureTextEntry = !passwordTextField.isSecureTextEntry
        
        let imageName = passwordTextField.isSecureTextEntry ? "passwordShow" : "passwordHide"
        showHideButton.setImage(UIImage(named: imageName), for: .normal)
    }
    
    @IBAction func signinButtonTapped(_ sender: Any) {
        UIAlertController.showBasicAlert(self, title: self.title!, message: #function)
    }
}

// MARK: - Primary Animation
extension SigninViewController {
    fileprivate func runPrimaryAnimation() {
        let frameLarge = logoLarge.frame
        let centerLarge = logoLarge.center
        
        // Set initial animation control locations and visibility
        logoLarge.frame = logoSmall.frame
        logoLarge.center = logoSmall.center
        logoLarge.isHidden = true

        logoSmall.isHidden = false
        
        UIView.animate(
            withDuration: 0.5,
            delay: 0.0,
            options: [.curveLinear],
            animations: {
                self.logoSmall.isHidden = true

                self.logoLarge.isHidden = false
                self.logoLarge.frame = frameLarge
                self.logoLarge.center = centerLarge
            },
            completion: nil)
    }
}

// MARK: - TextField Delegate
extension SigninViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == passwordTextField {
            guard let text = textField.text, !text.isEmpty else { return true }

            passwordTextField.text = (text as NSString).replacingCharacters(in: range, with: string)
            return false
        }
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameTextField {
            passwordTextField.becomeFirstResponder()
        }
        else if textField == passwordTextField {
            signinButton.sendActions(for: .touchUpInside)
        }
        else {
            textField.resignFirstResponder()
        }
        return false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
        textField.layoutIfNeeded()
    }
}



