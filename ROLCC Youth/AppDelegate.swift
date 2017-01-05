
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
        static var galleryDict = Dictionary<String,String>()
        static var galleryName = ""
        static var layer = "home"
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
                
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
                
                let g = (snapshot.value! as AnyObject).object(forKey: "Gallery")! as! Dictionary<String,String>
                Database.galleryDict = g
                Database.galleryName = g["Name"]!
                
                
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
                    "Description": "Memes all day, memes every day"],
                "San Carlos": [
                    "Email": "hollychen6@gmail.com",
                    "Head": "Holly & Aaron",
                    "Time": "7:00 PM",
                    "Day": "Saturday",
                    "Description": "We like to tongue-flick, do puns, and rap, but we also like to grow together and learn more about God."],
                "Cupertino 2": [
                    "Email": "joshuayhuang@gmail.com",
                    "Head": "Josh Huang",
                    "Time": "7:15 PM",
                    "Day": "Saturday",
                    "Description": "The Chen\'s House every week!"],
                "Saratoga 1": [
                    "Email": "brian.poan.lin@gmail.com",
                    "Head": "Brian Lin",
                    "Time": "7:30 PM",
                    "Day": "Friday",
                    "Description": "Shadong all day, Shadong every day"],
                "Fremont JH": [
                    "Email": "kevindanielleng@gmail.com",
                    "Head": "Daniel & Jessica",
                    "Time": "7:30 PM",
                    "Day": "Friday",
                    "Description": "Come to Fremont Junior High Cell Group to meet new friends and become part of the family!"],
                "Sunnyvale JH": [
                    "Email": "svjrhigh@gmail.com",
                    "Head": "Jonathan & Anouk",
                    "Time": "7:00 PM",
                    "Day": "Saturday",
                    "Description": "We are a group that wants to find out God\'s plan for us in many different ways such as prayer, discussion, fun, and games. We also have good food."],
                "Fremont B": [
                    "Email": "zoe.chen@students.tka.org",
                    "Head": "Shawn & Zoe",
                    "Time": "7:30 PM",
                    "Day": "Friday",
                    "Description": "We are one big family of eclectic people and we love to have fun while serving the Lord!"],
                "Berryessa": [
                    "Email": "moi.michelle18@gmail.com",
                    "Head": "Michelle Moi",
                    "Time": "7:30 PM",
                    "Day": "Saturday",
                    "Description": "We spread the love of God and proclaim the good news to the ones around us and other nations, in hopes that God may move in their lives!❤"],
                "Fremont A": [
                    "Email": "macklim8@gmail.com",
                    "Head": "Mackenzie & Quennie",
                    "Time": "7:30 PM",
                    "Day": "Friday",
                    "Description": "just a fun loving cell group that wants to get to know u better"],
                "Cupertino 1": [
                    "Email": "nejosephliu@gmail.com",
                    "Head": "Joseph Liu",
                    "Time": "7:15 PM",
                    "Day": "Saturday",
                    "Description": "Drinking Boba everyday"],
                "Cupertino JH": [
                    "Email": "ianjjhsiao@gmail.com",
                    "Head": "Ian & Grace",
                    "Time": "7:30 PM",
                    "Day": "Saturday",
                    "Description": "We're the biggest cell group"],
                "Evergreen": [
                    "Email": "lgd84719@gmail.com",
                    "Head": "Henry Zhang",
                    "Time": "7:30 PM",
                    "Day": "Friday",
                    "Description": "Stay green, Evergreen"],
                "Morgan Hill": [
                    "Email": "twity54321@gmail.com",
                    "Head": "Justin Yu",
                    "Time": "7:00 PM",
                    "Day": "Saturday",
                    "Description": "\"Why fit in when you can stand out?\" - The cellgroup where members come from 10 different cities"],
                "Palo Alto JH": [
                    "Email": "kerrywusa@gmail.com",
                    "Head": "Kerry Wu",
                    "Time": "7:00 PM",
                    "Day": "Saturday",
                    "Description": "Every saturday we meet together and pray so that we can understand God more through bible study."],
                "Palo Alto": [
                    "Email": "ethankau@yahoo.com",
                    "Head": "Ethan Kau",
                    "Time": "7:00 PM",
                    "Day": "Saturday",
                    "Description": "Palo is very tall"],
                "Saratoga JH": [
                    "Email": "jonathanko2014@gmail.com",
                    "Head": "Jonathan Ko",
                    "Time": "7:30 PM",
                    "Day": "Friday",
                    "Description": "food, fellowship, and fun"]]
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

