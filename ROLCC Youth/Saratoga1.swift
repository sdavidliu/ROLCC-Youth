//
//  Saratoga1.swift
//  ROLCC Youth
//
//  Created by Jimy Liu Mini on 7/9/16.
//  Copyright © 2016 Dave&Joe. All rights reserved.
//

import UIKit

class Saratoga1: UIViewController {

    var button = DOFavoriteButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        button = DOFavoriteButton(frame: CGRectMake(UIScreen.mainScreen().bounds.width - 50, 20, 50, 50), image: UIImage(named: "stars.png"))
        self.view.addSubview(button)
        
        button.addTarget(self, action: #selector(Saratoga1.tapped), forControlEvents: .TouchUpInside)
    }
    
    func tapped(sender: DOFavoriteButton) {
        if sender.selected {
            // deselect
            sender.deselect()
        } else {
            // select with animation
            sender.select()
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setValue("Saratoga1", forKey: "Favorite")
            defaults.synchronize()
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        let defaults = NSUserDefaults.standardUserDefaults()
        
        if (defaults.stringForKey("Favorite") == "Saratoga1"){
            if (button.selected == false){
                button.select()
            }
        }else{
            button.deselect()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
