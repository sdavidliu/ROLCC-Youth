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
    
    private let numCellGroups = 11
    private var realIndex = 0
    
    private let cellArray = ["Berryessa", "Cupertino 1", "Cupertino 2", "Evergreen", "Fremont A", "Fremont B", "Morgan Hill", "Palo Alto", "San Carlos", "Saratoga 1", "Saratoga 2"]
    
    var cellView0 : Berryessa!
    var cellView1 : Berryessa!
    var cellView2 : Berryessa!
    
    private var lastIndex = 0
    var tempLastIndex = 0
    
    private var isPositiveMotion = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIApplication.sharedApplication().statusBarStyle = .LightContent
        
        self.delegate = self
        self.dataSource = self
        
        cellView0 = storyboard?.instantiateViewControllerWithIdentifier("Berryessa") as! Berryessa
        cellView0.setCellGroup(cellArray[0])
        
        cellView1 = storyboard?.instantiateViewControllerWithIdentifier("Berryessa") as! Berryessa
        cellView1.setCellGroup(cellArray[1])
        
        cellView2 = storyboard?.instantiateViewControllerWithIdentifier("Berryessa") as! Berryessa
        cellView2.setCellGroup(cellArray[2])
        
        destinationViewControllers = [cellView0, cellView1, cellView2]
        
        let defaults = NSUserDefaults.standardUserDefaults()
        
        var x = 0
        
        if(defaults.stringForKey("Favorite") != nil){
            x = cellArray.indexOf(defaults.stringForKey("Favorite")!)!
        }
        
        realIndex = x
        lastIndex = realIndex % 3
        
        let startingViewController = self.viewControllerAtIndex(x % 3)
        
        if(x % 3 == 0){
            cellView0.setCellGroup(cellArray[x])
        }else if(x % 3 == 1){
            cellView1.setCellGroup(cellArray[x])
        }else{
            cellView2.setCellGroup(cellArray[x])
        }
        
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
    
    func pageViewController(pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        if(completed){
            lastIndex = tempLastIndex
            if(isPositiveMotion){
                realIndex += 1
            }else{
                realIndex -= 1
            }
        }
    }
    
    func pageViewController(pageViewController: UIPageViewController, willTransitionToViewControllers pendingViewControllers: [UIViewController]) {
        
        let index = destinationViewControllers.indexOf(pendingViewControllers[0])! as Int!
        
        var tempIndex = realIndex
        
        if(index - lastIndex == 1 || index - lastIndex == -2){
            isPositiveMotion = true
            tempIndex += 1
        }else{
            isPositiveMotion = false
            tempIndex -= 1
        }
        
        if(tempIndex >= numCellGroups){
            tempIndex = numCellGroups - 1
        }
        
        tempLastIndex = index
        
        if(realIndex < numCellGroups && realIndex >= 0){
            if(pendingViewControllers[0] == cellView0){
                cellView0.setCellGroup(cellArray[tempIndex])
                
                if(tempIndex > 0){
                    cellView2.setCellGroup(cellArray[tempIndex - 1])
                }
                if(tempIndex < numCellGroups - 1){
                    cellView1.setCellGroup(cellArray[tempIndex + 1])
                }
            }else if(pendingViewControllers[0] == cellView1){
                cellView1.setCellGroup(cellArray[tempIndex])
                
                if(tempIndex > 0){
                    cellView0.setCellGroup(cellArray[tempIndex - 1])
                }
                if(tempIndex < numCellGroups - 1){
                    cellView2.setCellGroup(cellArray[tempIndex + 1])
                }
            }else if(pendingViewControllers[0] == cellView2){
                cellView2.setCellGroup(cellArray[tempIndex])
                
                if(tempIndex > 0){
                    cellView1.setCellGroup(cellArray[tempIndex - 1])
                }
                if(tempIndex < numCellGroups - 1){
                    cellView0.setCellGroup(cellArray[tempIndex + 1])
                }
            }
        }
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
        
        if realIndex == numCellGroups - 1 {
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
        
        if realIndex == numCellGroups - 1{
            return nil
        }
        
        return self.viewControllerAtIndex(index % 3)
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return numCellGroups - 1
        
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
}