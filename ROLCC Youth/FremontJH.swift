//
//  FremontJH.swift
//  ROLCC Youth
//
//  Created by Jimy Liu Mini on 9/9/16.
//  Copyright © 2016 Dave&Joe. All rights reserved.
//

import UIKit

class FremontJH: UIViewController {

    var button = DOFavoriteButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        button = DOFavoriteButton(frame: CGRect(x: UIScreen.main.bounds.width - 50, y: 65, width: 50, height: 50), image: UIImage(named: "stars.png"))
        self.view.addSubview(button)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let defaults = UserDefaults.standard
        
        if (defaults.string(forKey: "Favorite") == "FremontJH"){
            if (button.isSelected == false){
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
