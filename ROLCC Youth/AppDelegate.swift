//
//  AppDelegate.swift
//  ROLCC Youth
//
//  Created by David Liu on 12/11/16.
//  Copyright © 2016 David Liu. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var pagesPresenter: PageViewControllerPresenter!
    struct Database {
        static var cellGroups = Dictionary<String,Dictionary<String,String>>()
        static var podcastDict = Dictionary<String,String>()
        static var podcastNames = ""
        static var eventsDict = Dictionary<String,String>()
        static var eventsName = ""
        static var layer = "home"
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
                
        let pageControl = UIPageControl.appearance()
        pageControl.pageIndicatorTintColor = UIColor.lightGray
        pageControl.currentPageIndicatorTintColor = UIColor.black
        pageControl.backgroundColor = UIColor.white
                
        let reachability = Reachability()
        
        if (reachability?.isReachable)!{
            
            FIRApp.configure()
        
            let ref = FIRDatabase.database().reference()
            ref.observe(.value, with: { snapshot in
                
                let s = (snapshot.value! as AnyObject).object(forKey: "Cell Groups")! as! Dictionary<String,Dictionary<String,String>>
                Database.cellGroups = s
                
                let p = (snapshot.value! as AnyObject).object(forKey: "Podcasts")! as! Dictionary<String,String>
                Database.podcastDict = p
                Database.podcastNames = p["Name"]!
                
                let e = (snapshot.value! as AnyObject).object(forKey: "Events")! as! Dictionary<String,String>
                Database.eventsDict = e
                Database.eventsName = e["Name"]!
                
                
            }, withCancel: {
                (error:Error) -> Void in
                print(error.localizedDescription)
            })
        }else{
            Database.cellGroups = [
                "Saratoga 2": [
                    "Email": "fariaalbert@gmail.com",
                    "Head": "Albert & Ingrid",
                    "Time": "7:30 PM",
                    "Day": "Friday",
                    "Description": "Memes all day"],
                "San Carlos": [
                    "Email": "hollychen6@gmail.com",
                    "Head": "Holly & Aaron",
                    "Time": "7:00 PM",
                    "Day": "Saturday",
                    "Description": "We can rap"],
                "Cupertino 2": [
                    "Email": "joshuayhuang@gmail.com",
                    "Head": "Josh Huang",
                    "Time": "7:15 PM",
                    "Day": "Saturday",
                    "Description": "The Chen\'s House"],
                "Saratoga 1": [
                    "Email": "brian.poan.lin@gmail.com",
                    "Head": "Brian Lin",
                    "Time": "7:30 PM",
                    "Day": "Friday",
                    "Description": "Shadong"],
                "Fremont JH": [
                    "Email": "kevindanielleng@gmail.com",
                    "Head": "Daniel & Jessica",
                    "Time": "7:30 PM",
                    "Day": "Friday",
                    "Description": "We are huge"],
                "Sunnyvale JH": [
                    "Email": "johnnytest24911@gmail.com",
                    "Head": "Jonathan & Anouk",
                    "Time": "7:00 PM",
                    "Day": "Saturday",
                    "Description": "It\'s always sunny"],
                "Fremont B": [
                    "Email": "hailskyline@gmail.com",
                    "Head": "Shawn & Zoe",
                    "Time": "7:30 PM",
                    "Day": "Friday",
                    "Description": "We are the Program team"],
                "Berryessa": [
                    "Email": "moi.michelle18@gmail.com",
                    "Head": "Michelle Moi",
                    "Time": "7:30 PM",
                    "Day": "Saturday",
                    "Description": "Berry the Bear"],
                "Fremont A": [
                    "Email": "macklim8@gmail.com",
                    "Head": "Mackenzie & Quennie",
                    "Time": "7:30 PM",
                    "Day": "Friday",
                    "Description": "Bring on your A game"],
                "Cupertino 1": [
                    "Email": "nejosephliu@gmail.com",
                    "Head": "Joseph Liu",
                    "Time": "7:15 PM",
                    "Day": "Saturday",
                    "Description": "Boba"],
                "Cupertino JH": [
                    "Email": "ianjjhsiao@gmail.com",
                    "Head": "Ian & Grace",
                    "Time": "7:30 PM",
                    "Day": "Saturday",
                    "Description": "Biggest cell group"],
                "Evergreen": [
                    "Email": "lgd84719@gmail.com",
                    "Head": "Henry Zhang",
                    "Time": "7:30 PM",
                    "Day": "Friday",
                    "Description": "Stay green my friends"],
                "Morgan Hill": [
                    "Email": "twity54321@gmail.com",
                    "Head": "Justin Yu",
                    "Time": "7:00 PM",
                    "Day": "Saturday",
                    "Description": "Most diverse"],
                "Palo Alto JH": [
                    "Email": "kerrywusa@gmail.com",
                    "Head": "Kerry Wu",
                    "Time": "7:00 PM",
                    "Day": "Saturday",
                    "Description": "Future ganstas"],
                "Palo Alto": [
                    "Email": "ethankau@yahoo.com",
                    "Head": "Ethan Kau",
                    "Time": "7:00 PM",
                    "Day": "Saturday",
                    "Description": "Gansta"],
                "Saratoga JH": [
                    "Email": "jonathanko2014@gmail.com",
                    "Head": "Jonathan Ko",
                    "Time": "7:30 PM",
                    "Day": "Friday",
                    "Description": "Everyone loves Chi"]]
        }
        
        self.pagesPresenter = PageViewControllerPresenter(window: window!)
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

