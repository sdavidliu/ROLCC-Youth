//
//  Contact.swift
//  ROLCC Youth
//
//  Created by Jimy Liu Mini on 6/22/16.
//  Copyright © 2016 Dave&Joe. All rights reserved.
//

import UIKit

class Contact: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var youthEmail: UIButton!
    @IBOutlet weak var youthWebsite: UIButton!
    @IBOutlet weak var youthPhone: UIButton!
    @IBOutlet weak var pastorRichard: UIButton!
    @IBOutlet weak var andrewTai: UIButton!
    @IBOutlet weak var justineShann: UIButton!
    @IBOutlet weak var chiTran: UIButton!
    @IBOutlet weak var jessicaLiao: UIButton!
    @IBOutlet weak var jimyLiu: UIButton!
    @IBOutlet weak var margieChoa: UIButton!
    @IBOutlet weak var cynthiaChu: UIButton!
    @IBOutlet weak var facebook: UIButton!
    @IBOutlet weak var youtube: UIButton!
    @IBOutlet weak var instagram: UIButton!
    @IBOutlet weak var twitter: UIButton!
    @IBOutlet weak var churchAddress: UIButton!
    @IBOutlet weak var churchPhone: UIButton!
    @IBOutlet weak var churchFax: UIButton!
    @IBOutlet weak var churchEmail: UIButton!
    @IBOutlet weak var churchWebsite: UIButton!
    
    fileprivate lazy var presentationAnimator = GuillotineTransitionAnimation()
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let navBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 64))
        let navigationItem = UINavigationItem()
        navigationItem.title = "Contact"
        navBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "Avenir-Light", size: 15.0)!]
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named:"menubutton.png"), style: .plain, target: nil, action: #selector(showMenu))
        navigationItem.leftBarButtonItem?.tintColor = UIColor.gray
        navBar.items = [navigationItem]
        self.view.addSubview(navBar)
        
        scrollView.delegate = self
        scrollView.isScrollEnabled = true
        scrollView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight - 400)
        scrollView.contentSize = CGSize(width: screenWidth, height: 550)
        
        youthEmail.addTarget(self, action: #selector(emailYouth), for: .touchUpInside)
        youthWebsite.addTarget(self, action: #selector(websiteYouth), for: .touchUpInside)
        youthPhone.addTarget(self, action: #selector(phoneChurch), for: .touchUpInside)
        pastorRichard.addTarget(self, action: #selector(emailRichard), for: .touchUpInside)
        andrewTai.addTarget(self, action: #selector(emailAndrew), for: .touchUpInside)
        justineShann.addTarget(self, action: #selector(emailJustine), for: .touchUpInside)
        chiTran.addTarget(self, action: #selector(emailChi), for: .touchUpInside)
        jessicaLiao.addTarget(self, action: #selector(emailJessica), for: .touchUpInside)
        jimyLiu.addTarget(self, action: #selector(emailJimy), for: .touchUpInside)
        margieChoa.addTarget(self, action: #selector(emailMargie), for: .touchUpInside)
        cynthiaChu.addTarget(self, action: #selector(emailCynthia), for: .touchUpInside)
        facebook.addTarget(self, action: #selector(goFacebook), for: .touchUpInside)
        youtube.addTarget(self, action: #selector(goYoutube), for: .touchUpInside)
        instagram.addTarget(self, action: #selector(goInstagram), for: .touchUpInside)
        twitter.addTarget(self, action: #selector(goTwitter), for: .touchUpInside)
        churchAddress.addTarget(self, action: #selector(addressChurch), for: .touchUpInside)
        churchPhone.addTarget(self, action: #selector(phoneChurch), for: .touchUpInside)
        churchFax.addTarget(self, action: #selector(faxChurch), for: .touchUpInside)
        churchEmail.addTarget(self, action: #selector(emailChurch), for: .touchUpInside)
        churchWebsite.addTarget(self, action: #selector(websiteChurch), for: .touchUpInside)
    }
    
    func emailYouth(_ sender: UIButton!){
        let email = "rolccyouth@gmail.com"
        let url = URL(string: "mailto:\(email)")
        UIApplication.shared.openURL(url!)
    }
    
    func websiteYouth(_ sender: UIButton!){
        let url = URL(string: "http://www.rolccyouth.com/")
        UIApplication.shared.openURL(url!)
    }
    
    func emailRichard(_ sender: UIButton!){
        let email = "richard.shang@rolcc.net"
        let url = URL(string: "mailto:\(email)")
        UIApplication.shared.openURL(url!)
    }
    
    func emailAndrew(_ sender: UIButton!){
        let email = "andrew.tai@rolcc.net"
        let url = URL(string: "mailto:\(email)")
        UIApplication.shared.openURL(url!)
    }
    
    func emailJustine(_ sender: UIButton!){
        let email = "justine.shann@rolcc.net"
        let url = URL(string: "mailto:\(email)")
        UIApplication.shared.openURL(url!)
    }
    
    func emailChi(_ sender: UIButton!){
        let email = "chi.tran@rolcc.net"
        let url = URL(string: "mailto:\(email)")
        UIApplication.shared.openURL(url!)
    }
    
    func emailJessica(_ sender: UIButton!){
        let email = "jessica.liao@rolcc.net"
        let url = URL(string: "mailto:\(email)")
        UIApplication.shared.openURL(url!)
    }
    
    func emailJimy(_ sender: UIButton!){
        let email = "jimy.liu@gmail.com"
        let url = URL(string: "mailto:\(email)")
        UIApplication.shared.openURL(url!)
    }
    
    func emailMargie(_ sender: UIButton!){
        let email = "margaret.choa@rolcc.net"
        let url = URL(string: "mailto:\(email)")
        UIApplication.shared.openURL(url!)
    }
    
    func emailCynthia(_ sender: UIButton!){
        let email = "oinkoinkchu@gmail.com"
        let url = URL(string: "mailto:\(email)")
        UIApplication.shared.openURL(url!)
    }
    
    func goFacebook(_ sender: UIButton!){
        let url = URL(string: "https://www.facebook.com/youth.rolcc/")
        UIApplication.shared.openURL(url!)
    }
    
    func goYoutube(_ sender: UIButton!){
        let url = URL(string: "https://www.youtube.com/user/rolccyouth/")
        UIApplication.shared.openURL(url!)
    }
    
    func goInstagram(_ sender: UIButton!){
        let url = URL(string: "https://www.instagram.com/rolccyouth/")
        UIApplication.shared.openURL(url!)
    }
    
    func goTwitter(_ sender: UIButton!){
        let url = URL(string: "https://twitter.com/rolccyouth")
        UIApplication.shared.openURL(url!)
    }
    
    func addressChurch(_ sender: UIButton!){
        let url = URL(string: "https://maps.apple.com/maps?address=1177%20Laurelwood%20Rd,%20Santa%20Clara,%20CA%20%2095054,%20United%20States&ll=37.379769,-121.952881&q=1177%20Laurelwood%20Rd,%20Santa%20Clara,%20CA%20%2095054,%20United%20States")
        UIApplication.shared.openURL(url!)
    }
    
    func phoneChurch(_ sender: UIButton!){
        let number = "4082600257"
        let alertController = UIAlertController(title: "(408) 260-0257", message:
            "Are you sure you want to call\n(408) 260-0257?", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default,handler: nil))
        alertController.addAction(UIAlertAction(title: "Call", style: UIAlertActionStyle.default,handler: { action in
            let url = URL(string: "tel://\(number)")
            UIApplication.shared.openURL(url!)
        }))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func faxChurch(_ sender: UIButton!){
        _ = "4087488877"
        let alertController = UIAlertController(title: "(408) 748-8877", message:
            "This is a fax number...", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Done", style: UIAlertActionStyle.default,handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    func emailChurch(_ sender: UIButton!){
        let email = "office@rolcc.net"
        let url = URL(string: "mailto:\(email)")
        UIApplication.shared.openURL(url!)
    }
    
    func websiteChurch(_ sender: UIButton!){
        let url = URL(string: "http://www.rolcc.net/")
        UIApplication.shared.openURL(url!)
    }
    
    func showMenu(){
        let menuViewController = storyboard!.instantiateViewController(withIdentifier: "MenuViewController")
        menuViewController.modalPresentationStyle = .custom
        menuViewController.transitioningDelegate = self
        
        presentationAnimator.animationDelegate = menuViewController as? GuillotineAnimationDelegate
        //presentationAnimator.supportView = navigationController!.navigationBar
        present(menuViewController, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

extension Contact: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        presentationAnimator.mode = .presentation
        return presentationAnimator
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        presentationAnimator.mode = .dismissal
        return presentationAnimator
    }
}
