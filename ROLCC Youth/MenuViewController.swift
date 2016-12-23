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
        AppDelegate.Database.layer = "home"
        presentingViewController!.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func eventsTapped(_ sender: UIButton) {
        if (AppDelegate.Database.layer == "events"){
            presentingViewController!.dismiss(animated: true, completion: nil)
        }else{
            AppDelegate.Database.layer = "events"
            let menuViewController = storyboard!.instantiateViewController(withIdentifier: "EventsViewController")
            present(menuViewController, animated: true, completion: nil)
        }
    }
    
    @IBAction func cellGroupTapped(_ sender: UIButton) {
        if (AppDelegate.Database.layer == "cellgroup"){
            presentingViewController!.dismiss(animated: true, completion: nil)
        }else{
            AppDelegate.Database.layer = "cellgroup"
            let menuViewController = storyboard!.instantiateViewController(withIdentifier: "DemoViewController")
            present(menuViewController, animated: true, completion: nil)
        }
    }
    
    @IBAction func videosTapped(_ sender: UIButton) {
        if (AppDelegate.Database.layer == "videos"){
            presentingViewController!.dismiss(animated: true, completion: nil)
        }else{
            AppDelegate.Database.layer = "videos"
            let menuViewController = storyboard!.instantiateViewController(withIdentifier: "VideosViewController")
            present(menuViewController, animated: true, completion: nil)
        }
    }
    
    @IBAction func podcastTapped(_ sender: UIButton) {
        if (AppDelegate.Database.layer == "podcast"){
            presentingViewController!.dismiss(animated: true, completion: nil)
        }else{
            AppDelegate.Database.layer = "podcast"
            let menuViewController = storyboard!.instantiateViewController(withIdentifier: "PodcastViewController")
            present(menuViewController, animated: true, completion: nil)
        }
    }
    
    @IBAction func contactTapped(_ sender: UIButton) {
        if (AppDelegate.Database.layer == "contact"){
            presentingViewController!.dismiss(animated: true, completion: nil)
        }else{
            AppDelegate.Database.layer = "contact"
            let menuViewController = storyboard!.instantiateViewController(withIdentifier: "ContactViewController")
            present(menuViewController, animated: true, completion: nil)
        }
    }
    
    @IBAction func closeMenu(_ sender: UIButton) {
        AppDelegate.Database.layer = "home"
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
