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
    let screenWidth = UIScreen.mainScreen().bounds.width
    let screenHeight = UIScreen.mainScreen().bounds.height
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        self.dataSource = self
        
        self.title = "Cell Group"
        self.navigationController!.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "Avenir-Light", size: 15)!]
        
        let berryessaView = storyboard?.instantiateViewControllerWithIdentifier("Berryessa") as! Berryessa
        let cupertino1View = storyboard?.instantiateViewControllerWithIdentifier("Cupertino1") as! Cupertino1
        let cupertino2View = storyboard?.instantiateViewControllerWithIdentifier("Cupertino2") as! Cupertino2
        let evergreenView = storyboard?.instantiateViewControllerWithIdentifier("Evergreen") as! Evergreen
        let fremontAView = storyboard?.instantiateViewControllerWithIdentifier("FremontA") as! FremontA
        let fremontBView = storyboard?.instantiateViewControllerWithIdentifier("FremontB") as! FremontB
        let morganHillView = storyboard?.instantiateViewControllerWithIdentifier("MorganHill") as! MorganHill
        let paloAltoView = storyboard?.instantiateViewControllerWithIdentifier("PaloAlto") as! PaloAlto
        let sanCarlosView = storyboard?.instantiateViewControllerWithIdentifier("SanCarlos") as! SanCarlos
        let saratoga1View = storyboard?.instantiateViewControllerWithIdentifier("Saratoga1") as! Saratoga1
        let saratoga2View = storyboard?.instantiateViewControllerWithIdentifier("Saratoga2") as! Saratoga2
        
        destinationViewControllers = [berryessaView, cupertino1View, cupertino2View, evergreenView, fremontAView, fremontBView, morganHillView, paloAltoView, sanCarlosView, saratoga1View, saratoga2View]
        
        let defaults = NSUserDefaults.standardUserDefaults()
        var x = 0
        if (defaults.stringForKey("CellGroup") == "Berryessa"){
            x = 0
        }else if (defaults.stringForKey("CellGroup") == "Cupertino1"){
            x = 1
        }else if (defaults.stringForKey("CellGroup") == "Cupertino2"){
            x = 2
        }else if (defaults.stringForKey("CellGroup") == "Evergreen"){
            x = 3
        }else if (defaults.stringForKey("CellGroup") == "FremontA"){
            x = 4
        }else if (defaults.stringForKey("CellGroup") == "FremontB"){
            x = 5
        }else if (defaults.stringForKey("CellGroup") == "MorganHill"){
            x = 6
        }else if (defaults.stringForKey("CellGroup") == "PaloAlto"){
            x = 7
        }else if (defaults.stringForKey("CellGroup") == "SanCarlos"){
            x = 8
        }else if (defaults.stringForKey("CellGroup") == "Saratoga1"){
            x = 9
        }else if (defaults.stringForKey("CellGroup") == "Saratoga2"){
            x = 10
        }
        
        let startingViewController = self.viewControllerAtIndex(x)
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