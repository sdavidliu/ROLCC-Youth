# ROLCC-Youth

#### Official ROLCC Youth app (Version 2.0)
#### Website: [ROLCC Youth](http://www.rolccyouth.com/#about)
#### App Store Link: [https://itunes.apple.com/us/app/rolcc-youth/id1153965380](https://itunes.apple.com/us/app/rolcc-youth/id1153965380)

## Features:

### Home menu
- Youth and Junior High Service Times
- Each week's speaker and worship leader

### Events
- 'UITableView' of upcoming events
- Slideshow with pictures featuring different events
- Displays date, time, location, and description from Database

### Cell Groups
- CollectionView of each cell group
- Includes group picture, meeting time, contact information, and short description
- Swipe or click to view more details

### Videos
- TableView of latest videos
- Grabs data from Youtube and links each video to Youtube app or webpage

### Podcasts (NEW)
- TableView of a couple of Sunday Worship & Sermons
- Listen on the go wherever you are

### Contact
- Contact information for leaders in Youth and JH Ministry
- Links to social media sites and more info about ROLCC

### Other Info
Most of the app's features require internet connection in order to retrieve information from Google Firebase:
```swift
FIRApp.configure()
let ref = FIRDatabase.database().reference()
ref.observe(.value, with: { snapshot in
let s = (snapshot.value! as AnyObject).object(forKey: "Cell Groups")! as! Dictionary<String,Dictionary<String,String>>
```

## Screenshots:

![Home](https://raw.githubusercontent.com/sdavidliu/ROLCC-Youth/master/Screenshots/IMG_1867.PNG)
![Menu](https://raw.githubusercontent.com/sdavidliu/ROLCC-Youth/master/Screenshots/IMG_1868.PNG)
![Events](https://raw.githubusercontent.com/sdavidliu/ROLCC-Youth/master/Screenshots/IMG_1869.PNG)
![Videos](https://raw.githubusercontent.com/sdavidliu/ROLCC-Youth/master/Screenshots/IMG_1870.PNG)

## Credit
#### Since I'm still learning Swift, I took a lot of cool Github projects online and implemented it in my app. Special thanks to:
- [x] Firebase
- [x] Auk
- [x] BouncyPageViewController
- [x] GuillotineMenu
- [x] CNPPopupController
- [x] NVActivityIndicatorView
- [x] expanding-collection
- [x] Jukebox

