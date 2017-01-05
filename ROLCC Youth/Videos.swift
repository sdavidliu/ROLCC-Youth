
import UIKit

class Videos: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    var apiKey = "AIzaSyChah6DZrpkqxV2rvQ66L__4CSrF21uydE"
    var channelsDataArray: [NSDictionary] = []
    var videosArray: Array<Dictionary<String, String>> = []
    var channelIndex = 0
    var selectedVideoIndex: Int!
    fileprivate lazy var presentationAnimator = GuillotineTransitionAnimation()

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let navBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 64))
        let navigationItem = UINavigationItem()
        navigationItem.title = "Latest Videos"
        navBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "Avenir-Light", size: 15.0)!]
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named:"menubutton.png"), style: .plain, target: nil, action: #selector(showMenu))
        navigationItem.leftBarButtonItem?.tintColor = UIColor.gray
        navBar.items = [navigationItem]
        self.view.addSubview(navBar)
        
        let reachability = Reachability()
        
        if (reachability?.isReachable == true){
        
            tableView.backgroundColor = UIColor.clear
            tableView.separatorColor = UIColor.white
            tableView.rowHeight = 120
            tableView.allowsSelection = true
            tableView.delegate = self
            tableView.dataSource = self
            
            getChannelDetails()
        }else{
            tableView.isHidden = true
            
            let error = UIImageView(image: UIImage(named: "sadface2.png"))
            error.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
            error.center = CGPoint(x: screenWidth/2, y: screenHeight/2)
            self.view.addSubview(error)
            
            let errorMessage = UILabel()
            errorMessage.text = "No internet connection"
            errorMessage.font = UIFont(name: "Avenir", size: 15.0)
            errorMessage.textColor = UIColor(red: 50/255, green: 50/255, blue: 50/255, alpha: 1.0)
            errorMessage.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 20.0)
            errorMessage.textAlignment = NSTextAlignment.center
            errorMessage.center = CGPoint(x: screenWidth/2, y: screenHeight/2 + 40)
            self.view.addSubview(errorMessage)
        }
    }
    
    func showMenu(){
        let menuViewController = storyboard!.instantiateViewController(withIdentifier: "MenuViewController")
        menuViewController.modalPresentationStyle = .custom
        menuViewController.transitioningDelegate = self
        
        presentationAnimator.animationDelegate = menuViewController as? GuillotineAnimationDelegate
        present(menuViewController, animated: true, completion: nil)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120.0
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videosArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell!
        cell = tableView.dequeueReusableCell(withIdentifier: "idCellVideo", for: indexPath)
        
        let videoTitle = cell.viewWithTag(10) as! UILabel
        let videoThumbnail = cell.viewWithTag(11) as! UIImageView
        
        let videoDetails = videosArray[indexPath.row] as NSDictionary
        videoTitle.text = videoDetails["title"] as? String
        videoThumbnail.image = UIImage(data: try! Data(contentsOf: URL(string: (videoDetails["thumbnail"] as? String)!)!))
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedVideoIndex = indexPath.row
        
        let url = URL(string: "https://www.youtube.com/watch?v=\(videosArray[selectedVideoIndex]["videoID"]!)")
        UIApplication.shared.openURL(url!)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func performGetRequest(_ targetURL: URL!, completion: @escaping (_ data: Data?, _ HTTPStatusCode: Int, _ error: NSError?) -> Void) {
        
        let request = NSMutableURLRequest(url: targetURL)
        request.httpMethod = "GET"
        
        let sessionConfiguration = URLSessionConfiguration.default
        
        let session = URLSession(configuration: sessionConfiguration)
        
        let task = session.dataTask(with: targetURL, completionHandler: { (data: Data?, response:URLResponse?, error:Error?) -> Void in
            DispatchQueue.main.async(execute: { () -> Void in
                completion(data, (response as! HTTPURLResponse).statusCode, error as? NSError)
            })
        })
        
        task.resume()
    }
    
    func getChannelDetails() {
        var urlString: String!
        urlString = "https://www.googleapis.com/youtube/v3/channels?part=contentDetails,snippet&forUsername=rolccyouth&key=\(apiKey)"
        
        let targetURL = URL(string: urlString)
        
        URLSession.shared.dataTask(with:targetURL!) { (data, response, error) in
            if error != nil {
                print(error ?? "Error!")
            } else {
                do {
                    let parsedData = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String:AnyObject]
                    
                    var desiredValuesDict: Dictionary<String, AnyObject> = Dictionary<String, AnyObject>()
                    
                    let itemDict = (parsedData["items"] as! NSArray)
                    let snippetDict = itemDict.value(forKey: "snippet") as! NSArray
                    desiredValuesDict.updateValue(snippetDict.value(forKey: "title") as AnyObject, forKey: "title")
                    desiredValuesDict.updateValue(snippetDict.value(forKey: "description") as AnyObject, forKey: "description")
                    desiredValuesDict.updateValue((((snippetDict.value(forKey: "thumbnails") as! NSArray).value(forKey: "default") as! NSArray).value(forKey: "url") as AnyObject), forKey: "thumbnail")
                    
                    let contentDict = itemDict.value(forKey: "contentDetails") as! NSArray
                    
                    desiredValuesDict.updateValue(((contentDict.value(forKey: "relatedPlaylists") as! NSArray).value(forKey: "uploads") as AnyObject), forKey: "playlistID")
                                        
                    self.channelsDataArray.append(desiredValuesDict as NSDictionary)
                    
                    self.getVideosForChannelAtIndex(0)
                    
                    self.tableView.reloadData()
                    
                    
                } catch let error as NSError {
                    print(error)
                }
            }
            
            }.resume()
    }
    
    func getVideosForChannelAtIndex(_ index: Int!) {
        
        let playlistIDHardcode = "UUYD_bWBcs-ddO5otGM9qF4Q"
        
        let urlString = "https://www.googleapis.com/youtube/v3/playlistItems?part=snippet&maxResults=10&playlistId=\(playlistIDHardcode)&key=\(apiKey)"
        
        let targetURL = URL(string: urlString)
        
        performGetRequest(targetURL, completion: { (data, HTTPStatusCode, error) -> Void in
            if HTTPStatusCode == 200 && error == nil {
                do {
                    let resultsDict = try JSONSerialization.jsonObject(with: data!, options: []) as! NSDictionary
                    
                    let items: NSArray = resultsDict["items"] as! NSArray
                    
                    for i in 0 ..< items.count {
                        
                        let playlistSnippetDict = (items[i] as! NSDictionary).value(forKey: "snippet") as! NSDictionary
                        
                        var desiredPlaylistItemDataDict: Dictionary<String,String> = Dictionary<String,String>()
                        
                        desiredPlaylistItemDataDict.updateValue(playlistSnippetDict.value(forKey: "title") as! String, forKey: "title")
                        
                        let thumbnailDict = playlistSnippetDict["thumbnails"] as! Dictionary<String,AnyObject>
                        desiredPlaylistItemDataDict.updateValue((thumbnailDict["default"] as! NSDictionary)["url"] as! String, forKey: "thumbnail")
                        let resourceDict = playlistSnippetDict["resourceId"] as! Dictionary<String,AnyObject>
                        desiredPlaylistItemDataDict.updateValue(resourceDict["videoId"] as! String, forKey: "videoID")
                        
                        self.videosArray.append(desiredPlaylistItemDataDict)
                        
                        self.tableView.reloadData()
                    }
                } catch {
                    print(error)
                }
            }
            else {
                print("HTTP Status Code = \(HTTPStatusCode)")
                print("Error while loading channel videos: \(error)")
            }
        })
    }
    
    @IBAction func unwindToVideos(segue: UIStoryboardSegue) {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

extension Videos: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        presentationAnimator.mode = .presentation
        return presentationAnimator
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        presentationAnimator.mode = .dismissal
        return presentationAnimator
    }
}
