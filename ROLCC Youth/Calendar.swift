//
//  SecondViewController.swift
//  ROLCC Youth
//
//  Created by Jimy Liu Mini on 6/22/16.
//  Copyright © 2016 Dave&Joe. All rights reserved.
//

import UIKit
import Firebase

class Calendar: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    let textCellIdentifier = "TextCell"
    var events = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIApplication.sharedApplication().statusBarStyle = .LightContent
        
        tableView.frame = CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.width, height: UIScreen.mainScreen().bounds.height)
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

