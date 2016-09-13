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
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var imageLabel: UILabel!
    
    var events = [String]()
    var imagesURL = [NSURL]()
    var finalImages = [UIImage?]()
    var imagesDone = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIApplication.sharedApplication().statusBarStyle = .Default
        
        let navBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 64))
        let navigationItem = UINavigationItem()
        navigationItem.title = "Events"
        navBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "Avenir-Light", size: 15.0)!];
        navBar.items = [navigationItem]
        self.view.addSubview(navBar)
        
        if (Reachability.isConnectedToNetwork() == true){
        
            let loading = RPCircularProgress()
            loading.trackTintColor = UIColor.init(red: 255 / 255, green: 255 / 255, blue: 255 / 255, alpha: 0.3)
            loading.progressTintColor = UIColor.init(red: 255 / 255, green: 255 / 255, blue: 255 / 255, alpha: 1)
            loading.thicknessRatio = 0.1
            loading.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
            loading.center = CGPoint(x: screenWidth/2, y: scrollView.center.y - 90)
            loading.enableIndeterminate()
            self.view.addSubview(loading)
            self.view.sendSubviewToBack(loading)
            
            scrollView.delegate = self
            scrollView.auk.settings.placeholderImage = UIImage(named: "LOGO.png")
            scrollView.auk.settings.errorImage = UIImage(named: "LOGO.png")
            scrollView.auk.settings.pageControl.visible = false
            scrollView.auk.settings.showsHorizontalScrollIndicator = true
            scrollView.auk.settings.contentMode = .ScaleAspectFill
            
            let ref = FIRDatabase.database().reference()
            ref.observeEventType(.Value, withBlock: { snapshot in
                
                let s = snapshot.value!.objectForKey("events")! as! String
                
                let Str = s.componentsSeparatedByString(",")
                
                for part in Str {
                    self.events.append(part)
                }
                
                self.imageLabel.text = self.events[0]
                
                self.tableView.reloadData()
                
                self.finalImages = [UIImage?](count:self.events.count, repeatedValue: nil)
                
                }, withCancelBlock: { error in
                    print(error.description)
            })
            
            tableView.backgroundColor = UIColor.clearColor()
            tableView.separatorColor = UIColor.whiteColor()
            tableView.rowHeight = 70
            tableView.allowsSelection = true
            tableView.delegate = self
        }else{
            tableView.hidden = true
            
            let error = UIImageView(image: UIImage(named: "sadface2.png"))
            error.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
            error.center = CGPoint(x: screenWidth/2, y: screenHeight/2)
            self.view.addSubview(error)
            
            let errorMessage = UILabel()
            errorMessage.text = "No internet connection"
            errorMessage.font = UIFont(name: "Avenir-Light", size: 15.0)
            errorMessage.textColor = UIColor(red: 21/255, green: 21/255, blue: 21/255, alpha: 1.0)
            errorMessage.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 20.0)
            errorMessage.textAlignment = NSTextAlignment.Center
            errorMessage.center = CGPoint(x: screenWidth/2, y: screenHeight/2 + 40)
            self.view.addSubview(errorMessage)
        }
        
    }
    
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if let imageIndex = scrollView.auk.currentPageIndex{
            if (imageIndex < events.count){
                if (imageLabel.text != events[imageIndex]){
                    imageLabel.text = events[imageIndex]
                }
            }
        }
        tableView.delegate = self
        scrollView.auk.startAutoScroll(delaySeconds: 5)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! ArtistTableViewCell
        
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
            
            if (self.imagesDone == false){
            
                let url = NSURL(string: details[4])
                self.imagesURL.append(url!)            
                
                NSURLSession.sharedSession().dataTaskWithURL(url!, completionHandler: { (data, response, error) in
                    if error != nil {
                        print(error)
                        return
                    }
                    dispatch_async(dispatch_get_main_queue(), {
                        let test = UIImage(data: data!)
                        self.finalImages[row] = test
                        var allImages = false
                        for i in 0..<self.finalImages.count{
                            if (self.finalImages[i] == nil){
                                break
                            }else if (i == self.finalImages.count - 1){
                                allImages = true
                            }
                        }
                        if (allImages == true){
                            for i in self.finalImages{
                                self.scrollView.auk.show(image: i!)
                                self.scrollView.auk.startAutoScroll(delaySeconds: 5)
                            }
                            self.imagesDone = true
                        }
                    })
                }).resume()
            }
            
            }, withCancelBlock: { error in
                print(error.description)
        })
        
        cell.eventLabel.text = events[indexPath.row]
        
        cell.eventLabel.textColor = UIColor.whiteColor()
        cell.dateLabel.backgroundColor = UIColor.grayColor()
        cell.dateLabel.textColor = UIColor.whiteColor()
        cell.dateLabel.textAlignment = .Center
        
        cell.selectionStyle = .None
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        scrollView.auk.startAutoScroll(delaySeconds: 5)
        
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

