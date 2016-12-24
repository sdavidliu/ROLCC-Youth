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
import Firebase

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
        navigationController.isNavigationBarHidden = true
        window.rootViewController = navigationController
    }
    
    func pageViewControllerDidScroll(pageViewController: BouncyPageViewController, offset: CGFloat, progress: CGFloat) {
        for vc in pageViewController.visibleControllers() {
            let vc = (vc as! ViewController)
            vc.progress = progress
            
        }
        //let firstVC = pageViewController.childViewControllers.first as! ViewController
    }
    
    func viewControllerAfterViewController(prevVC: UIViewController) -> UIViewController? {
        
        let idx = self.pagesQueue.index(of: prevVC)
        if idx == 3{
            return self.pagesQueue[0]
        }else{
            return self.pagesQueue[idx! + 1]
        }
    }
    func viewControllerBeforeViewController(prevVC: UIViewController) -> UIViewController? {
        let idx = self.pagesQueue.index(of: prevVC)
        if idx == 0{
            return self.pagesQueue[3]
        }else{
            return self.pagesQueue[idx! - 1]
        }
    }
    
    func pageViewController(index: Int) -> UIViewController {
        
        let pageViewController =  UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() as! ViewController
        let firstColor = UIColor.white
        let secondColor = UIColor(red:78/255, green:178/255, blue:231/255, alpha:1.00)
        pageViewController.tintColor = index % 2 == 0 ?  secondColor : firstColor
        pageViewController.view.backgroundColor = index % 2 == 0 ? firstColor : secondColor
        pageViewController.imageLogo.image = index % 2 == 0 ? UIImage(named: "LOGO.png") : UIImage(named: "jhlogo.png")
        pageViewController.dayLabel.text = index % 2 == 0 ? "Youth" : "Junior High"
        pageViewController.heartRateLabel.text = index % 2 == 0 ? "9:45am" : "11:15am"
        var array = [String]()
        
        let reachability = Reachability()
        if (reachability?.isReachable)!{
        let ref = FIRDatabase.database().reference()
            ref.observe(.value, with: { snapshot in
                
                let s = (snapshot.value! as AnyObject).object(forKey: "home")! as! String
                
                let Str = s.components(separatedBy: ",")
                
                for part in Str {
                    array.append(part)
                }
                
                if (index % 2 == 0){
                    pageViewController.moreInfoButton.setTitle("SERMON: " + array[0].uppercased(), for: .normal)
                    pageViewController.settingsButton.setTitle("WORSHIP: " + array[1].uppercased(), for: .normal)
                }else{
                    pageViewController.moreInfoButton.setTitle("SERMON: " + array[2].uppercased(), for: .normal)
                    pageViewController.settingsButton.setTitle("WORSHIP: " + array[3].uppercased(), for: .normal)
                }
                
            }, withCancel: {
                (error:Error) -> Void in
                print(error.localizedDescription)
            })
        }
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
