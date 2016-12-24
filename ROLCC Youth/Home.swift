//
//  FirstViewController.swift
//  ROLCC Youth
//
//  Created by Jimy Liu Mini on 6/22/16.
//  Copyright © 2016 Dave&Joe. All rights reserved.
//

import UIKit
import Firebase
import SnapKit

class Home: UIViewController {
    
    @IBOutlet weak var daysLabel: UILabel!
    @IBOutlet weak var hoursLabel: UILabel!
    @IBOutlet weak var minutesLabel: UILabel!
    @IBOutlet weak var bottomLabel: UILabel!
    @IBOutlet weak var youthLogo: UIButton!
    
    var count = 0
    var weekday = 0
    var hours = 0
    var minutes = 0
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    let emitter = CAEmitterLayer()
    var animating = false
    var animationTimer = Timer()
    var array1 = [String]()
    var updatedToZero = false
    //@IBOutlet weak var daysProgress: RPCircularProgress!
    //@IBOutlet weak var hoursProgress: RPCircularProgress!
    //@IBOutlet weak var minutesProgress: RPCircularProgress!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIApplication.shared.statusBarStyle = .default
        
        let navBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 64))
        let navigationItem = UINavigationItem()
        navigationItem.title = "Home"
        navBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "Avenir-Light", size: 15.0)!];
        navBar.items = [navigationItem]
        self.view.addSubview(navBar)
        /*
        daysProgress.trackTintColor = UIColor.init(red: 226 / 255, green: 74 / 255, blue: 144 / 255, alpha: 0.3)
        daysProgress.progressTintColor = UIColor.init(red: 226 / 255, green: 74 / 255, blue: 144 / 255, alpha: 1)
        daysProgress.thicknessRatio = 0.3
        
        hoursProgress.trackTintColor = UIColor.init(red: 74 / 255, green: 144 / 255, blue: 226 / 255, alpha: 0.3)
        hoursProgress.progressTintColor = UIColor.init(red: 74 / 255, green: 144 / 255, blue: 226 / 255, alpha: 1)
        hoursProgress.thicknessRatio = 0.3
        
        minutesProgress.trackTintColor = UIColor.init(red: 144 / 255, green: 226 / 255, blue: 74 / 255, alpha: 0.3)
        minutesProgress.progressTintColor = UIColor.init(red: 144 / 255, green: 226 / 255, blue: 74 / 255, alpha: 1)
        minutesProgress.thicknessRatio = 0.3
        */
        
        let reachability = Reachability()
        
        if (reachability?.isReachable == true){
            
            let thisWeek = UILabel(frame: CGRect(x: 10, y: 0, width: screenWidth - 20, height: 30))
            thisWeek.text = "This Week:"
            thisWeek.center = CGPoint(x: screenWidth/2, y: screenHeight - 130)
            thisWeek.textAlignment = NSTextAlignment.center
            thisWeek.font = UIFont(name: "Avenir", size: 18)
            thisWeek.textColor = UIColor.white
            self.view.addSubview(thisWeek)
            
            let highSchool = UILabel(frame: CGRect(x: 10, y: 0, width: screenWidth - 20, height: 30))
            highSchool.text = "High School:"
            highSchool.center = CGPoint(x: screenWidth/4, y: screenHeight - 110)
            highSchool.textAlignment = NSTextAlignment.center
            highSchool.font = UIFont(name: "Avenir", size: 15)
            highSchool.textColor = UIColor.white
            self.view.addSubview(highSchool)
            
            let juniorHigh = UILabel(frame: CGRect(x: 10, y: 0, width: screenWidth - 20, height: 30))
            juniorHigh.text = "Junior High:"
            juniorHigh.center = CGPoint(x: screenWidth*3/4, y: screenHeight - 110)
            juniorHigh.textAlignment = NSTextAlignment.center
            juniorHigh.font = UIFont(name: "Avenir", size: 15)
            juniorHigh.textColor = UIColor.white
            self.view.addSubview(juniorHigh)
        
            let ref = FIRDatabase.database().reference()
            ref.observe(.value, with: { snapshot in
                
                let s = (snapshot.value! as AnyObject).object(forKey: "home")! as! String
                
                let Str = s.components(separatedBy: ",")
                
                for part in Str {
                    self.array1.append(part)
                }
                
                self.showInfo()
                
                
            }, withCancel: {
                (error:Error) -> Void in
                print(error.localizedDescription)
            })
        }
        
        update()
        
        _ = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(UIMenuController.update), userInfo: nil, repeats: true)
        
    }
    
    func showInfo(){
        
        let hsPreacher = UILabel(frame: CGRect(x: 10, y: 0, width: screenWidth - 20, height: 30))
        hsPreacher.text = "Sermon: " + String(array1[0])
        hsPreacher.center = CGPoint(x: screenWidth/4, y: screenHeight - 90)
        hsPreacher.textAlignment = NSTextAlignment.center
        hsPreacher.font = UIFont(name: "Avenir-Light", size: 13)
        hsPreacher.textColor = UIColor.white
        self.view.addSubview(hsPreacher)
        
        let hsWorship = UILabel(frame: CGRect(x: 10, y: 0, width: screenWidth - 20, height: 30))
        hsWorship.text = "Worship: " + String(array1[1])
        hsWorship.center = CGPoint(x: screenWidth/4, y: screenHeight - 70)
        hsWorship.textAlignment = NSTextAlignment.center
        hsWorship.font = UIFont(name: "Avenir-Light", size: 13)
        hsWorship.textColor = UIColor.white
        self.view.addSubview(hsWorship)
        
        let jhPreacher = UILabel(frame: CGRect(x: 10, y: 0, width: screenWidth - 20, height: 30))
        jhPreacher.text = "Sermon: " + String(array1[2])
        jhPreacher.center = CGPoint(x: screenWidth*3/4, y: screenHeight - 90)
        jhPreacher.textAlignment = NSTextAlignment.center
        jhPreacher.font = UIFont(name: "Avenir-Light", size: 13)
        jhPreacher.textColor = UIColor.white
        self.view.addSubview(jhPreacher)
        
        let jhWorship = UILabel(frame: CGRect(x: 10, y: 0, width: screenWidth - 20, height: 30))
        jhWorship.text = "Worship: " + String(array1[3])
        jhWorship.center = CGPoint(x: screenWidth*3/4, y: screenHeight - 70)
        jhWorship.textAlignment = NSTextAlignment.center
        jhWorship.font = UIFont(name: "Avenir-Light", size: 13)
        jhWorship.textColor = UIColor.white
        self.view.addSubview(jhWorship)
        
        youthLogo.addTarget(self, action: #selector(test), for: .touchUpInside)
    }
    
    func test(_ sender: UIButton!){
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
            let date = Date()
            let calendar = Foundation.Calendar.current
            let components = (calendar as NSCalendar).components([.month], from: date)
            let month = components.month
            if (month == 12 || month == 1 || month == 2){
                emitterCell.contents = UIImage(named: "winter.png")!.cgImage
            }else if (month == 3 || month == 4 || month == 5){
                emitterCell.contents = UIImage(named: "spring.png")!.cgImage
            }else if (month == 6 || month == 7 || month == 8){
                emitterCell.contents = UIImage(named: "summer.png")!.cgImage
            }else{
                emitterCell.contents = UIImage(named: "fall.png")!.cgImage
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
            
            animationTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(runAnimation), userInfo: nil, repeats: true)
        }
    }
    
    func update() {
        
        let date = Date()
        let calendar = Foundation.Calendar.current
        let components = (calendar as NSCalendar).components([.weekday, .hour, .minute], from: date)
        let currentWeekday = components.weekday
        let currentHour = components.hour
        let currentMin = components.minute
        
        let oldMinutes = minutes
        let oldHours = hours
        let oldWeekday = weekday
        
        minutes = 45 - currentMin!
        if (minutes < 0){
            minutes += 60
            hours = 8 - currentHour!
            if (hours < 0){
                hours += 24
                weekday = 1 - currentWeekday!
                if (weekday < 0){
                    weekday += 6
                }
            }else{
                weekday = 1 - currentWeekday!
                if (weekday < 0){
                    weekday += 7
                }
            }
        }else{
            hours = 9 - currentHour!
            if (hours < 0){
                hours += 24
                weekday = 1 - currentWeekday!
                if (weekday < 0){
                    weekday += 6
                }
            }else{
                weekday = 1 - currentWeekday!
                if (weekday < 0){
                    weekday += 7
                }
            }
        }
        /*
        if (currentWeekday! == 1 && ((currentHour! >= 10) || (currentHour! == 9 && currentMin! >= 45))){
            daysLabel.text = "0"
            hoursLabel.text = "0"
            minutesLabel.text = "0"
            
            if (oldMinutes != minutes){
                minutesProgress.updateProgress(1, initialDelay: 0.4, duration: 3)
            }
            if (oldHours != hours){
                hoursProgress.updateProgress(1, initialDelay: 0.4, duration: 3)
            }
            if (oldWeekday != weekday){
                daysProgress.updateProgress(1, initialDelay: 0.4, duration: 3)
            }
            if (updatedToZero == false){
                daysProgress.updateProgress(1, initialDelay: 0.4, duration: 3)
                updatedToZero = true
            }
        }else{
            daysLabel.text = String(weekday)
            hoursLabel.text = String(hours)
            minutesLabel.text = String(minutes)
            if (oldMinutes != minutes){
                minutesProgress.updateProgress(CGFloat(60 - minutes)/60.0, initialDelay: 0.4, duration: 3)
            }
            if (oldHours != hours){
                hoursProgress.updateProgress(CGFloat(24 - hours)/24.0, initialDelay: 0.4, duration: 3)
            }
            if (oldWeekday != weekday){
                daysProgress.updateProgress(CGFloat(6 - weekday)/6.0, initialDelay: 0.4, duration: 3)
            }
        }*/
    }
    
    func runAnimation(){
        count += 1
        if (count > 5){
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


