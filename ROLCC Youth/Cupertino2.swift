//
//  Cupertino2.swift
//  ROLCC Youth
//
//  Created by Jimy Liu Mini on 7/9/16.
//  Copyright © 2016 Dave&Joe. All rights reserved.
//

import UIKit

class Cupertino2: UIViewController {

    var button = DOFavoriteButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        button = DOFavoriteButton(frame: CGRectMake(UIScreen.mainScreen().bounds.width - 50, 60, 50, 50), image: UIImage(named: "stars.png"))
        self.view.addSubview(button)
        
        button.addTarget(self, action: #selector(Cupertino2.tapped), forControlEvents: .TouchUpInside)
    }
    
    func tapped(sender: DOFavoriteButton) {
        if sender.selected {
            // deselect
            sender.deselect()
        } else {
            // select with animation
            sender.select()
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setValue("Cupertino2", forKey: "Favorite")
            defaults.synchronize()
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        let defaults = NSUserDefaults.standardUserDefaults()
        
        if (defaults.stringForKey("Favorite") == "Cupertino2"){
            if (button.selected == false){
                button.select()
            }
        }else{
            button.deselect()
        }
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
