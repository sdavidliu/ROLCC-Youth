//
//  PageViewControllerPresenter.swift
//  BouncyPageViewController
//
//  Created by Bohdan Orlov on 08/10/2016.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Foundation
import UIKit
import BouncyPageViewController
import RAMAnimatedTabBarController

final class PageViewControllerPresenter: NSObject {
    final var pagesQueue = [UIViewController]()
    var pageViewController = BouncyPageViewController(initialViewControllers: [])
    fileprivate lazy var presentationAnimator = GuillotineTransitionAnimation()
    init(window: UIWindow) {
        super.init()
        for idx in (0...4) {
            let pageViewController = self.pageViewController(index: idx)
            pagesQueue.append(pageViewController)
        }
        pageViewController = BouncyPageViewController(initialViewControllers: Array(pagesQueue[2...3]))
        pageViewController.viewControllerAfterViewController = self.viewControllerAfterViewController
        pageViewController.viewControllerBeforeViewController = self.viewControllerBeforeViewController
        pageViewController.didScroll = self.pageViewControllerDidScroll
        
        let navigationController = UINavigationController(rootViewController: pageViewController)
        //navigationController.navigationBar.setBackgroundImage(UIImage(), for: .default)
        //navigationController.navigationBar.shadowImage = UIImage()
        navigationController.isNavigationBarHidden = true
        //pageViewController.navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: UIImage(named:"ic_menuRotated@3x.png"), style: .plain, target: nil, action: #selector(showMenu(sender:)))
        //pageViewController.navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: UIImage(named:"settings"), style: .plain, target: nil, action: nil)
        window.rootViewController = navigationController
    }
    
    func showMenu(sender: UIBarButtonItem){
        
        print("hi")
        //let menuViewController = storyboard!.instantiateViewController(withIdentifier: "MenuViewController")
        let menuViewController = UIStoryboard(name: "main", bundle: nil).instantiateViewController(withIdentifier: "MenuViewController")
        menuViewController.modalPresentationStyle = .custom
        menuViewController.transitioningDelegate = self
        
        print("hello")
        
        presentationAnimator.animationDelegate = menuViewController as? GuillotineAnimationDelegate
        //presentationAnimator.supportView = navigationController!.navigationBar
        presentationAnimator.supportView = pageViewController.navigationController?.navigationBar
        //presentationAnimator.presentButton = sender
        //present(menuViewController, animated: true, completion: nil)
        menuViewController.present(menuViewController, animated: true, completion: nil)
    }
    
    func pageViewControllerDidScroll(pageViewController: BouncyPageViewController, offset: CGFloat, progress: CGFloat) {
        for vc in pageViewController.visibleControllers() {
            let vc = (vc as! ViewController)
            vc.progress = progress
            
        }
        let firstVC = pageViewController.childViewControllers.first as! ViewController
        let color = firstVC.tintColor
        //pageViewController.navigationItem.leftBarButtonItem!.tintColor = color
        //pageViewController.navigationItem.rightBarButtonItem!.tintColor = color
    }
    
    func viewControllerAfterViewController(prevVC: UIViewController) -> UIViewController? {
        
        /*if let idx = self.pagesQueue.index(of: prevVC), idx + 1 < self.pagesQueue.count {
         return self.pagesQueue[idx + 1]
         }else{
         return self.pagesQueue[0]
         }
         return nil*/
        let idx = self.pagesQueue.index(of: prevVC)
        if idx == 3{
            return self.pagesQueue[0]
        }else{
            return self.pagesQueue[idx! + 1]
        }
    }
    func viewControllerBeforeViewController(prevVC: UIViewController) -> UIViewController? {
        /*
         if let idx = self.pagesQueue.index(of: prevVC), idx - 1 >= 0 {
         return self.pagesQueue[idx - 1]
         }else{
         return self.pagesQueue[1]
         }
         return nil*/
        let idx = self.pagesQueue.index(of: prevVC)
        if idx == 0{
            return self.pagesQueue[3]
        }else{
            return self.pagesQueue[idx! - 1]
        }
    }
    
    func pageViewController(index: Int) -> UIViewController {
        /*
        let pageViewController =  UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() as! RAMAnimatedTabBarController
        let firstColor = UIColor.white
        let secondColor = UIColor(red:78/255, green:178/255, blue:231/255, alpha:1.00)
        (pageViewController.viewControllers?.first as! ViewController).tintColor = index % 2 == 0 ?  secondColor : firstColor
        (pageViewController.viewControllers?.first as! ViewController).view.backgroundColor = index % 2 == 0 ? firstColor : secondColor
        (pageViewController.viewControllers?.first as! ViewController).imageLogo.image = index % 2 == 0 ? UIImage(named: "LOGO.png") : UIImage(named: "jhlogo.png")
        (pageViewController.viewControllers?.first as! ViewController).dayLabel.text = index % 2 == 0 ? "Youth" : "Junior High"
        (pageViewController.viewControllers?.first as! ViewController).heartRateLabel.text = index % 2 == 0 ? "9:45am" : "11:15am"
        return pageViewController.viewControllers!.first!*/
        
        let pageViewController =  UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() as! ViewController
        let firstColor = UIColor.white
        let secondColor = UIColor(red:78/255, green:178/255, blue:231/255, alpha:1.00)
        pageViewController.tintColor = index % 2 == 0 ?  secondColor : firstColor
        /*
        if index % 2 == 0{
            pageViewController.menuButton.setImage(UIImage(named: "ic_menuRotated.png@3x.png"), for: .normal)
        }else{
            let origImage = UIImage(named: "ic_menuRotated.png@3x.png");
            let tintedImage = origImage?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
            pageViewController.menuButton.setImage(tintedImage, for: .normal)
            pageViewController.menuButton.tintColor = UIColor(red:78/255, green:178/255, blue:231/255, alpha:1.00)
            //pageViewController.menuButton.setImage(UIImage(named: "ic_menuRotated.png@3x"), for: .normal)
        }*/
        pageViewController.view.backgroundColor = index % 2 == 0 ? firstColor : secondColor
        pageViewController.imageLogo.image = index % 2 == 0 ? UIImage(named: "LOGO.png") : UIImage(named: "jhlogo.png")
        pageViewController.dayLabel.text = index % 2 == 0 ? "Youth" : "Junior High"
        pageViewController.heartRateLabel.text = index % 2 == 0 ? "9:45am" : "11:15am"
        return pageViewController
    }
}

extension PageViewControllerPresenter: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        presentationAnimator.mode = .presentation
        return presentationAnimator
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        presentationAnimator.mode = .dismissal
        return presentationAnimator
    }
}
