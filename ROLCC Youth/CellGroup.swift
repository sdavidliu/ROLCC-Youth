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
    
    private let numCellGroups = 10
    private var realIndex = 0
    
    private let cellArray = ["Berryessa", "Cupertino 1", "Cupertino 2", "Evergreen", "Fremont A", "Fremont B", "Morgan Hill", "Palo Alto", "San Carlos", "Saratoga 1", "Saratoga 2"]
    
    var berryessaView : Berryessa!
    var cupertino1View : Berryessa!
    var evergreenView : Berryessa!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIApplication.sharedApplication().statusBarStyle = .LightContent
        
        self.delegate = self
        self.dataSource = self
        
        //let almadenView = storyboard?.instantiateViewControllerWithIdentifier("Almaden") as! Almaden
        berryessaView = storyboard?.instantiateViewControllerWithIdentifier("Berryessa") as! Berryessa
        cupertino1View = storyboard?.instantiateViewControllerWithIdentifier("Berryessa") as! Berryessa
        evergreenView = storyboard?.instantiateViewControllerWithIdentifier("Berryessa") as! Berryessa
//        let cupertino2View = storyboard?.instantiateViewControllerWithIdentifier("Cupertino2") as! Cupertino2
//        let evergreenView = storyboard?.instantiateViewControllerWithIdentifier("Evergreen") as! Evergreen
//        let fremontAView = storyboard?.instantiateViewControllerWithIdentifier("FremontA") as! FremontA
//        let fremontBView = storyboard?.instantiateViewControllerWithIdentifier("FremontB") as! FremontB
//        let morganHillView = storyboard?.instantiateViewControllerWithIdentifier("MorganHill") as! MorganHill
//        let paloAltoView = storyboard?.instantiateViewControllerWithIdentifier("PaloAlto") as! PaloAlto
//        let sanCarlosView = storyboard?.instantiateViewControllerWithIdentifier("SanCarlos") as! SanCarlos
//        let saratoga1View = storyboard?.instantiateViewControllerWithIdentifier("Saratoga1") as! Saratoga1
//        let saratoga2View = storyboard?.instantiateViewControllerWithIdentifier("Saratoga2") as! Saratoga2
        
        //destinationViewControllers = [berryessaView, cupertino1View, cupertino2View, evergreenView, fremontAView, fremontBView, morganHillView, paloAltoView, sanCarlosView, saratoga1View, saratoga2View]
        
        destinationViewControllers = [berryessaView, cupertino1View, evergreenView]
        
        let defaults = NSUserDefaults.standardUserDefaults()
        var x = 0
        if (defaults.stringForKey("Favorite") == "Berryessa"){
            x = 0
        }else if (defaults.stringForKey("Favorite") == "Cupertino1"){
            x = 1
        }else if (defaults.stringForKey("Favorite") == "Cupertino2"){
            x = 2
        }else if (defaults.stringForKey("Favorite") == "Evergreen"){
            x = 3
        }else if (defaults.stringForKey("Favorite") == "FremontA"){
            x = 4
        }else if (defaults.stringForKey("Favorite") == "FremontB"){
            x = 5
        }else if (defaults.stringForKey("Favorite") == "MorganHill"){
            x = 6
        }else if (defaults.stringForKey("Favorite") == "PaloAlto"){
            x = 7
        }else if (defaults.stringForKey("Favorite") == "SanCarlos"){
            x = 8
        }else if (defaults.stringForKey("Favorite") == "Saratoga1"){
            x = 9
        }else if (defaults.stringForKey("Favorite") == "Saratoga2"){
            x = 10
        }
        
        realIndex = x
        
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
        
        if (realIndex == 0) || (index == NSNotFound) {
            return nil
        }
        
        index -= 1
        
        if(index == -1){
            index = 2
        }
        
        realIndex -= 1
        
        if(index % 2 == 0){
            berryessaView.setCellGroup(cellArray[realIndex])
        }else if(index % 3 == 1){
            cupertino1View.setCellGroup(cellArray[realIndex])
        }else{
            evergreenView.setCellGroup(cellArray[realIndex])
        }
        
        if realIndex == numCellGroups {
            return nil
        }
        
        return self.viewControllerAtIndex(index % 3)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        
        var index = destinationViewControllers.indexOf(viewController)! as Int
        
        if index == NSNotFound {
            return nil
        }
        
        index += 1
        realIndex += 1
        
        if realIndex == numCellGroups {
            return nil
        }
        
        if(index % 3 == 0){
            berryessaView.setCellGroup(cellArray[realIndex])
        }else if(index % 3 == 1){
            cupertino1View.setCellGroup(cellArray[realIndex])
        }else{
            evergreenView.setCellGroup(cellArray[realIndex])
        }
        
        return self.viewControllerAtIndex(index % 3)
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return numCellGroups
        //return destinationViewControllers.count
        
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
}