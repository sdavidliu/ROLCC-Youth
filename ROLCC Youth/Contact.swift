//
//  Contact.swift
//  ROLCC Youth
//
//  Created by Jimy Liu Mini on 6/22/16.
//  Copyright © 2016 Dave&Joe. All rights reserved.
//

import UIKit

class Contact: UIViewController {
    
    @IBOutlet weak var youthEmail: UIButton!
    @IBOutlet weak var youthWebsite: UIButton!
    @IBOutlet weak var pastorRichard: UIButton!
    @IBOutlet weak var andrewTai: UIButton!
    @IBOutlet weak var justineShann: UIButton!
    @IBOutlet weak var chiTran: UIButton!
    @IBOutlet weak var jessicaLiao: UIButton!
    @IBOutlet weak var jimyLiu: UIButton!
    @IBOutlet weak var facebook: UIButton!
    @IBOutlet weak var youtube: UIButton!
    @IBOutlet weak var instagram: UIButton!
    @IBOutlet weak var twitter: UIButton!
    @IBOutlet weak var churchAddress: UIButton!
    @IBOutlet weak var churchPhone: UIButton!
    @IBOutlet weak var churchFax: UIButton!
    @IBOutlet weak var churchEmail: UIButton!
    @IBOutlet weak var churchWebsite: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIApplication.sharedApplication().statusBarStyle = .LightContent
        
        youthEmail.addTarget(self, action: #selector(emailYouth), forControlEvents: .TouchUpInside)
        youthWebsite.addTarget(self, action: #selector(websiteYouth), forControlEvents: .TouchUpInside)
        pastorRichard.addTarget(self, action: #selector(emailRichard), forControlEvents: .TouchUpInside)
        andrewTai.addTarget(self, action: #selector(emailAndrew), forControlEvents: .TouchUpInside)
        justineShann.addTarget(self, action: #selector(emailJustine), forControlEvents: .TouchUpInside)
        chiTran.addTarget(self, action: #selector(emailChi), forControlEvents: .TouchUpInside)
        jessicaLiao.addTarget(self, action: #selector(emailJessica), forControlEvents: .TouchUpInside)
        jimyLiu.addTarget(self, action: #selector(emailJimy), forControlEvents: .TouchUpInside)
        facebook.addTarget(self, action: #selector(goFacebook), forControlEvents: .TouchUpInside)
        youtube.addTarget(self, action: #selector(goYoutube), forControlEvents: .TouchUpInside)
        instagram.addTarget(self, action: #selector(goInstagram), forControlEvents: .TouchUpInside)
        twitter.addTarget(self, action: #selector(goTwitter), forControlEvents: .TouchUpInside)
        churchAddress.addTarget(self, action: #selector(addressChurch), forControlEvents: .TouchUpInside)
        churchPhone.addTarget(self, action: #selector(phoneChurch), forControlEvents: .TouchUpInside)
        churchFax.addTarget(self, action: #selector(faxChurch), forControlEvents: .TouchUpInside)
        churchEmail.addTarget(self, action: #selector(emailChurch), forControlEvents: .TouchUpInside)
        churchWebsite.addTarget(self, action: #selector(websiteChurch), forControlEvents: .TouchUpInside)
    }
    
    func emailYouth(sender: UIButton!){
        let email = "rolccyouth@gmail.com"
        let url = NSURL(string: "mailto:\(email)")
        UIApplication.sharedApplication().openURL(url!)
    }
    
    func websiteYouth(sender: UIButton!){
        let url = NSURL(string: "http://www.rolccyouth.com/")
        UIApplication.sharedApplication().openURL(url!)
    }
    
    func emailRichard(sender: UIButton!){
        let email = "richard.shang@rolcc.net"
        let url = NSURL(string: "mailto:\(email)")
        UIApplication.sharedApplication().openURL(url!)
    }
    
    func emailAndrew(sender: UIButton!){
        let email = "andrew.tai@rolcc.net"
        let url = NSURL(string: "mailto:\(email)")
        UIApplication.sharedApplication().openURL(url!)
    }
    
    func emailJustine(sender: UIButton!){
        let email = "justine.shann@rolcc.net"
        let url = NSURL(string: "mailto:\(email)")
        UIApplication.sharedApplication().openURL(url!)
    }
    
    func emailChi(sender: UIButton!){
        let email = "chi.tran@rolcc.net"
        let url = NSURL(string: "mailto:\(email)")
        UIApplication.sharedApplication().openURL(url!)
    }
    
    func emailJessica(sender: UIButton!){
        let email = "jessica.liao@rolcc.net"
        let url = NSURL(string: "mailto:\(email)")
        UIApplication.sharedApplication().openURL(url!)
    }
    
    func emailJimy(sender: UIButton!){
        let email = "jimy.liu@gmail.com"
        let url = NSURL(string: "mailto:\(email)")
        UIApplication.sharedApplication().openURL(url!)
    }
    
    func goFacebook(sender: UIButton!){
        let url = NSURL(string: "https://www.facebook.com/youth.rolcc/")
        UIApplication.sharedApplication().openURL(url!)
    }
    
    func goYoutube(sender: UIButton!){
        let url = NSURL(string: "https://www.youtube.com/user/rolccyouth/")
        UIApplication.sharedApplication().openURL(url!)
    }
    
    func goInstagram(sender: UIButton!){
        let url = NSURL(string: "https://www.instagram.com/rolccyouth/")
        UIApplication.sharedApplication().openURL(url!)
    }
    
    func goTwitter(sender: UIButton!){
        let url = NSURL(string: "https://twitter.com/rolccyouth")
        UIApplication.sharedApplication().openURL(url!)
    }
    
    func addressChurch(sender: UIButton!){
        let url = NSURL(string: "https://maps.apple.com/maps?address=1177%20Laurelwood%20Rd,%20Santa%20Clara,%20CA%20%2095054,%20United%20States&ll=37.379769,-121.952881&q=1177%20Laurelwood%20Rd,%20Santa%20Clara,%20CA%20%2095054,%20United%20States")
        UIApplication.sharedApplication().openURL(url!)
    }
    
    func phoneChurch(sender: UIButton!){
        let number = "4082600257"
        
        callNumber(number)
    }
    
    func faxChurch(sender: UIButton!){
        let number = "4087488877"
        callNumber(number)
    }
    
    func emailChurch(sender: UIButton!){
        let email = "office@rolcc.net"
        let url = NSURL(string: "mailto:\(email)")
        UIApplication.sharedApplication().openURL(url!)
    }
    
    func websiteChurch(sender: UIButton!){
        let url = NSURL(string: "http://www.rolcc.net/")
        UIApplication.sharedApplication().openURL(url!)
    }
    
    func callNumber(number : String){
        let alertController = UIAlertController(title: number, message:
            "Are you sure you want to call " + number + "?", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default,handler: nil))
        alertController.addAction(UIAlertAction(title: "Call", style: UIAlertActionStyle.Default,handler: { action in
            let url = NSURL(string: "tel://\(number)")
            UIApplication.sharedApplication().openURL(url!)
        }))
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}