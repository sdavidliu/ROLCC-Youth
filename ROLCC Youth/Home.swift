//
//  FirstViewController.swift
//  ROLCC Youth
//
//  Created by Jimy Liu Mini on 6/22/16.
//  Copyright © 2016 Dave&Joe. All rights reserved.
//

import UIKit
import Firebase

class Home: UIViewController {
    
    @IBOutlet weak var countdownTimer: UILabel!
    @IBOutlet weak var bottomLabel: UILabel!
    @IBOutlet weak var youthLogo: UIButton!
    
    var count = 0
    var weekday = 0
    var hours = 0
    var minutes = 0
    let screenWidth = UIScreen.mainScreen().bounds.width
    let screenHeight = UIScreen.mainScreen().bounds.height
    let emitter = CAEmitterLayer()
    var animating = false
    var animationTimer = NSTimer()
    var array1 = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIApplication.sharedApplication().statusBarStyle = .Default
        
        let thisWeek = UILabel(frame: CGRect(x: 10, y: 0, width: screenWidth - 20, height: 30))
        thisWeek.text = "This Week:"
        thisWeek.center = CGPoint(x: screenWidth/2, y: screenHeight - 200)
        thisWeek.textAlignment = NSTextAlignment.Left
        thisWeek.font = UIFont(name: "Avenir-Medium", size: 20)
        //thisWeek.textColor = UIColor.whiteColor()
        self.view.addSubview(thisWeek)
        
        let ref = FIRDatabase.database().reference()
        ref.observeEventType(.Value, withBlock: { snapshot in
            
            let s = snapshot.value!.objectForKey("home")! as! String
            
            let Str = s.componentsSeparatedByString(",")
            
            for part in Str {
                self.array1.append(part)
            }
            
            self.showInfo()
            
            }, withCancelBlock: { error in
                print(error.description)
        })
        
        update()
        
        _ = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(UIMenuController.update), userInfo: nil, repeats: true)
        
    }
    
    func showInfo(){
        
        let preacher = UILabel(frame: CGRect(x: 10, y: 0, width: screenWidth - 20, height: 30))
        preacher.text = "Sermon: " + String(array1[0])
        preacher.center = CGPoint(x: screenWidth/2, y: screenHeight - 160)
        preacher.textAlignment = NSTextAlignment.Left
        preacher.font = UIFont(name: "Avenir", size: 15)
        //preacher.textColor = UIColor.whiteColor()
        self.view.addSubview(preacher)
        
        let worship = UILabel(frame: CGRect(x: 10, y: 0, width: screenWidth - 20, height: 30))
        worship.text = "Worship: " + String(array1[1])
        worship.center = CGPoint(x: screenWidth/2, y: screenHeight - 140)
        worship.textAlignment = NSTextAlignment.Left
        worship.font = UIFont(name: "Avenir", size: 15)
        //worship.textColor = UIColor.whiteColor()
        self.view.addSubview(worship)
        
        let announcements = UILabel(frame: CGRect(x: 10, y: 0, width: screenWidth - 20, height: 30))
        announcements.text = "Announcements: " + String(array1[2])
        announcements.center = CGPoint(x: screenWidth/2, y: screenHeight - 120)
        announcements.textAlignment = NSTextAlignment.Left
        announcements.font = UIFont(name: "Avenir", size: 15)
        //announcements.textColor = UIColor.whiteColor()
        self.view.addSubview(announcements)
        
        youthLogo.addTarget(self, action: #selector(test), forControlEvents: .TouchUpInside)
    }
    
    func test(sender: UIButton!){
        if (animating == false){
            animating = true
            
            let rect = CGRect(x: 0.0, y: -70.0, width: self.view.bounds.width, height: 50)
            
            emitter.birthRate = 1
            emitter.frame = rect
            self.view.layer.addSublayer(emitter)
            emitter.emitterShape = kCAEmitterLayerRectangle
            emitter.emitterPosition = CGPoint(x: rect.width/2, y: rect.height/2)
            emitter.emitterSize = rect.size
            
            let emitterCell = CAEmitterCell()
            let date = NSDate()
            let calendar = NSCalendar.currentCalendar()
            let components = calendar.components([.Month], fromDate: date)
            let month = components.month
            if (month == 12 || month == 1 || month == 2){
                emitterCell.contents = UIImage(named: "winter.png")!.CGImage
            }else if (month == 3 || month == 4 || month == 5){
                emitterCell.contents = UIImage(named: "spring.png")!.CGImage
            }else if (month == 6 || month == 7 || month == 8){
                emitterCell.contents = UIImage(named: "summer.png")!.CGImage
            }else{
                emitterCell.contents = UIImage(named: "fall.png")!.CGImage
            }
            emitterCell.birthRate = 8
            emitterCell.lifetime = 15
            emitterCell.yAcceleration = 20.0
            emitterCell.xAcceleration = 1.0
            //    emitterCell.velocity = 20.0
            //    emitterCell.velocityRange = 250.0
            //    emitterCell.emissionLongitude = CGFloat(-M_PI)
            //    emitterCell.emissionRange = CGFloat(M_PI_2)
            emitterCell.scale = 1.8
            emitterCell.scaleRange = 1.0
            emitterCell.scaleSpeed = -0.15
            emitterCell.alphaRange = 1.00
            emitterCell.spin = 0.5
            emitterCell.spinRange = 1.0
            emitterCell.alphaSpeed = -0.15
            emitterCell.lifetimeRange = 2.0
            
            emitter.emitterCells = [emitterCell]
            
            animationTimer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(runAnimation), userInfo: nil, repeats: true)
        }
    }
    
    func update() {
        
        let date = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.Weekday, .Hour, .Minute], fromDate: date)
        let currentWeekday = components.weekday
        let currentHour = components.hour
        let currentMin = components.minute
        
        minutes = 45 - currentMin
        if (minutes < 0){
            minutes += 60
        }
        hours = 9 - currentHour
        if (hours < 0){
            hours += 24
        }
        weekday = 7 - currentWeekday
        
        if (currentWeekday == 1 && currentHour >= 9 && currentMin >= 45){
            countdownTimer.text = "0:00:00"
        }else{
            countdownTimer.text = String(format: "%02d", weekday) + ":" + String(format: "%02d", hours) + ":" + String(format: "%02d", minutes)
        }
        
    }
    
    func runAnimation(){
        count += 1
        if (count > 15){
            emitter.birthRate = 0
            animating = false
            count = 0
            animationTimer.invalidate()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}

