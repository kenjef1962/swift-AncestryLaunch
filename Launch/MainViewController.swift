//
//  MainViewController.swift
//  Launch
//
//  Created by Kendall Jefferson on 2/9/17.
//  Copyright © 2017 Kendall Jefferson. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var radialGlowImage: UIImageView!
    @IBOutlet weak var logoSmall: UIImageView!
    @IBOutlet weak var logoLarge: UIView!

    @IBOutlet weak var mainStackView: UIStackView!
    @IBOutlet weak var infoStackView: UIStackView!
    @IBOutlet weak var buttonStackView: UIStackView!
    
    @IBOutlet weak var infoTitleLabel: UILabel!
    @IBOutlet weak var infoImageView: UIImageView!
    @IBOutlet weak var infoBodyLabel: UILabel!

    @IBOutlet weak var createAccountButton: UIButton!
    @IBOutlet weak var signinButton: UIButton!
    
    fileprivate var timerPrimaryAnimation: Timer?
    fileprivate var timerInfoAnimation: Timer?
    
    fileprivate var hasRunAnimation = false
    fileprivate var maxItems = 1000
    fileprivate var currInfoIndex = 0

    fileprivate var infoData = [
        ["The World's Largest Genealogical Database", "Sign up for an Ancestry account and gain instant access to almost 20 billion records from around the world.", "ic_globe"],
        ["Follow the Leaf to Discoveries", "Our advanced algorithms tap into our extensive database to serve you up valuable hints as you grow your tree.", "ic_leaf"],
        ["Unlock the True Power of Genealogy with DNA", "Your DNA results can provide unbelievable insights and new discoveries.", "ic_map"],
        ["Tree: Plant the Seed and Watch your Tree Grow", "We will guide you through the first steps of growing your family tree, you’ll be on your way to becoming an expert.", "ic_tree"],
    ]
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.title = "Welcome"
        updateMainDisplay(preAnimation: !hasRunAnimation)
        updateInfoDisplay(reset: true)
        
        createAccountButton.roundedBorder(radius: 5, color: .clear, width: 1)
        signinButton.roundedBorder(radius: 5, color: .clear, width: 1)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        hasRunAnimation ? startInfoAnimation() : startPrimaryAnimation()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        title = " "
        stopInfoAnimation()
    }
    
    // MARK: - Actions
    @IBAction func createAccountButtonTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "CreateAccount", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "createAccountStoryboard")
        navigationController?.pushViewController(vc, animated: true)
    }

    @IBAction func signinButtonTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Signin", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "signinStoryboard")
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - Primary Animation
extension MainViewController {
    func updateMainDisplay(preAnimation: Bool) {
        logoSmall.isHidden = preAnimation
        logoLarge.isHidden = !preAnimation
        mainStackView.alpha = preAnimation ? 0.0 : 1.0
    }
    
    func startPrimaryAnimation() {
        updateMainDisplay(preAnimation: true)
        timerPrimaryAnimation = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(runPrimaryAnimation(_:)), userInfo: "", repeats: false)
    }
    
    @objc fileprivate func runPrimaryAnimation(_ timer: Timer) {
        hasRunAnimation = false

        let frameLarge = logoLarge.frame
        let centerLarge = logoLarge.center
        
        let frameSmall = logoSmall.frame
        let centerSmall = logoSmall.center
        
        let ratio = frameSmall.size.height / frameSmall.size.width
        let halfWidth = (frameLarge.size.height / ratio) / 2
        let halfHeight = frameLarge.size.height / 2
        
        updateMainDisplay(preAnimation: true)
        
        // Set initial animation control locations and visibility
        logoSmall.frame = CGRect(x: centerLarge.x - halfWidth, y: centerLarge.y - halfHeight, width: halfWidth * 2, height: halfHeight * 2)
        logoSmall.center = centerLarge
        
        logoLarge.frame = frameLarge
        logoLarge.center = centerLarge
        
        // Animate shrinking "Ancestry"
        UIView.animate(
            withDuration: 0.5,
            delay: 0.0,
            options: [.curveLinear],
            animations: {
                self.logoLarge.frame = self.logoSmall.frame
                self.logoLarge.center = self.logoSmall.center
            },
            completion: { _ in
                self.logoSmall.isHidden = false
                self.logoLarge.isHidden = true
            })
        
        // Animate logo center to top
        UIView.animate(
            withDuration: 0.5,
            delay: 0.5,
            options: [.curveEaseOut],
            animations: {
                self.logoSmall.frame = frameSmall
                self.logoSmall.center = centerSmall
            },
            completion: nil)
        
        // Fade in all the controls, reset to original locations
        UIView.animate(
            withDuration: 0.5,
            delay: 1.0,
            options: [.curveEaseIn],
            animations: {
                self.mainStackView.alpha = 1.0
        },
            completion: { _ in
                self.logoLarge.frame = frameLarge
                self.logoLarge.center = centerLarge
                
                self.startInfoAnimation()
        })

        
        hasRunAnimation = true
    }
}

// MARK: - Info Animation
extension MainViewController {
    func updateInfoDisplay(reset: Bool = false) {
        currInfoIndex = reset ? 0 : (currInfoIndex + 1) % infoData.count
        
        let info = infoData[currInfoIndex]
        self.infoTitleLabel.text = info[0]
        self.infoBodyLabel.text = info[1]
        self.infoImageView.image = UIImage(named: info[2])
    }
    
    func startInfoAnimation() {
        updateInfoDisplay(reset: true)
        timerInfoAnimation = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(runInfoAnimation(_:)), userInfo: "", repeats: true)
    }
    
    func stopInfoAnimation() {
        timerInfoAnimation?.invalidate()
    }
    
    @objc fileprivate func runInfoAnimation(_ timer: Timer) {
        UIView.animate(
            withDuration: 0.25,
            delay: 0.0,
            options: [.curveEaseOut],
            animations: { self.infoStackView.alpha = 0.0 },
            completion: { _ in
                self.updateInfoDisplay()
                
                UIView.animate(
                    withDuration: 0.25,
                    delay: 0.0,
                    options: [.curveEaseIn],
                    animations: { self.infoStackView.alpha = 1.0 },
                    completion: nil)
        })
    }
}
