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
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        self.dataSource = self
        
        //self.title = "Cell Group"
        //self.navigationController!.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "Avenir-Light", size: 15)!]
        /*
        let berryessaView = storyboard?.instantiateViewController(withIdentifier: "Berryessa") as! Berryessa
        let cupertino1View = storyboard?.instantiateViewController(withIdentifier: "Cupertino1") as! Cupertino1
        let cupertino2View = storyboard?.instantiateViewController(withIdentifier: "Cupertino2") as! Cupertino2
        let cupertinoJHView = storyboard?.instantiateViewController(withIdentifier: "CupertinoJH") as! CupertinoJH
        let evergreenView = storyboard?.instantiateViewController(withIdentifier: "Evergreen") as! Evergreen
        let fremontAView = storyboard?.instantiateViewController(withIdentifier: "FremontA") as! FremontA
        let fremontBView = storyboard?.instantiateViewController(withIdentifier: "FremontB") as! FremontB
        let fremontJHView = storyboard?.instantiateViewController(withIdentifier: "FremontJH") as! FremontJH
        let morganHillView = storyboard?.instantiateViewController(withIdentifier: "MorganHill") as! MorganHill
        let paloAltoView = storyboard?.instantiateViewController(withIdentifier: "PaloAlto") as! PaloAlto
        let paloAltoJHView = storyboard?.instantiateViewController(withIdentifier: "PaloAltoJH") as! PaloAltoJH
        let sanCarlosView = storyboard?.instantiateViewController(withIdentifier: "SanCarlos") as! SanCarlos
        let saratoga1View = storyboard?.instantiateViewController(withIdentifier: "Saratoga1") as! Saratoga1
        let saratoga2View = storyboard?.instantiateViewController(withIdentifier: "Saratoga2") as! Saratoga2
        let saratogaJHView = storyboard?.instantiateViewController(withIdentifier: "SaratogaJH") as! SaratogaJH
        let sunnyvaleJHView = storyboard?.instantiateViewController(withIdentifier: "SunnyvaleJH") as! SunnyvaleJH
        
        destinationViewControllers = [berryessaView, cupertino1View, cupertino2View, cupertinoJHView, evergreenView, fremontAView, fremontBView, fremontJHView, morganHillView, paloAltoView, paloAltoJHView, sanCarlosView, saratoga1View, saratoga2View, saratogaJHView, sunnyvaleJHView]
        
        let defaults = UserDefaults.standard
        var x = 0
        if (defaults.string(forKey: "CellGroup") == "Berryessa"){
            x = 0
        }else if (defaults.string(forKey: "CellGroup") == "Cupertino1"){
            x = 1
        }else if (defaults.string(forKey: "CellGroup") == "Cupertino2"){
            x = 2
        }else if (defaults.string(forKey: "CellGroup") == "CupertinoJH"){
            x = 3
        }else if (defaults.string(forKey: "CellGroup") == "Evergreen"){
            x = 4
        }else if (defaults.string(forKey: "CellGroup") == "FremontA"){
            x = 5
        }else if (defaults.string(forKey: "CellGroup") == "FremontB"){
            x = 6
        }else if (defaults.string(forKey: "CellGroup") == "FremontJH"){
            x = 7
        }else if (defaults.string(forKey: "CellGroup") == "MorganHill"){
            x = 8
        }else if (defaults.string(forKey: "CellGroup") == "PaloAlto"){
            x = 9
        }else if (defaults.string(forKey: "CellGroup") == "PaloAltoJH"){
            x = 10
        }else if (defaults.string(forKey: "CellGroup") == "SanCarlos"){
            x = 11
        }else if (defaults.string(forKey: "CellGroup") == "Saratoga1"){
            x = 12
        }else if (defaults.string(forKey: "CellGroup") == "Saratoga2"){
            x = 13
        }else if (defaults.string(forKey: "CellGroup") == "SaratogaJH"){
            x = 14
        }else if (defaults.string(forKey: "CellGroup") == "SunnyvaleJH"){
            x = 15
        }
        
        let startingViewController = self.viewControllerAtIndex(x)
        let viewControllers: NSArray = [startingViewController]
        
        self.setViewControllers(viewControllers as? [UIViewController], direction: UIPageViewControllerNavigationDirection.forward, animated: true, completion: {(done: Bool) in})*/
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func viewControllerAtIndex(_ index:NSInteger) -> UIViewController {
        return destinationViewControllers[index]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        var index = destinationViewControllers.index(of: viewController)! as Int
        
        if (index == 0) || (index == NSNotFound) {
            return nil
        }
        
        index -= 1
        
        if index == destinationViewControllers.count {
            return nil
        }
        return self.viewControllerAtIndex(index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        var index = destinationViewControllers.index(of: viewController)! as Int
        
        if index == NSNotFound {
            return nil
        }
        
        index += 1
        
        if index == destinationViewControllers.count {
            return nil
        }
        return self.viewControllerAtIndex(index)
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return destinationViewControllers.count
        
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
}
