//
//  SecondViewController.swift
//  ROLCC Youth
//
//  Created by Jimy Liu Mini on 6/22/16.
//  Copyright © 2016 Dave&Joe. All rights reserved.
//

import UIKit
import Firebase
import Auk

class Calendar: UIViewController, UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource {
    
    let screenWidth = UIScreen.mainScreen().bounds.width
    let screenHeight = UIScreen.mainScreen().bounds.height
    let images = ["wnw.jpg", "divergent.jpeg", "cellleader.jpg"]
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var imageLabel: UILabel!
    
    var events = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIApplication.sharedApplication().statusBarStyle = .Default
        
        //navigationItem.titleView = UIImageView(image: UIImage(named: "LOGO.png"))
        
        let navBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 60))
        let navigationItem = UINavigationItem()
        navigationItem.title = "Events"
        navBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "Avenir-Light", size: 15.0)!];
        navBar.items = [navigationItem]
        self.view.addSubview(navBar)
        
        scrollView.delegate = self
        scrollView.auk.settings.placeholderImage = UIImage(named: "LOGO.png")
        scrollView.auk.settings.errorImage = UIImage(named: "LOGO.png")
        scrollView.auk.settings.pageControl.visible = false
        scrollView.auk.settings.showsHorizontalScrollIndicator = true
        scrollView.auk.settings.contentMode = .ScaleAspectFill
        
        for i in images{
            scrollView.auk.show(image: UIImage(named: i)!)
        }
        
        scrollView.auk.startAutoScroll(delaySeconds: 3)
        
        let ref = FIRDatabase.database().reference()
        ref.observeEventType(.Value, withBlock: { snapshot in
            
            let s = snapshot.value!.objectForKey("events")! as! String
            
            let Str = s.componentsSeparatedByString(",")
            
            for part in Str {
                self.events.append(part)
            }
            
            self.imageLabel.text = self.events[self.scrollView.auk.currentPageIndex!]
            
            self.tableView.reloadData()
            
            }, withCancelBlock: { error in
                print(error.description)
        })
        
        tableView.backgroundColor = UIColor.clearColor()
        tableView.separatorColor = UIColor.whiteColor()
        tableView.rowHeight = 70
        tableView.allowsSelection = true
        tableView.delegate = self
        
    }
    
    private func showInitialImage() {
        if let image = UIImage(named: "facebook.png") {
            scrollView.auk.show(image: image)
        }
    }
    
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        /*
        print(scrollView.auk.currentPageIndex!)
        if (imageLabel.text != events[scrollView.auk.currentPageIndex!]){
            imageLabel.text = events[scrollView.auk.currentPageIndex!]
        }*/
        if let imageIndex = scrollView.auk.currentPageIndex{
            if (imageLabel.text != events[imageIndex]){
                imageLabel.text = events[imageIndex]
            }
        }
        tableView.delegate = self
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! ArtistTableViewCell
        
        //let artist = artists[indexPath.row]
        //cell.eventLabel.text = artist.bio
        //cell.imageLabel.image = artist.image
        //cell.dateLabel.text = artist.name
        
        cell.backgroundColor = UIColor.clearColor()
        
        let row = indexPath.row
        
        var details = [String]()
        let ref = FIRDatabase.database().reference()
        ref.observeEventType(.Value, withBlock: { snapshot in
            
            let s = snapshot.value!.objectForKey(self.events[row])! as! String
            
            let Str = s.componentsSeparatedByString(",")
            
            for part in Str {
                details.append(part)
            }
            
            let date = details[0]
            let monthIndex = date.startIndex.advancedBy(3)
            let month = date.substringToIndex(monthIndex)
            let dayRange = date.endIndex.advancedBy(-4)..<date.endIndex.advancedBy(-2)
            var day = date.substringWithRange(dayRange)
            if (day.substringToIndex(day.startIndex.advancedBy(1)) == " "){
                day = "0" + day.substringFromIndex(day.endIndex.advancedBy(-1))
            }
            
            cell.dateLabel.text = month + "\n" + day
            
            }, withCancelBlock: { error in
                print(error.description)
        })
        
        //cell.dateLabel.text = month + "\n" + day
        cell.eventLabel.text = events[indexPath.row]
        
        cell.eventLabel.textColor = UIColor.whiteColor()
        cell.dateLabel.backgroundColor = UIColor.grayColor()
        cell.dateLabel.textColor = UIColor.whiteColor()
        cell.dateLabel.textAlignment = .Center
        
        cell.selectionStyle = .None
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let row = indexPath.row
        
        var details = [String]()
        let ref = FIRDatabase.database().reference()
        ref.observeEventType(.Value, withBlock: { snapshot in
            
            let s = snapshot.value!.objectForKey(self.events[row])! as! String
            
            let Str = s.componentsSeparatedByString(",")
            
            for part in Str {
                details.append(part)
            }
            
            let alertController = UIAlertController(title: self.events[row], message:
                "Date: " + details[0] + "\nTime: " + details[1] + "\nLocation: " + details[2] + "\nDescription: " + details[3], preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
            
            self.presentViewController(alertController, animated: true, completion: nil)
            
            }, withCancelBlock: { error in
                print(error.description)
        })
    }
    
    override func viewDidAppear(animated: Bool) {
        scrollView.auk.startAutoScroll(delaySeconds: 3)
        
        NSNotificationCenter.defaultCenter().addObserverForName(UIContentSizeCategoryDidChangeNotification,
                                                                object: nil,
                                                                queue: NSOperationQueue.mainQueue()) {
                                                                    [weak self] _ in self?.tableView.reloadData()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

/*
class Calendar: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    let textCellIdentifier = "TextCell"
    var events = [String]()
    let screenWidth = UIScreen.mainScreen().bounds.width
    let screenHeight = UIScreen.mainScreen().bounds.height
    let navBarHeight = CGFloat(60.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //UIApplication.sharedApplication().statusBarStyle = .LightContent
        
        let navBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: screenWidth, height: navBarHeight))
        let navigationItem = UINavigationItem()
        navigationItem.title = "Events"
        navBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "Avenir-Light", size: 15.0)!];
        navBar.items = [navigationItem]
        self.view.addSubview(navBar)
        
        tableView.frame = CGRect(x: 0, y: navBarHeight, width: UIScreen.mainScreen().bounds.width, height: UIScreen.mainScreen().bounds.height - navBarHeight)
        tableView.backgroundColor = UIColor.clearColor()
        tableView.separatorColor = UIColor.whiteColor()
        tableView.rowHeight = 50
        tableView.delegate = self
        tableView.dataSource = self
        
        let ref = FIRDatabase.database().reference()
        ref.observeEventType(.Value, withBlock: { snapshot in
            
            let s = snapshot.value!.objectForKey("events")! as! String
            
            let Str = s.componentsSeparatedByString(",")
            
            for part in Str {
                self.events.append(part)
            }
            
            self.tableView.reloadData()
            
            }, withCancelBlock: { error in
                print(error.description)
        })
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(textCellIdentifier, forIndexPath: indexPath)
        
        cell.textLabel?.textColor = UIColor.whiteColor()
        cell.textLabel?.font = UIFont(name: (cell.textLabel!.font?.fontName)!, size: 20)
        
        let row = indexPath.row
        cell.textLabel?.text = events[row]
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let row = indexPath.row
        
        var details = [String]()
        let ref = FIRDatabase.database().reference()
        ref.observeEventType(.Value, withBlock: { snapshot in
            
            let s = snapshot.value!.objectForKey(self.events[row])! as! String
            
            let Str = s.componentsSeparatedByString(",")
            
            for part in Str {
                details.append(part)
            }
            
            let alertController = UIAlertController(title: self.events[row], message:
                "Date: " + details[0] + "\nTime: " + details[1] + "\nLocation: " + details[2] + "\nDescription: " + details[3], preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
            
            self.presentViewController(alertController, animated: true, completion: nil)
            
            }, withCancelBlock: { error in
                print(error.description)
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}
*/
