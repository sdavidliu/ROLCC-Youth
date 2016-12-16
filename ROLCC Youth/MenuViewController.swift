//
//  MenuViewController.swift
//  GuillotineMenuExample
//
//  Created by Maksym Lazebnyi on 10/8/15.
//  Copyright © 2015 Yalantis. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController, GuillotineMenu {
    
    var dismissButton: UIButton?
    var titleLabel: UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dismissButton = {
            let button = UIButton(frame: .zero)
            button.setImage(UIImage(named: "ic_menu"), for: .normal)
            button.addTarget(self, action: #selector(dismissButtonTapped(_:)), for: .touchUpInside)
            return button
        }()
        
        titleLabel = {
            let label = UILabel()
            label.numberOfLines = 1;
            label.text = ""
            label.font = UIFont.boldSystemFont(ofSize: 17)
            label.textColor = UIColor.white
            label.sizeToFit()
            return label
        }()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("Menu: viewWillAppear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("Menu: viewDidAppear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("Menu: viewWillDisappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("Menu: viewDidDisappear")
    }
    
    func dismissButtonTapped(_ sender: UIButton) {
        presentingViewController!.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func eventsTapped(_ sender: UIButton) {
        let defaults = UserDefaults.standard
        if (defaults.string(forKey: "layer") == "events"){
            presentingViewController!.dismiss(animated: true, completion: nil)
        }else{
            defaults.set("events", forKey: "layer")
            defaults.synchronize()
            print()
            let menuViewController = storyboard!.instantiateViewController(withIdentifier: "EventsViewController")
            present(menuViewController, animated: true, completion: nil)
        }
    }
    
    @IBAction func cellGroupTapped(_ sender: UIButton) {
        let defaults = UserDefaults.standard
        if (defaults.string(forKey: "layer") == "cellgroup"){
            presentingViewController!.dismiss(animated: true, completion: nil)
        }else{
            defaults.set("cellgroup", forKey: "layer")
            defaults.synchronize()
            let menuViewController = storyboard!.instantiateViewController(withIdentifier: "CellGroupViewController")
            present(menuViewController, animated: true, completion: nil)
        }
    }
    
    @IBAction func videosTapped(_ sender: UIButton) {
        let defaults = UserDefaults.standard
        if (defaults.string(forKey: "layer") == "videos"){
            presentingViewController!.dismiss(animated: true, completion: nil)
        }else{
            defaults.set("videos", forKey: "layer")
            defaults.synchronize()
            let menuViewController = storyboard!.instantiateViewController(withIdentifier: "VideosViewController")
            present(menuViewController, animated: true, completion: nil)
        }
    }
    
    @IBAction func homeTapped(_ sender: UIButton) {
        let defaults = UserDefaults.standard
        if (defaults.string(forKey: "layer") != "home"){
            self.presentingViewController!.presentingViewController!.presentingViewController!.dismiss(animated: true, completion: {})
        }else{
            presentingViewController!.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func menuButtonTapped(_ sender: UIButton) {
        presentingViewController!.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func closeMenu(_ sender: UIButton) {
        presentingViewController!.dismiss(animated: true, completion: nil)
    }
}

extension MenuViewController: GuillotineAnimationDelegate {
    
    func animatorDidFinishPresentation(_ animator: GuillotineTransitionAnimation) {
        print("menuDidFinishPresentation")
    }
    func animatorDidFinishDismissal(_ animator: GuillotineTransitionAnimation) {
        print("menuDidFinishDismissal")
        self.dismiss(animated: true, completion: nil)
    }
    
    func animatorWillStartPresentation(_ animator: GuillotineTransitionAnimation) {
        print("willStartPresentation")
    }
    
    func animatorWillStartDismissal(_ animator: GuillotineTransitionAnimation) {
        print("willStartDismissal")
    }
}
