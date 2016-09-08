//
//  SelectCellGroup.swift
//  ROLCC Youth
//
//  Created by Jimy Liu Mini on 9/4/16.
//  Copyright © 2016 Dave&Joe. All rights reserved.
//

import UIKit

class SelectCellGroup: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var berryessa: UIButton!
    @IBOutlet weak var cupertino1: UIButton!
    @IBOutlet weak var cupertino2: UIButton!
    @IBOutlet weak var evergreen: UIButton!
    @IBOutlet weak var fremontA: UIButton!
    @IBOutlet weak var fremontB: UIButton!
    @IBOutlet weak var morganHill: UIButton!
    @IBOutlet weak var paloAlto: UIButton!
    @IBOutlet weak var sanCarlos: UIButton!
    @IBOutlet weak var saratoga1: UIButton!
    @IBOutlet weak var saratoga2: UIButton!
    @IBOutlet weak var berryessaStar: DOFavoriteButton!
    @IBOutlet weak var cupertino1Star: DOFavoriteButton!
    @IBOutlet weak var cupertino2Star: DOFavoriteButton!
    @IBOutlet weak var evergreenStar: DOFavoriteButton!
    @IBOutlet weak var fremontAStar: DOFavoriteButton!
    @IBOutlet weak var fremontBStar: DOFavoriteButton!
    @IBOutlet weak var morganHillStar: DOFavoriteButton!
    @IBOutlet weak var paloAltoStar: DOFavoriteButton!
    @IBOutlet weak var sanCarlosStar: DOFavoriteButton!
    @IBOutlet weak var saratoga1Star: DOFavoriteButton!
    @IBOutlet weak var saratoga2Star: DOFavoriteButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var label: UILabel!
    
    let screenWidth = UIScreen.mainScreen().bounds.width
    let screenHeight = UIScreen.mainScreen().bounds.height
    let images = ["berryessa.png", "cupertino1.png", "fremontB.png", "saratoga1.png", "saratoga2.png"]
    let labels = ["Berryessa", "Cupertino 1", "Fremont B", "Saratoga 1", "Saratoga 2"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController!.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "Avenir-Light", size: 15)!]
        
        scrollView.delegate = self
        scrollView.auk.settings.placeholderImage = UIImage(named: "LOGO.png")
        scrollView.auk.settings.errorImage = UIImage(named: "LOGO.png")
        scrollView.auk.settings.pageControl.visible = false
        scrollView.auk.settings.showsHorizontalScrollIndicator = true
        scrollView.auk.settings.contentMode = .ScaleAspectFill
        
        for i in images{
            scrollView.auk.show(image: UIImage(named: i)!)
        }
        scrollView.auk.startAutoScroll(delaySeconds: 4.0)
        label.text = labels[0]
        
        berryessa.addTarget(self, action: #selector(berryessaAction), forControlEvents: .TouchUpInside)
        cupertino1.addTarget(self, action: #selector(cupertino1Action), forControlEvents: .TouchUpInside)
        cupertino2.addTarget(self, action: #selector(cupertino2Action), forControlEvents: .TouchUpInside)
        evergreen.addTarget(self, action: #selector(evergreenAction), forControlEvents: .TouchUpInside)
        fremontA.addTarget(self, action: #selector(fremontAAction), forControlEvents: .TouchUpInside)
        fremontB.addTarget(self, action: #selector(fremontBAction), forControlEvents: .TouchUpInside)
        morganHill.addTarget(self, action: #selector(morganHillAction), forControlEvents: .TouchUpInside)
        paloAlto.addTarget(self, action: #selector(paloAltoAction), forControlEvents: .TouchUpInside)
        sanCarlos.addTarget(self, action: #selector(sanCarlosAction), forControlEvents: .TouchUpInside)
        saratoga1.addTarget(self, action: #selector(saratoga1Action), forControlEvents: .TouchUpInside)
        saratoga2.addTarget(self, action: #selector(saratoga2Action), forControlEvents: .TouchUpInside)
        
        berryessaStar.addTarget(self, action: #selector(berryessaTapped), forControlEvents: .TouchUpInside)
        cupertino1Star.addTarget(self, action: #selector(cupertino1Tapped), forControlEvents: .TouchUpInside)
        cupertino2Star.addTarget(self, action: #selector(cupertino2Tapped), forControlEvents: .TouchUpInside)
        evergreenStar.addTarget(self, action: #selector(evergreenTapped), forControlEvents: .TouchUpInside)
        fremontAStar.addTarget(self, action: #selector(fremontATapped), forControlEvents: .TouchUpInside)
        fremontBStar.addTarget(self, action: #selector(fremontBTapped), forControlEvents: .TouchUpInside)
        morganHillStar.addTarget(self, action: #selector(morganHillTapped), forControlEvents: .TouchUpInside)
        paloAltoStar.addTarget(self, action: #selector(paloAltoTapped), forControlEvents: .TouchUpInside)
        sanCarlosStar.addTarget(self, action: #selector(sanCarlosTapped), forControlEvents: .TouchUpInside)
        saratoga1Star.addTarget(self, action: #selector(saratoga1Tapped), forControlEvents: .TouchUpInside)
        saratoga2Star.addTarget(self, action: #selector(saratoga2Tapped), forControlEvents: .TouchUpInside)
        
        let defaults = NSUserDefaults.standardUserDefaults()
        let favorite = defaults.stringForKey("Favorite")
        if (favorite == "Berryessa"){
            berryessaStar.select()
        }else if (favorite == "Cupertino1"){
            cupertino1Star.select()
        }else if (favorite == "Cupertino2"){
            cupertino2Star.select()
        }else if (favorite == "Evergreen"){
            evergreenStar.select()
        }else if (favorite == "FremontA"){
            fremontAStar.select()
        }else if (favorite == "FremontB"){
            fremontBStar.select()
        }else if (favorite == "MorganHill"){
            morganHillStar.select()
        }else if (favorite == "PaloAlto"){
            paloAltoStar.select()
        }else if (favorite == "SanCarlos"){
            sanCarlosStar.select()
        }else if (favorite == "Saratoga1"){
            saratoga1Star.select()
        }else if (favorite == "Saratoga2"){
            saratoga2Star.select()
        }
        
    }
    
    func berryessaAction(sender: UIButton!) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setValue("Berryessa", forKey: "CellGroup")
        defaults.synchronize()
    }
    
    func cupertino1Action(sender: UIButton!) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setValue("Cupertino1", forKey: "CellGroup")
        defaults.synchronize()
    }
    
    func cupertino2Action(sender: UIButton!) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setValue("Cupertino2", forKey: "CellGroup")
        defaults.synchronize()
    }
    
    func evergreenAction(sender: UIButton!) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setValue("Evergreen", forKey: "CellGroup")
        defaults.synchronize()
    }
    
    func fremontAAction(sender: UIButton!) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setValue("FremontA", forKey: "CellGroup")
        defaults.synchronize()
    }
    
    func fremontBAction(sender: UIButton!) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setValue("FremontB", forKey: "CellGroup")
        defaults.synchronize()
    }
    
    func morganHillAction(sender: UIButton!) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setValue("MorganHill", forKey: "CellGroup")
        defaults.synchronize()
    }
    
    func paloAltoAction(sender: UIButton!) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setValue("PaloAlto", forKey: "CellGroup")
        defaults.synchronize()
    }
    
    func sanCarlosAction(sender: UIButton!) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setValue("SanCarlos", forKey: "CellGroup")
        defaults.synchronize()
    }
    
    func saratoga1Action(sender: UIButton!) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setValue("Saratoga1", forKey: "CellGroup")
        defaults.synchronize()
    }
    
    func saratoga2Action(sender: UIButton!) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setValue("Saratoga2", forKey: "CellGroup")
        defaults.synchronize()
    }
    
    func berryessaTapped(sender: DOFavoriteButton) {
        if sender.selected {
            sender.deselect()
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setValue(nil, forKey: "Favorite")
            defaults.synchronize()
        } else {
            sender.select()
            cupertino1Star.deselect()
            cupertino2Star.deselect()
            evergreenStar.deselect()
            fremontAStar.deselect()
            fremontBStar.deselect()
            morganHillStar.deselect()
            paloAltoStar.deselect()
            sanCarlosStar.deselect()
            saratoga1Star.deselect()
            saratoga2Star.deselect()
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setValue("Berryessa", forKey: "Favorite")
            defaults.synchronize()
        }
    }
    
    func cupertino1Tapped(sender: DOFavoriteButton) {
        if sender.selected {
            sender.deselect()
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setValue(nil, forKey: "Favorite")
            defaults.synchronize()
        } else {
            sender.select()
            berryessaStar.deselect()
            cupertino2Star.deselect()
            evergreenStar.deselect()
            fremontAStar.deselect()
            fremontBStar.deselect()
            morganHillStar.deselect()
            paloAltoStar.deselect()
            sanCarlosStar.deselect()
            saratoga1Star.deselect()
            saratoga2Star.deselect()
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setValue("Cupertino1", forKey: "Favorite")
            defaults.synchronize()
        }
    }
    
    func cupertino2Tapped(sender: DOFavoriteButton) {
        if sender.selected {
            sender.deselect()
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setValue(nil, forKey: "Favorite")
            defaults.synchronize()
        } else {
            sender.select()
            berryessaStar.deselect()
            cupertino1Star.deselect()
            evergreenStar.deselect()
            fremontAStar.deselect()
            fremontBStar.deselect()
            morganHillStar.deselect()
            paloAltoStar.deselect()
            sanCarlosStar.deselect()
            saratoga1Star.deselect()
            saratoga2Star.deselect()
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setValue("Cupertino2", forKey: "Favorite")
            defaults.synchronize()
        }
    }
    
    func evergreenTapped(sender: DOFavoriteButton) {
        if sender.selected {
            sender.deselect()
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setValue(nil, forKey: "Favorite")
            defaults.synchronize()
        } else {
            sender.select()
            berryessaStar.deselect()
            cupertino1Star.deselect()
            cupertino2Star.deselect()
            fremontAStar.deselect()
            fremontBStar.deselect()
            morganHillStar.deselect()
            paloAltoStar.deselect()
            sanCarlosStar.deselect()
            saratoga1Star.deselect()
            saratoga2Star.deselect()
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setValue("Evergreen", forKey: "Favorite")
            defaults.synchronize()
        }
    }
    
    func fremontATapped(sender: DOFavoriteButton) {
        if sender.selected {
            sender.deselect()
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setValue(nil, forKey: "Favorite")
            defaults.synchronize()
        } else {
            sender.select()
            berryessaStar.deselect()
            cupertino1Star.deselect()
            cupertino2Star.deselect()
            evergreenStar.deselect()
            fremontBStar.deselect()
            morganHillStar.deselect()
            paloAltoStar.deselect()
            sanCarlosStar.deselect()
            saratoga1Star.deselect()
            saratoga2Star.deselect()
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setValue("FremontA", forKey: "Favorite")
            defaults.synchronize()
        }
    }
    
    func fremontBTapped(sender: DOFavoriteButton) {
        if sender.selected {
            sender.deselect()
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setValue(nil, forKey: "Favorite")
            defaults.synchronize()
        } else {
            sender.select()
            berryessaStar.deselect()
            cupertino1Star.deselect()
            cupertino2Star.deselect()
            evergreenStar.deselect()
            fremontAStar.deselect()
            morganHillStar.deselect()
            paloAltoStar.deselect()
            sanCarlosStar.deselect()
            saratoga1Star.deselect()
            saratoga2Star.deselect()
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setValue("FremontB", forKey: "Favorite")
            defaults.synchronize()
        }
    }
    
    func morganHillTapped(sender: DOFavoriteButton) {
        if sender.selected {
            sender.deselect()
            let defaults = NSUserDefaults.standardUserDefaults()
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
            paloAltoStar.deselect()
            sanCarlosStar.deselect()
            saratoga1Star.deselect()
            saratoga2Star.deselect()
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setValue("MorganHill", forKey: "Favorite")
            defaults.synchronize()
        }
    }
    
    func paloAltoTapped(sender: DOFavoriteButton) {
        if sender.selected {
            sender.deselect()
            let defaults = NSUserDefaults.standardUserDefaults()
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
            morganHillStar.deselect()
            sanCarlosStar.deselect()
            saratoga1Star.deselect()
            saratoga2Star.deselect()
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setValue("PaloAlto", forKey: "Favorite")
            defaults.synchronize()
        }
    }
    
    func sanCarlosTapped(sender: DOFavoriteButton) {
        if sender.selected {
            sender.deselect()
            let defaults = NSUserDefaults.standardUserDefaults()
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
            morganHillStar.deselect()
            paloAltoStar.deselect()
            saratoga1Star.deselect()
            saratoga2Star.deselect()
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setValue("SanCarlos", forKey: "Favorite")
            defaults.synchronize()
        }
    }
    
    func saratoga1Tapped(sender: DOFavoriteButton) {
        if sender.selected {
            sender.deselect()
            let defaults = NSUserDefaults.standardUserDefaults()
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
            morganHillStar.deselect()
            paloAltoStar.deselect()
            sanCarlosStar.deselect()
            saratoga2Star.deselect()
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setValue("Saratoga1", forKey: "Favorite")
            defaults.synchronize()
        }
    }
    
    func saratoga2Tapped(sender: DOFavoriteButton) {
        if sender.selected {
            sender.deselect()
            let defaults = NSUserDefaults.standardUserDefaults()
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
            morganHillStar.deselect()
            paloAltoStar.deselect()
            sanCarlosStar.deselect()
            saratoga1Star.deselect()
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setValue("Saratoga2", forKey: "Favorite")
            defaults.synchronize()
        }
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if let imageIndex = scrollView.auk.currentPageIndex{
            if (imageIndex < labels.count){
                if (label.text != labels[imageIndex]){
                    label.text = labels[imageIndex]
                }
            }
        }
        scrollView.auk.startAutoScroll(delaySeconds: 4.0)
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
