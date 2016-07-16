//
//  Berryessa.swift
//  ROLCC Youth
//
//  Created by Jimy Liu Mini on 6/23/16.
//  Copyright © 2016 Dave&Joe. All rights reserved.
//

import UIKit

class Berryessa: UIViewController {
    
    var button = DOFavoriteButton()
    
    var cellText = "Berryessa"
    
    @IBOutlet private var nameHeader : UILabel!
    @IBOutlet private var groupPicture : UIImageView!
    @IBOutlet private var imagePaddingView: UIView!
    @IBOutlet private var pictureRatioConstraint : NSLayoutConstraint!
    
    @IBOutlet private var imageWidthConstraint : NSLayoutConstraint!
    @IBOutlet private var imageHeightConstraint : NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        button = DOFavoriteButton(frame: CGRectMake(UIScreen.mainScreen().bounds.width - 50, 20, 50, 50), image: UIImage(named: "stars.png"))
        self.view.addSubview(button)
        
        button.addTarget(self, action: #selector(Berryessa.tapped), forControlEvents: .TouchUpInside)
        
        let groupImg : UIImage! = UIImage(named: cellText)
        
        let originalImgWidth = groupImg.size.width
        let originalImgHeight = groupImg.size.height
        
        let imgWidth = 0.85 * UIScreen.mainScreen().bounds.width
        
        let ratio = imgWidth / originalImgWidth
        
        let imgHeight = ratio * originalImgHeight
        
        imageWidthConstraint.constant = imgWidth
        imageHeightConstraint.constant = imgHeight
        
        groupPicture.image = groupImg
    }
    
    func tapped(sender: DOFavoriteButton) {
        if sender.selected {
            // deselect
            sender.deselect()
        } else {
            // select with animation
            sender.select()
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setValue(cellText, forKey: "Favorite")
            defaults.synchronize()
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        nameHeader.text = cellText
        
    }
    
    override func viewDidAppear(animated: Bool) {
        let defaults = NSUserDefaults.standardUserDefaults()
        
        if (defaults.stringForKey("Favorite") == cellText){
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
    
    func setCellGroup(name : String){
        cellText = name
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
