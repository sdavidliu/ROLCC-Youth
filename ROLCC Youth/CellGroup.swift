//
//  CellGroup.swift
//  ROLCC Youth
//
//  Created by Jimy Liu Mini on 6/22/16.
//  Copyright © 2016 Dave&Joe. All rights reserved.
//

import UIKit

class CellGroup: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    var destinationViewControllers : [UIViewController] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        self.dataSource = self
        
        let almadenView = storyboard?.instantiateViewControllerWithIdentifier("Almaden") as! Almaden
        let berryessaView = storyboard?.instantiateViewControllerWithIdentifier("Berryessa") as! Berryessa
        
        destinationViewControllers = [almadenView, berryessaView]
        
        let startingViewController = self.viewControllerAtIndex(0)
        let viewControllers: NSArray = [startingViewController]
        
        self.setViewControllers(viewControllers as? [UIViewController], direction: UIPageViewControllerNavigationDirection.Forward, animated: true, completion: {(done: Bool) in})
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func viewControllerAtIndex(index:NSInteger) -> UIViewController {
        return destinationViewControllers[index]
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        
        var index = destinationViewControllers.indexOf(viewController)! as Int
        
        if (index == 0) || (index == NSNotFound) {
            return nil
        }
        
        index -= 1
        
        if index == destinationViewControllers.count {
            return nil
        }
        return self.viewControllerAtIndex(index)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        
        var index = destinationViewControllers.indexOf(viewController)! as Int
        
        if index == NSNotFound {
            return nil
        }
        
        index += 1
        
        if index == destinationViewControllers.count {
            return nil
        }
        return self.viewControllerAtIndex(index)
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return destinationViewControllers.count
        
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
}