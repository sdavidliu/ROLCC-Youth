//
//  Videos.swift
//  ROLCC Youth
//
//  Created by Jimy Liu Mini on 9/2/16.
//  Copyright © 2016 Dave&Joe. All rights reserved.
//

import UIKit

class Videos: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    //let videos = []
    var apiKey = "AIzaSyChah6DZrpkqxV2rvQ66L__4CSrF21uydE"
    var channelsDataArray: [NSDictionary] = []
    //var channelsDataArray: Array<Dictionary<NSObject, AnyObject>> = []
    var videosArray: Array<Dictionary<String, String>> = []
    //var videosArray: [NSDictionary] = []
    var channelIndex = 0
    var selectedVideoIndex: Int!

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let navBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 64))
        let navigationItem = UINavigationItem()
        navigationItem.title = "Latest Videos"
        navBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "Avenir-Light", size: 15.0)!];
        navBar.items = [navigationItem]
        self.view.addSubview(navBar)
        
        if (Reachability.isConnectedToNetwork() == true){
        
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
            errorMessage.font = UIFont(name: "Avenir-Light", size: 15.0)
            errorMessage.textColor = UIColor(red: 21/255, green: 21/255, blue: 21/255, alpha: 1.0)
            errorMessage.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 20.0)
            errorMessage.textAlignment = NSTextAlignment.center
            errorMessage.center = CGPoint(x: screenWidth/2, y: screenHeight/2 + 40)
            self.view.addSubview(errorMessage)
        }
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
        //let url = URL(string: "https://www.youtube.com/watch?v=" + (videosArray[selectedVideoIndex]["videoID"] as! String))
        //UIApplication.shared.openURL(url!)
        
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
                    //var desiredValuesDict = Dictionary<String,String>()
                    //let desiredValuesDict: NSDictionary = NSDictionary()
                    //desiredValuesDict["title"] = snippetDict["title"] as! String?
                    
                    let itemDict = (parsedData["items"] as! NSArray)
                    let snippetDict = itemDict.value(forKey: "snippet") as! NSArray
                    desiredValuesDict.updateValue(snippetDict.value(forKey: "title") as! AnyObject, forKey: "title")
                    desiredValuesDict.updateValue(snippetDict.value(forKey: "description") as! AnyObject, forKey: "description")
                    desiredValuesDict.updateValue((((snippetDict.value(forKey: "thumbnails") as! NSArray).value(forKey: "default") as! NSArray).value(forKey: "url") as! AnyObject), forKey: "thumbnail")
                    
                    let contentDict = itemDict.value(forKey: "contentDetails") as! NSArray
                    
                    //let firstDict = itemDict[0] as! NSDictionary
                    //print(firstDict.value(forKey: "contentDetails") as! NSArray)
                    desiredValuesDict.updateValue(((contentDict.value(forKey: "relatedPlaylists") as! NSArray).value(forKey: "uploads") as! AnyObject), forKey: "playlistID")
                    
                    print()
                    let test = desiredValuesDict["playlistID"].debugDescription
                    
                    self.channelsDataArray.append(desiredValuesDict as NSDictionary)
                    
                    self.getVideosForChannelAtIndex(0)
                    
                    // Reload the tableview.
                    self.tableView.reloadData()
                    
                    
                } catch let error as NSError {
                    print(error)
                }
            }
            
            }.resume()
        
        /*
        performGetRequest(targetURL, completion: { (data, HTTPStatusCode, error) -> Void in
            if HTTPStatusCode == 200 && error == nil {
                
                do {
                    // Convert the JSON data to a dictionary.
                    //let resultsDict = try JSONSerialization.jsonObject(with: data!, options: []) as! Dictionary<NSObject, AnyObject>
                    let resultsDict = try JSONSerialization.jsonObject(with: data!, options: []) as! NSDictionary
                    
                    let items = resultsDict["items"]
                    print(items as Any)
                    
                    
                    // Get the first dictionary item from the returned items (usually there's just one item).
                    let items: AnyObject! = resultsDict["items"] as AnyObject!
                    
                    //let firstItemDict = (items as! Array<AnyObject>)[0] as! Dictionary<NSObject, AnyObject>
                    let firstItemDict = (items as! Array<AnyObject>)[0] as! NSDictionary
                    
                    print()
                    print(firstItemDict)
                    print()
                    
                    // Get the snippet dictionary that contains the desired data.
                    let snippetDict = firstItemDict["snippet"] as! Dictionary<String, Dictionary<String,Dictionary<String,String>>>
                    //let snippetDict = firstItemDict["snippet"] as! NSDictionary
                    
                    // Create a new dictionary to store only the values we care about.
                    //var desiredValuesDict: Dictionary<NSObject, AnyObject> = Dictionary<NSObject, AnyObject>()
                    var desiredValuesDict = Dictionary<String,String>()
                    //let desiredValuesDict: NSDictionary = NSDictionary()
                    //desiredValuesDict["title"] = snippetDict["title"] as! String?
                    desiredValuesDict["title"] = (firstItemDict["snippet"] as! Dictionary)["title"]
                    
                    //desiredValuesDict.setValue(snippetDict.value(forKey: "title") as! String, forKey: "title")
                    //desiredValuesDict["description"] = snippetDict["description"]
                    
                    desiredValuesDict["thumbnail"] = snippetDict["thumbnails"]?["default"]?["url"]
                    
                    //desiredValuesDict.setValue("description", forKey: snippetDict.value(forKey: "description") as! String)
                    //desiredValuesDict.setValue("thumbnail", forKey: snippetDict.value(forKey: "thumbnail") as! String)
                    
                    // Save the channel's uploaded videos playlist ID.
                    let playlistTest = (firstItemDict["contentDetails"] as! Dictionary<String,Dictionary<String,String>>)["relatedPlaylists"]
                    print()
                    print(playlistTest as Any)
                    print()
                    desiredValuesDict["playlistID"] = playlistTest?["uploads"]
                    print(desiredValuesDict)
                    //desiredValuesDict.setValue("playlistID", forKey: ((firstItemDict.value(forKey: "contentDetails") as! NSDictionary).value(forKey: "relatedPlaylists") as! NSDictionary).value(forKey: "uploads") as! String)
                    
                    
                    // Append the desiredValuesDict dictionary to the following array.
                    self.channelsDataArray.append(desiredValuesDict as NSDictionary)
                    
                    self.getVideosForChannelAtIndex(0)
                    
                    // Reload the tableview.
                    self.tableView.reloadData()
                    
                } catch {
                    print(error)
                }
                
            } else {
                print("HTTP Status Code = \(HTTPStatusCode)")
                print("Error while loading channel details: \(error)")
            }
        })*/
    }
    
    func getVideosForChannelAtIndex(_ index: Int!) {
        // Get the selected channel's playlistID value from the channelsDataArray array and use it for fetching the proper video playlst.
        let playlistID = channelsDataArray[index]["playlistID"].debugDescription
        
        let playlistIDHardcode = "UUYD_bWBcs-ddO5otGM9qF4Q"
        
        // Form the request URL string.
        let urlString = "https://www.googleapis.com/youtube/v3/playlistItems?part=snippet&maxResults=10&playlistId=\(playlistIDHardcode)&key=\(apiKey)"
        
        // Create a NSURL object based on the above string.
        let targetURL = URL(string: urlString)
        
        // Fetch the playlist from Google.
        performGetRequest(targetURL, completion: { (data, HTTPStatusCode, error) -> Void in
            if HTTPStatusCode == 200 && error == nil {
                do {
                    // Convert the JSON data into a dictionary.
                    let resultsDict = try JSONSerialization.jsonObject(with: data!, options: []) as! NSDictionary
                    //let parsedData = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String:AnyObject]
                    
                    // Get all playlist items ("items" array).
                    //let items: NSDictionary = resultsDict["items"] as! NSDictionary
                    let items: NSArray = resultsDict["items"] as! NSArray
                    
                    // Use a loop to go through all video items.
                    for i in 0 ..< items.count {
                        
                        let playlistSnippetDict = (items[i] as! NSDictionary).value(forKey: "snippet") as! NSDictionary
                        
                        // Initialize a new dictionary and store the data of interest.
                        //let desiredPlaylistItemDataDict = NSDictionary()
                        var desiredPlaylistItemDataDict: Dictionary<String,String> = Dictionary<String,String>()
                        
                        //desiredPlaylistItemDataDict["title"] = playlistSnippetDict["title"]
                        //desiredPlaylistItemDataDict.setValue(playlistSnippetDict.value(forKey: "title") as! String, forKey: "title")
                        desiredPlaylistItemDataDict.updateValue(playlistSnippetDict.value(forKey: "title") as! String, forKey: "title")
                        
                        //desiredPlaylistItemDataDict["thumbnail"] = ((playlistSnippetDict["thumbnails"] as! Dictionary<NSObject, AnyObject>)["default"] as! Dictionary<NSObject, AnyObject>)["url"]
                        //desiredPlaylistItemDataDict.setValue("thumbnail", forKey: ((playlistSnippetDict.value(forKey: "thumbnails") as! NSDictionary).value(forKey: "default") as! NSDictionary).value(forKey: "url") as! String)
                        let thumbnailDict = playlistSnippetDict["thumbnails"] as! Dictionary<String,AnyObject>
                        desiredPlaylistItemDataDict.updateValue((thumbnailDict["default"] as! NSDictionary)["url"] as! String, forKey: "thumbnail")
                        //desiredPlaylistItemDataDict["videoID"] = (playlistSnippetDict["resourceId"] as! Dictionary<NSObject, AnyObject>)["videoId"]
                        //desiredPlaylistItemDataDict.setValue("videoID", forKey: (playlistSnippetDict.value(forKey: "resourceId") as! NSDictionary).value(forKey: "videoId") as! String)
                        let resourceDict = playlistSnippetDict["resourceId"] as! Dictionary<String,AnyObject>
                        desiredPlaylistItemDataDict.updateValue(resourceDict["videoId"] as! String, forKey: "videoID")
                        
                        // Append the desiredPlaylistItemDataDict dictionary to the videos array.
                        self.videosArray.append(desiredPlaylistItemDataDict)
                        
                        // Reload the tableview.
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
