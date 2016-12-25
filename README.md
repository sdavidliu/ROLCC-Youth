# ROLCC-Youth

Official ROLCC Youth app (Version 2.0)
Website: [ROLCC Youth](http://www.rolccyouth.com/#about)

## Features:

### Home menu
- Youth and Junior High Service Times
- Each week's speaker and worship leader

### Events
- 'UITableView' of upcoming events
- Slideshow with pictures featuring different events
- Displays date, time, location, and description from Database

### Cell Groups
- 'UICollectionView' of each cell group
- Includes group picture, meeting time, contact information, and short description
- Swipe or click to view more details

### Videos
- 'UITableView' of latest videos
- Grabs data from Youtube and links each video to Youtube app or webpage

### Podcasts (NEW)
- 'UITableView' of a couple of Sunday Worship & Sermons
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

## Pods Used
### I'm still learning Swift, so I found a lot of cool Github projects that I implemented in my app. Thank you to:
- [x] Firebase
- [x] Auk
- [x] BouncyPageViewController
- [x] GuillotineMenu
- [x] CNPPopupController
- [x] NVActivityIndicatorView
- [x] expanding-collection
- [x] Jukebox


