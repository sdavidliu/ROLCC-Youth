//
//  FirstViewController.swift
//  ROLCC Youth
//
//  Created by Jimy Liu Mini on 6/22/16.
//  Copyright © 2016 Dave&Joe. All rights reserved.
//

import UIKit

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIApplication.sharedApplication().statusBarStyle = .LightContent
        
        update()
        
        _ = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(UIMenuController.update), userInfo: nil, repeats: true)
        
        let thisWeek = UILabel(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 30))
        thisWeek.text = "This Week:"
        thisWeek.center = CGPoint(x: screenWidth/2, y: 470)
        thisWeek.textAlignment = NSTextAlignment.Center
        thisWeek.font = UIFont(name: "Avenir-Medium", size: 20)
        thisWeek.textColor = UIColor.whiteColor()
        self.view.addSubview(thisWeek)

        let preacher = UILabel(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 30))
        preacher.text = "Sermon: Pastor Richard"
        preacher.center = CGPoint(x: screenWidth/2, y: 500)
        preacher.textAlignment = NSTextAlignment.Center
        preacher.font = UIFont(name: "Avenir", size: 15)
        preacher.textColor = UIColor.whiteColor()
        self.view.addSubview(preacher)
        
        let worship = UILabel(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 30))
        worship.text = "Worship: Jessica"
        worship.center = CGPoint(x: screenWidth/2, y: 520)
        worship.textAlignment = NSTextAlignment.Center
        worship.font = UIFont(name: "Avenir", size: 15)
        worship.textColor = UIColor.whiteColor()
        self.view.addSubview(worship)
        
        let announcements = UILabel(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 30))
        announcements.text = "Announcements: Almaden"
        announcements.center = CGPoint(x: screenWidth/2, y: 540)
        announcements.textAlignment = NSTextAlignment.Center
        announcements.font = UIFont(name: "Avenir", size: 15)
        announcements.textColor = UIColor.whiteColor()
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
            emitterCell.contents = UIImage(named: "snowflake_white16.png")!.CGImage
            emitterCell.birthRate = 8
            emitterCell.lifetime = 15
            emitterCell.yAcceleration = 20.0
            emitterCell.xAcceleration = 1.0
            //    emitterCell.velocity = 20.0
            //    emitterCell.velocityRange = 250.0
            //
            //    emitterCell.emissionLongitude = CGFloat(-M_PI)
            //    emitterCell.emissionRange = CGFloat(M_PI_2)
            
            //    emitterCell.color = UIColor(red: 0.9, green: 1.0, blue: 1.0, alpha: 1.0).CGColor
            //    emitterCell.redRange   = 0.1
            //    emitterCell.greenRange = 0.1
            //    emitterCell.blueRange  = 0.1
            //
            emitterCell.scale = 1.8
            emitterCell.scaleRange = 1.0
            emitterCell.scaleSpeed = -0.15
            emitterCell.alphaRange = 1.00
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
        
        countdownTimer.text = String(format: "%02d", weekday) + ":" + String(format: "%02d", hours) + ":" + String(format: "%02d", minutes)
        
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

