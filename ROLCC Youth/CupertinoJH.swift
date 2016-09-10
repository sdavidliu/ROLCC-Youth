//
//  CupertinoJH.swift
//  ROLCC Youth
//
//  Created by Jimy Liu Mini on 9/9/16.
//  Copyright © 2016 Dave&Joe. All rights reserved.
//

import UIKit

class CupertinoJH: UIViewController {
    var button = DOFavoriteButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        button = DOFavoriteButton(frame: CGRectMake(UIScreen.mainScreen().bounds.width - 50, 65, 50, 50), image: UIImage(named: "stars.png"))
        self.view.addSubview(button)
        
    }
    
    override func viewDidAppear(animated: Bool) {
        let defaults = NSUserDefaults.standardUserDefaults()
        
        if (defaults.stringForKey("Favorite") == "CupertinoJH"){
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
