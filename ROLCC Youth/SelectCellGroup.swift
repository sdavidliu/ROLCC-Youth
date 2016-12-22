//
//  SelectCellGroup.swift
//  ROLCC Youth
//
//  Created by Jimy Liu Mini on 9/4/16.
//  Copyright © 2016 Dave&Joe. All rights reserved.
//

import UIKit

class SelectCellGroup: UIViewController, UIScrollViewDelegate {
    
    fileprivate lazy var presentationAnimator = GuillotineTransitionAnimation()
    var modelName: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        switch identifier {
        case "iPod5,1":                                 return "iPod Touch 5"
        case "iPod7,1":                                 return "iPod Touch 6"
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "iPhone 4"
        case "iPhone4,1":                               return "iPhone 4s"
        case "iPhone5,1", "iPhone5,2":                  return "iPhone 5"
        case "iPhone5,3", "iPhone5,4":                  return "iPhone 5c"
        case "iPhone6,1", "iPhone6,2":                  return "iPhone 5s"
        case "iPhone7,2":                               return "iPhone 6"
        case "iPhone7,1":                               return "iPhone 6 Plus"
        case "iPhone8,1":                               return "iPhone 6s"
        case "iPhone8,2":                               return "iPhone 6s Plus"
        case "iPhone8,4":                               return "iPhone SE"
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return "iPad"
        case "iPad3,1", "iPad3,2", "iPad3,3":           return "iPad"
        case "iPad3,4", "iPad3,5", "iPad3,6":           return "iPad"
        case "iPad4,1", "iPad4,2", "iPad4,3":           return "iPad"
        case "iPad5,3", "iPad5,4":                      return "iPad"
        case "iPad2,5", "iPad2,6", "iPad2,7":           return "iPad"
        case "iPad4,4", "iPad4,5", "iPad4,6":           return "iPad"
        case "iPad4,7", "iPad4,8", "iPad4,9":           return "iPad"
        case "iPad5,1", "iPad5,2":                      return "iPad"
        case "iPad6,3", "iPad6,4", "iPad6,7", "iPad6,8":return "iPad"
        default:                                        return identifier
        }
    }
    
    @IBOutlet weak var berryessa: UIButton!
    @IBOutlet weak var cupertino1: UIButton!
    @IBOutlet weak var cupertino2: UIButton!
    @IBOutlet weak var cupertinoJH: UIButton!
    @IBOutlet weak var evergreen: UIButton!
    @IBOutlet weak var fremontA: UIButton!
    @IBOutlet weak var fremontB: UIButton!
    @IBOutlet weak var fremontJH: UIButton!
    @IBOutlet weak var morganHill: UIButton!
    @IBOutlet weak var paloAlto: UIButton!
    @IBOutlet weak var paloAltoJH: UIButton!
    @IBOutlet weak var sanCarlos: UIButton!
    @IBOutlet weak var saratoga1: UIButton!
    @IBOutlet weak var saratoga2: UIButton!
    @IBOutlet weak var saratogaJH: UIButton!
    @IBOutlet weak var sunnyvaleJH: UIButton!
    @IBOutlet weak var berryessaStar: DOFavoriteButton!
    @IBOutlet weak var cupertino1Star: DOFavoriteButton!
    @IBOutlet weak var cupertino2Star: DOFavoriteButton!
    @IBOutlet weak var cupertinoJHStar: DOFavoriteButton!
    @IBOutlet weak var evergreenStar: DOFavoriteButton!
    @IBOutlet weak var fremontAStar: DOFavoriteButton!
    @IBOutlet weak var fremontBStar: DOFavoriteButton!
    @IBOutlet weak var fremontJHStar: DOFavoriteButton!
    @IBOutlet weak var morganHillStar: DOFavoriteButton!
    @IBOutlet weak var paloAltoStar: DOFavoriteButton!
    @IBOutlet weak var paloAltoJHStar: DOFavoriteButton!
    @IBOutlet weak var sanCarlosStar: DOFavoriteButton!
    @IBOutlet weak var saratoga1Star: DOFavoriteButton!
    @IBOutlet weak var saratoga2Star: DOFavoriteButton!
    @IBOutlet weak var saratogaJHStar: DOFavoriteButton!
    @IBOutlet weak var sunnyvaleJHStar: DOFavoriteButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var berryessaToScrollView: NSLayoutConstraint!
    @IBOutlet weak var cupertino1ToBerryessa: NSLayoutConstraint!
    @IBOutlet weak var cupertino2ToCupertino1: NSLayoutConstraint!
    @IBOutlet weak var cupertinoJHToCupertino2: NSLayoutConstraint!
    @IBOutlet weak var evergreenToCupertinoJH: NSLayoutConstraint!
    @IBOutlet weak var fremontAToEvergreen: NSLayoutConstraint!
    @IBOutlet weak var fremontBToFremontA: NSLayoutConstraint!
    @IBOutlet weak var fremontJHToFremontB: NSLayoutConstraint!
    @IBOutlet weak var morganHillToScrollView: NSLayoutConstraint!
    @IBOutlet weak var paloAltoToMorganHill: NSLayoutConstraint!
    @IBOutlet weak var paloAltoJHToPaloAlto: NSLayoutConstraint!
    @IBOutlet weak var sanCarlosToPaloAltoJH: NSLayoutConstraint!
    @IBOutlet weak var saratoga1ToSanCarlos: NSLayoutConstraint!
    @IBOutlet weak var saratoga2ToSaratoga1: NSLayoutConstraint!
    @IBOutlet weak var saratogaJHToSaratoga2: NSLayoutConstraint!
    @IBOutlet weak var sunnyvaleJHToSaratogaJH: NSLayoutConstraint!
    
    
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    let images = ["berryessa.png", "cupertino1.png", "cupertino2.png", "cupertinoJH.png", "evergreen.png", "fremontA.png", "fremontB.png", "fremontJH.png", "morganHill.png", "paloAlto.png", "paloAltoJH.png", "sanCarlos.png", "saratoga1.png", "saratoga2.png", "saratogaJH.png", "sunnyvaleJH.png"]
    let labels = ["Berryessa", "Cupertino 1", "Cupertino 2", "Cupertino JH", "Evergreen", "Fremont A", "Fremont B", "Fremont JH", "Morgan Hill", "Palo Alto", "Palo Alto JH", "San Carlos", "Saratoga 1", "Saratoga 2", "Saratoga JH", "Sunnyvale JH"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let navBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 64))
        let navigationItem = UINavigationItem()
        navigationItem.title = "Cell Group"
        navBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "Avenir-Light", size: 15.0)!]
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named:"menubutton.png"), style: .plain, target: nil, action: #selector(showMenu))
        navigationItem.leftBarButtonItem?.tintColor = UIColor.gray
        navBar.items = [navigationItem]
        self.view.addSubview(navBar)
        
        scrollView.delegate = self
        scrollView.auk.settings.placeholderImage = UIImage(named: "LOGO.png")
        scrollView.auk.settings.errorImage = UIImage(named: "LOGO.png")
        scrollView.auk.settings.pageControl.visible = false
        scrollView.auk.settings.showsHorizontalScrollIndicator = true
        scrollView.auk.settings.contentMode = .scaleAspectFill
        
        for i in images{
            scrollView.auk.show(image: UIImage(named: i)!)
        }
        scrollView.auk.startAutoScroll(delaySeconds: 4.0)
        label.text = labels[0]
        
        berryessa.addTarget(self, action: #selector(berryessaAction), for: .touchUpInside)
        cupertino1.addTarget(self, action: #selector(cupertino1Action), for: .touchUpInside)
        cupertino2.addTarget(self, action: #selector(cupertino2Action), for: .touchUpInside)
        cupertinoJH.addTarget(self, action: #selector(cupertinoJHAction), for: .touchUpInside)
        evergreen.addTarget(self, action: #selector(evergreenAction), for: .touchUpInside)
        fremontA.addTarget(self, action: #selector(fremontAAction), for: .touchUpInside)
        fremontB.addTarget(self, action: #selector(fremontBAction), for: .touchUpInside)
        fremontJH.addTarget(self, action: #selector(fremontJHAction), for: .touchUpInside)
        morganHill.addTarget(self, action: #selector(morganHillAction), for: .touchUpInside)
        paloAlto.addTarget(self, action: #selector(paloAltoAction), for: .touchUpInside)
        paloAltoJH.addTarget(self, action: #selector(paloAltoJHAction), for: .touchUpInside)
        sanCarlos.addTarget(self, action: #selector(sanCarlosAction), for: .touchUpInside)
        saratoga1.addTarget(self, action: #selector(saratoga1Action), for: .touchUpInside)
        saratoga2.addTarget(self, action: #selector(saratoga2Action), for: .touchUpInside)
        saratogaJH.addTarget(self, action: #selector(saratogaJHAction), for: .touchUpInside)
        sunnyvaleJH.addTarget(self, action: #selector(sunnyvaleJHAction), for: .touchUpInside)
        
        berryessaStar.addTarget(self, action: #selector(berryessaTapped), for: .touchUpInside)
        cupertino1Star.addTarget(self, action: #selector(cupertino1Tapped), for: .touchUpInside)
        cupertino2Star.addTarget(self, action: #selector(cupertino2Tapped), for: .touchUpInside)
        cupertinoJHStar.addTarget(self, action: #selector(cupertinoJHTapped), for: .touchUpInside)
        evergreenStar.addTarget(self, action: #selector(evergreenTapped), for: .touchUpInside)
        fremontAStar.addTarget(self, action: #selector(fremontATapped), for: .touchUpInside)
        fremontBStar.addTarget(self, action: #selector(fremontBTapped), for: .touchUpInside)
        fremontJHStar.addTarget(self, action: #selector(fremontJHTapped), for: .touchUpInside)
        morganHillStar.addTarget(self, action: #selector(morganHillTapped), for: .touchUpInside)
        paloAltoStar.addTarget(self, action: #selector(paloAltoTapped), for: .touchUpInside)
        paloAltoJHStar.addTarget(self, action: #selector(paloAltoJHTapped), for: .touchUpInside)
        sanCarlosStar.addTarget(self, action: #selector(sanCarlosTapped), for: .touchUpInside)
        saratoga1Star.addTarget(self, action: #selector(saratoga1Tapped), for: .touchUpInside)
        saratoga2Star.addTarget(self, action: #selector(saratoga2Tapped), for: .touchUpInside)
        saratogaJHStar.addTarget(self, action: #selector(saratogaJHTapped), for: .touchUpInside)
        sunnyvaleJHStar.addTarget(self, action: #selector(sunnyvaleJHTapped), for: .touchUpInside)
        
        let defaults = UserDefaults.standard
        let favorite = defaults.string(forKey: "Favorite")
        if (favorite == "Berryessa"){
            berryessaStar.select()
        }else if (favorite == "Cupertino1"){
            cupertino1Star.select()
        }else if (favorite == "Cupertino2"){
            cupertino2Star.select()
        }else if (favorite == "CupertinoJH"){
            cupertinoJHStar.select()
        }else if (favorite == "Evergreen"){
            evergreenStar.select()
        }else if (favorite == "FremontA"){
            fremontAStar.select()
        }else if (favorite == "FremontB"){
            fremontBStar.select()
        }else if (favorite == "FremontJH"){
            fremontJHStar.select()
        }else if (favorite == "MorganHill"){
            morganHillStar.select()
        }else if (favorite == "PaloAlto"){
            paloAltoStar.select()
        }else if (favorite == "PaloAltoJH"){
            paloAltoJHStar.select()
        }else if (favorite == "SanCarlos"){
            sanCarlosStar.select()
        }else if (favorite == "Saratoga1"){
            saratoga1Star.select()
        }else if (favorite == "Saratoga2"){
            saratoga2Star.select()
        }else if (favorite == "SaratogaJH"){
            saratogaJHStar.select()
        }else if (favorite == "SunnyvaleJH"){
            sunnyvaleJHStar.select()
        }
        
        if (modelName == "iPhone 5" || modelName == "iPhone 5c" || modelName == "iPhone 5s" || modelName == "iPhone 6" || modelName == "iPhone 6s"){
            berryessaToScrollView.constant = 0
            cupertino1ToBerryessa.constant = -8
            cupertino2ToCupertino1.constant = -8
            cupertinoJHToCupertino2.constant = -8
            evergreenToCupertinoJH.constant = -8
            fremontAToEvergreen.constant = -8
            fremontBToFremontA.constant = -8
            fremontJHToFremontB.constant = -8
            morganHillToScrollView.constant = 0
            paloAltoToMorganHill.constant = -8
            paloAltoJHToPaloAlto.constant = -8
            sanCarlosToPaloAltoJH.constant = -8
            saratoga1ToSanCarlos.constant = -8
            saratoga2ToSaratoga1.constant = -8
            saratogaJHToSaratoga2.constant = -8
            sunnyvaleJHToSaratogaJH.constant = -8
        }else if (modelName == "iPhone 4" || modelName == "iPhone 4s"){
            berryessaToScrollView.constant = -5
            cupertino1ToBerryessa.constant = -10
            cupertino2ToCupertino1.constant = -10
            cupertinoJHToCupertino2.constant = -10
            evergreenToCupertinoJH.constant = -10
            fremontAToEvergreen.constant = -10
            fremontBToFremontA.constant = -10
            fremontJHToFremontB.constant = -10
            morganHillToScrollView.constant = -5
            paloAltoToMorganHill.constant = -10
            paloAltoJHToPaloAlto.constant = -10
            sanCarlosToPaloAltoJH.constant = -10
            saratoga1ToSanCarlos.constant = -10
            saratoga2ToSaratoga1.constant = -10
            saratogaJHToSaratoga2.constant = -10
            sunnyvaleJHToSaratogaJH.constant = -10
        }else{
            berryessaToScrollView.constant = 5
            cupertino1ToBerryessa.constant = 5
            cupertino2ToCupertino1.constant = 5
            cupertinoJHToCupertino2.constant = 5
            evergreenToCupertinoJH.constant = 5
            fremontAToEvergreen.constant = 5
            fremontBToFremontA.constant = 5
            fremontJHToFremontB.constant = 5
            morganHillToScrollView.constant = 5
            paloAltoToMorganHill.constant = 5
            paloAltoJHToPaloAlto.constant = 5
            sanCarlosToPaloAltoJH.constant = 5
            saratoga1ToSanCarlos.constant = 5
            saratoga2ToSaratoga1.constant = 5
            saratogaJHToSaratoga2.constant = 5
            sunnyvaleJHToSaratogaJH.constant = 5
        }
        
    }
    
    func showMenu(){
        let menuViewController = storyboard!.instantiateViewController(withIdentifier: "MenuViewController")
        menuViewController.modalPresentationStyle = .custom
        menuViewController.transitioningDelegate = self
        
        presentationAnimator.animationDelegate = menuViewController as? GuillotineAnimationDelegate
        present(menuViewController, animated: true, completion: nil)
    }
    
    func berryessaAction(_ sender: UIButton!) {
        let defaults = UserDefaults.standard
        defaults.setValue("Berryessa", forKey: "CellGroup")
        defaults.synchronize()
    }
    
    func cupertino1Action(_ sender: UIButton!) {
        let defaults = UserDefaults.standard
        defaults.setValue("Cupertino1", forKey: "CellGroup")
        defaults.synchronize()
    }
    
    func cupertino2Action(_ sender: UIButton!) {
        let defaults = UserDefaults.standard
        defaults.setValue("Cupertino2", forKey: "CellGroup")
        defaults.synchronize()
    }
    
    func cupertinoJHAction(_ sender: UIButton!) {
        let defaults = UserDefaults.standard
        defaults.setValue("CupertinoJH", forKey: "CellGroup")
        defaults.synchronize()
    }
    
    func evergreenAction(_ sender: UIButton!) {
        let defaults = UserDefaults.standard
        defaults.setValue("Evergreen", forKey: "CellGroup")
        defaults.synchronize()
    }
    
    func fremontAAction(_ sender: UIButton!) {
        let defaults = UserDefaults.standard
        defaults.setValue("FremontA", forKey: "CellGroup")
        defaults.synchronize()
    }
    
    func fremontBAction(_ sender: UIButton!) {
        let defaults = UserDefaults.standard
        defaults.setValue("FremontB", forKey: "CellGroup")
        defaults.synchronize()
    }
    
    func fremontJHAction(_ sender: UIButton!) {
        let defaults = UserDefaults.standard
        defaults.setValue("FremontJH", forKey: "CellGroup")
        defaults.synchronize()
    }
    
    func morganHillAction(_ sender: UIButton!) {
        let defaults = UserDefaults.standard
        defaults.setValue("MorganHill", forKey: "CellGroup")
        defaults.synchronize()
    }
    
    func paloAltoAction(_ sender: UIButton!) {
        let defaults = UserDefaults.standard
        defaults.setValue("PaloAlto", forKey: "CellGroup")
        defaults.synchronize()
    }
    
    func paloAltoJHAction(_ sender: UIButton!) {
        let defaults = UserDefaults.standard
        defaults.setValue("PaloAltoJH", forKey: "CellGroup")
        defaults.synchronize()
    }
    
    func sanCarlosAction(_ sender: UIButton!) {
        let defaults = UserDefaults.standard
        defaults.setValue("SanCarlos", forKey: "CellGroup")
        defaults.synchronize()
    }
    
    func saratoga1Action(_ sender: UIButton!) {
        let defaults = UserDefaults.standard
        defaults.setValue("Saratoga1", forKey: "CellGroup")
        defaults.synchronize()
    }
    
    func saratoga2Action(_ sender: UIButton!) {
        let defaults = UserDefaults.standard
        defaults.setValue("Saratoga2", forKey: "CellGroup")
        defaults.synchronize()
    }
    
    func saratogaJHAction(_ sender: UIButton!) {
        let defaults = UserDefaults.standard
        defaults.setValue("SaratogaJH", forKey: "CellGroup")
        defaults.synchronize()
    }
    
    func sunnyvaleJHAction(_ sender: UIButton!) {
        let defaults = UserDefaults.standard
        defaults.setValue("SunnyvaleJH", forKey: "CellGroup")
        defaults.synchronize()
    }
    
    func berryessaTapped(_ sender: DOFavoriteButton) {
        if sender.isSelected {
            sender.deselect()
            let defaults = UserDefaults.standard
            defaults.setValue(nil, forKey: "Favorite")
            defaults.synchronize()
        } else {
            sender.select()
            cupertino1Star.deselect()
            cupertino2Star.deselect()
            cupertinoJHStar.deselect()
            evergreenStar.deselect()
            fremontAStar.deselect()
            fremontBStar.deselect()
            fremontJHStar.deselect()
            morganHillStar.deselect()
            paloAltoStar.deselect()
            paloAltoJHStar.deselect()
            sanCarlosStar.deselect()
            saratoga1Star.deselect()
            saratoga2Star.deselect()
            saratogaJHStar.deselect()
            sunnyvaleJHStar.deselect()
            let defaults = UserDefaults.standard
            defaults.setValue("Berryessa", forKey: "Favorite")
            defaults.synchronize()
        }
    }
    
    func cupertino1Tapped(_ sender: DOFavoriteButton) {
        if sender.isSelected {
            sender.deselect()
            let defaults = UserDefaults.standard
            defaults.setValue(nil, forKey: "Favorite")
            defaults.synchronize()
        } else {
            sender.select()
            berryessaStar.deselect()
            cupertino2Star.deselect()
            cupertinoJHStar.deselect()
            evergreenStar.deselect()
            fremontAStar.deselect()
            fremontBStar.deselect()
            fremontJHStar.deselect()
            morganHillStar.deselect()
            paloAltoStar.deselect()
            paloAltoJHStar.deselect()
            sanCarlosStar.deselect()
            saratoga1Star.deselect()
            saratoga2Star.deselect()
            saratogaJHStar.deselect()
            sunnyvaleJHStar.deselect()
            let defaults = UserDefaults.standard
            defaults.setValue("Cupertino1", forKey: "Favorite")
            defaults.synchronize()
        }
    }
    
    func cupertino2Tapped(_ sender: DOFavoriteButton) {
        if sender.isSelected {
            sender.deselect()
            let defaults = UserDefaults.standard
            defaults.setValue(nil, forKey: "Favorite")
            defaults.synchronize()
        } else {
            sender.select()
            berryessaStar.deselect()
            cupertino1Star.deselect()
            cupertinoJHStar.deselect()
            evergreenStar.deselect()
            fremontAStar.deselect()
            fremontBStar.deselect()
            fremontJHStar.deselect()
            morganHillStar.deselect()
            paloAltoStar.deselect()
            paloAltoJHStar.deselect()
            sanCarlosStar.deselect()
            saratoga1Star.deselect()
            saratoga2Star.deselect()
            saratogaJHStar.deselect()
            sunnyvaleJHStar.deselect()
            let defaults = UserDefaults.standard
            defaults.setValue("Cupertino2", forKey: "Favorite")
            defaults.synchronize()
        }
    }
    
    func cupertinoJHTapped(_ sender: DOFavoriteButton) {
        if sender.isSelected {
            sender.deselect()
            let defaults = UserDefaults.standard
            defaults.setValue(nil, forKey: "Favorite")
            defaults.synchronize()
        } else {
            sender.select()
            berryessaStar.deselect()
            cupertino1Star.deselect()
            cupertino2Star.deselect()
            evergreenStar.deselect()
            fremontAStar.deselect()
            fremontBStar.deselect()
            fremontJHStar.deselect()
            morganHillStar.deselect()
            paloAltoStar.deselect()
            paloAltoJHStar.deselect()
            sanCarlosStar.deselect()
            saratoga1Star.deselect()
            saratoga2Star.deselect()
            saratogaJHStar.deselect()
            sunnyvaleJHStar.deselect()
            let defaults = UserDefaults.standard
            defaults.setValue("CupertinoJH", forKey: "Favorite")
            defaults.synchronize()
        }
    }
    
    func evergreenTapped(_ sender: DOFavoriteButton) {
        if sender.isSelected {
            sender.deselect()
            let defaults = UserDefaults.standard
            defaults.setValue(nil, forKey: "Favorite")
            defaults.synchronize()
        } else {
            sender.select()
            berryessaStar.deselect()
            cupertino1Star.deselect()
            cupertino2Star.deselect()
            cupertinoJHStar.deselect()
            fremontAStar.deselect()
            fremontBStar.deselect()
            fremontJHStar.deselect()
            morganHillStar.deselect()
            paloAltoStar.deselect()
            paloAltoJHStar.deselect()
            sanCarlosStar.deselect()
            saratoga1Star.deselect()
            saratoga2Star.deselect()
            saratogaJHStar.deselect()
            sunnyvaleJHStar.deselect()
            let defaults = UserDefaults.standard
            defaults.setValue("Evergreen", forKey: "Favorite")
            defaults.synchronize()
        }
    }
    
    func fremontATapped(_ sender: DOFavoriteButton) {
        if sender.isSelected {
            sender.deselect()
            let defaults = UserDefaults.standard
            defaults.setValue(nil, forKey: "Favorite")
            defaults.synchronize()
        } else {
            sender.select()
            berryessaStar.deselect()
            cupertino1Star.deselect()
            cupertino2Star.deselect()
            cupertinoJHStar.deselect()
            evergreenStar.deselect()
            fremontBStar.deselect()
            fremontJHStar.deselect()
            morganHillStar.deselect()
            paloAltoStar.deselect()
            paloAltoJHStar.deselect()
            sanCarlosStar.deselect()
            saratoga1Star.deselect()
            saratoga2Star.deselect()
            saratogaJHStar.deselect()
            sunnyvaleJHStar.deselect()
            let defaults = UserDefaults.standard
            defaults.setValue("FremontA", forKey: "Favorite")
            defaults.synchronize()
        }
    }
    
    func fremontBTapped(_ sender: DOFavoriteButton) {
        if sender.isSelected {
            sender.deselect()
            let defaults = UserDefaults.standard
            defaults.setValue(nil, forKey: "Favorite")
            defaults.synchronize()
        } else {
            sender.select()
            berryessaStar.deselect()
            cupertino1Star.deselect()
            cupertino2Star.deselect()
            cupertinoJHStar.deselect()
            evergreenStar.deselect()
            fremontAStar.deselect()
            fremontJHStar.deselect()
            morganHillStar.deselect()
            paloAltoStar.deselect()
            paloAltoJHStar.deselect()
            sanCarlosStar.deselect()
            saratoga1Star.deselect()
            saratoga2Star.deselect()
            saratogaJHStar.deselect()
            sunnyvaleJHStar.deselect()
            let defaults = UserDefaults.standard
            defaults.setValue("FremontB", forKey: "Favorite")
            defaults.synchronize()
        }
    }
    
    func fremontJHTapped(_ sender: DOFavoriteButton) {
        if sender.isSelected {
            sender.deselect()
            let defaults = UserDefaults.standard
            defaults.setValue(nil, forKey: "Favorite")
            defaults.synchronize()
        } else {
            sender.select()
            berryessaStar.deselect()
            cupertino1Star.deselect()
            cupertino2Star.deselect()
            cupertinoJHStar.deselect()
            evergreenStar.deselect()
            fremontAStar.deselect()
            fremontBStar.deselect()
            morganHillStar.deselect()
            paloAltoStar.deselect()
            paloAltoJHStar.deselect()
            sanCarlosStar.deselect()
            saratoga1Star.deselect()
            saratoga2Star.deselect()
            saratogaJHStar.deselect()
            sunnyvaleJHStar.deselect()
            let defaults = UserDefaults.standard
            defaults.setValue("FremontJH", forKey: "Favorite")
            defaults.synchronize()
        }
    }
    
    func morganHillTapped(_ sender: DOFavoriteButton) {
        if sender.isSelected {
            sender.deselect()
            let defaults = UserDefaults.standard
            defaults.setValue(nil, forKey: "Favorite")
            defaults.synchronize()
        } else {
            sender.select()
            berryessaStar.deselect()
            cupertino1Star.deselect()
            cupertino2Star.deselect()
            cupertinoJHStar.deselect()
            evergreenStar.deselect()
            fremontAStar.deselect()
            fremontBStar.deselect()
            fremontJHStar.deselect()
            paloAltoStar.deselect()
            paloAltoJHStar.deselect()
            sanCarlosStar.deselect()
            saratoga1Star.deselect()
            saratoga2Star.deselect()
            saratogaJHStar.deselect()
            sunnyvaleJHStar.deselect()
            let defaults = UserDefaults.standard
            defaults.setValue("MorganHill", forKey: "Favorite")
            defaults.synchronize()
        }
    }
    
    func paloAltoTapped(_ sender: DOFavoriteButton) {
        if sender.isSelected {
            sender.deselect()
            let defaults = UserDefaults.standard
            defaults.setValue(nil, forKey: "Favorite")
            defaults.synchronize()
        } else {
            sender.select()
            berryessaStar.deselect()
            cupertino1Star.deselect()
            cupertino2Star.deselect()
            cupertinoJHStar.deselect()
            evergreenStar.deselect()
            fremontAStar.deselect()
            fremontBStar.deselect()
            fremontJHStar.deselect()
            morganHillStar.deselect()
            paloAltoJHStar.deselect()
            sanCarlosStar.deselect()
            saratoga1Star.deselect()
            saratoga2Star.deselect()
            saratogaJHStar.deselect()
            sunnyvaleJHStar.deselect()
            let defaults = UserDefaults.standard
            defaults.setValue("PaloAlto", forKey: "Favorite")
            defaults.synchronize()
        }
    }
    
    func paloAltoJHTapped(_ sender: DOFavoriteButton) {
        if sender.isSelected {
            sender.deselect()
            let defaults = UserDefaults.standard
            defaults.setValue(nil, forKey: "Favorite")
            defaults.synchronize()
        } else {
            sender.select()
            berryessaStar.deselect()
            cupertino1Star.deselect()
            cupertino2Star.deselect()
            cupertinoJHStar.deselect()
            evergreenStar.deselect()
            fremontAStar.deselect()
            fremontBStar.deselect()
            fremontJHStar.deselect()
            morganHillStar.deselect()
            paloAltoStar.deselect()
            sanCarlosStar.deselect()
            saratoga1Star.deselect()
            saratoga2Star.deselect()
            saratogaJHStar.deselect()
            sunnyvaleJHStar.deselect()
            let defaults = UserDefaults.standard
            defaults.setValue("PaloAltoJH", forKey: "Favorite")
            defaults.synchronize()
        }
    }
    
    func sanCarlosTapped(_ sender: DOFavoriteButton) {
        if sender.isSelected {
            sender.deselect()
            let defaults = UserDefaults.standard
            defaults.setValue(nil, forKey: "Favorite")
            defaults.synchronize()
        } else {
            sender.select()
            berryessaStar.deselect()
            cupertino1Star.deselect()
            cupertino2Star.deselect()
            cupertinoJHStar.deselect()
            evergreenStar.deselect()
            fremontAStar.deselect()
            fremontBStar.deselect()
            fremontJHStar.deselect()
            morganHillStar.deselect()
            paloAltoStar.deselect()
            paloAltoJHStar.deselect()
            saratoga1Star.deselect()
            saratoga2Star.deselect()
            saratogaJHStar.deselect()
            sunnyvaleJHStar.deselect()
            let defaults = UserDefaults.standard
            defaults.setValue("SanCarlos", forKey: "Favorite")
            defaults.synchronize()
        }
    }
    
    func saratoga1Tapped(_ sender: DOFavoriteButton) {
        if sender.isSelected {
            sender.deselect()
            let defaults = UserDefaults.standard
            defaults.setValue(nil, forKey: "Favorite")
            defaults.synchronize()
        } else {
            sender.select()
            berryessaStar.deselect()
            cupertino1Star.deselect()
            cupertino2Star.deselect()
            cupertinoJHStar.deselect()
            evergreenStar.deselect()
            fremontAStar.deselect()
            fremontBStar.deselect()
            fremontJHStar.deselect()
            morganHillStar.deselect()
            paloAltoStar.deselect()
            paloAltoJHStar.deselect()
            sanCarlosStar.deselect()
            saratoga2Star.deselect()
            saratogaJHStar.deselect()
            sunnyvaleJHStar.deselect()
            let defaults = UserDefaults.standard
            defaults.setValue("Saratoga1", forKey: "Favorite")
            defaults.synchronize()
        }
    }
    
    func saratoga2Tapped(_ sender: DOFavoriteButton) {
        if sender.isSelected {
            sender.deselect()
            let defaults = UserDefaults.standard
            defaults.setValue(nil, forKey: "Favorite")
            defaults.synchronize()
        } else {
            sender.select()
            berryessaStar.deselect()
            cupertino1Star.deselect()
            cupertino2Star.deselect()
            cupertinoJHStar.deselect()
            evergreenStar.deselect()
            fremontAStar.deselect()
            fremontBStar.deselect()
            fremontJHStar.deselect()
            morganHillStar.deselect()
            paloAltoStar.deselect()
            paloAltoJHStar.deselect()
            sanCarlosStar.deselect()
            saratoga1Star.deselect()
            saratogaJHStar.deselect()
            sunnyvaleJHStar.deselect()
            let defaults = UserDefaults.standard
            defaults.setValue("Saratoga2", forKey: "Favorite")
            defaults.synchronize()
        }
    }
    
    func saratogaJHTapped(_ sender: DOFavoriteButton) {
        if sender.isSelected {
            sender.deselect()
            let defaults = UserDefaults.standard
            defaults.setValue(nil, forKey: "Favorite")
            defaults.synchronize()
        } else {
            sender.select()
            berryessaStar.deselect()
            cupertino1Star.deselect()
            cupertino2Star.deselect()
            cupertinoJHStar.deselect()
            evergreenStar.deselect()
            fremontAStar.deselect()
            fremontBStar.deselect()
            fremontJHStar.deselect()
            morganHillStar.deselect()
            paloAltoStar.deselect()
            paloAltoJHStar.deselect()
            sanCarlosStar.deselect()
            saratoga1Star.deselect()
            saratoga2Star.deselect()
            sunnyvaleJHStar.deselect()
            let defaults = UserDefaults.standard
            defaults.setValue("SaratogaJH", forKey: "Favorite")
            defaults.synchronize()
        }
    }
    
    func sunnyvaleJHTapped(_ sender: DOFavoriteButton) {
        if sender.isSelected {
            sender.deselect()
            let defaults = UserDefaults.standard
            defaults.setValue(nil, forKey: "Favorite")
            defaults.synchronize()
        } else {
            sender.select()
            berryessaStar.deselect()
            cupertino1Star.deselect()
            cupertino2Star.deselect()
            cupertinoJHStar.deselect()
            evergreenStar.deselect()
            fremontAStar.deselect()
            fremontBStar.deselect()
            fremontJHStar.deselect()
            morganHillStar.deselect()
            paloAltoStar.deselect()
            paloAltoJHStar.deselect()
            sanCarlosStar.deselect()
            saratoga1Star.deselect()
            saratoga2Star.deselect()
            saratogaJHStar.deselect()
            let defaults = UserDefaults.standard
            defaults.setValue("SunnyvaleJH", forKey: "Favorite")
            defaults.synchronize()
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if let imageIndex = scrollView.auk.currentPageIndex{
            if (imageIndex < labels.count){
                if (label.text != labels[imageIndex]){
                    label.text = labels[imageIndex]
                }
            }
        }
        scrollView.auk.startAutoScroll(delaySeconds: 4.0)
    }
    
    @IBAction func unwindToCellGroup(segue: UIStoryboardSegue) {
        
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

extension SelectCellGroup: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        presentationAnimator.mode = .presentation
        return presentationAnimator
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        presentationAnimator.mode = .dismissal
        return presentationAnimator
    }
}
