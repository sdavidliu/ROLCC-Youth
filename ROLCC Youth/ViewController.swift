//
//  ViewController.swift
//  BouncyPageViewController
//
//  Created by Bohdan Orlov on 10/08/2016.
//  Copyright (c) 2016 Bohdan Orlov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var progress: CGFloat = 0 {
        didSet {
            let progressRelativeToEnd = abs(progress - 0.5) * 2
            let alpha = pow(progressRelativeToEnd, 6)
            self.moreInfoButton.alpha = alpha
            self.settingsButton.alpha = alpha
            let scale = 0.7 + 0.3 * progressRelativeToEnd
            self.heartImageView.transform = CGAffineTransform(scaleX:scale, y:scale)
            self.dayLabel.transform = CGAffineTransform(scaleX:scale, y:scale)
            //            self.heartRateLabel.transform = CGAffineTransform(scaleX:scale, y:scale)
        }
    }
    fileprivate lazy var presentationAnimator = GuillotineTransitionAnimation()
    var tintColor: UIColor!
    @IBOutlet weak var moreInfoButton: UIButton!
    @IBOutlet weak var settingsButton: UIButton!
    @IBOutlet weak var heartImageView: UIImageView!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var heartRateLabel: UILabel!
    @IBOutlet weak var imageLogo: UIImageView!
    @IBOutlet weak var menuButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.moreInfoButton.tintColor = self.tintColor
        self.settingsButton.tintColor = self.tintColor
        self.dayLabel.textColor = self.tintColor
        self.heartRateLabel.textColor = self.tintColor
        self.heartImageView.tintColor = self.tintColor
        let origImage = menuButton.currentImage
        let tintedImage = origImage?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        menuButton.setImage(tintedImage, for: .normal)
        menuButton.tintColor = self.tintColor
    }
    
    @IBAction func showMenuAction(_ sender: UIButton) {
        let menuViewController = storyboard!.instantiateViewController(withIdentifier: "MenuViewController")
        menuViewController.modalPresentationStyle = .custom
        menuViewController.transitioningDelegate = self
        
        presentationAnimator.animationDelegate = menuViewController as? GuillotineAnimationDelegate
        presentationAnimator.supportView = navigationController!.navigationBar
        presentationAnimator.presentButton = sender
        present(menuViewController, animated: true, completion: nil)
    }
    
    func showMenu(){
        let menuViewController = storyboard!.instantiateViewController(withIdentifier: "MenuViewController")
        menuViewController.modalPresentationStyle = .custom
        menuViewController.transitioningDelegate = self
        
        presentationAnimator.animationDelegate = menuViewController as? GuillotineAnimationDelegate
        presentationAnimator.supportView = navigationController!.navigationBar
        //presentationAnimator.presentButton = sender
        present(menuViewController, animated: true, completion: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let defaults = UserDefaults.standard
        defaults.set("home", forKey: "layer")
        defaults.synchronize()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func unwindToMainMenu(segue: UIStoryboardSegue) {
        
    }
    
}

extension ViewController: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        presentationAnimator.mode = .presentation
        return presentationAnimator
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        presentationAnimator.mode = .dismissal
        return presentationAnimator
    }
}
