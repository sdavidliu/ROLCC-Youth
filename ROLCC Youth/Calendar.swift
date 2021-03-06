
import UIKit
import Firebase
import Auk
import CNPPopupController
import NVActivityIndicatorView

class Calendar: UIViewController, UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource {
    
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var imageLabel: UILabel!
    
    var events = [String]()
    var imagesURL = [URL]()
    var finalImages = [UIImage?]()
    var imagesDone = false
    fileprivate lazy var presentationAnimator = GuillotineTransitionAnimation()
    var popupController:CNPPopupController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIApplication.shared.statusBarStyle = .default
        
        let navBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 64))
        let navigationItem = UINavigationItem()
        navigationItem.title = "Events"
        navBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "Avenir-Light", size: 15.0)!]
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named:"menubutton.png"), style: .plain, target: nil, action: #selector(showMenu))
        navigationItem.leftBarButtonItem?.tintColor = UIColor.gray
        navBar.items = [navigationItem]
        self.view.addSubview(navBar)
        
        let reachability = Reachability()
        
        if (reachability?.isReachable == true){
            
            let activityIndicatorView = NVActivityIndicatorView(frame: CGRect(x: screenWidth/2-25, y: 170, width: 50, height: 50), type: NVActivityIndicatorType.ballBeat)
            activityIndicatorView.startAnimating()
            self.view.addSubview(activityIndicatorView)
            self.view.sendSubview(toBack: activityIndicatorView)
            
            scrollView.delegate = self
            scrollView.auk.settings.placeholderImage = UIImage(named: "LOGO.png")
            scrollView.auk.settings.errorImage = UIImage(named: "LOGO.png")
            scrollView.auk.settings.pageControl.visible = false
            scrollView.auk.settings.showsHorizontalScrollIndicator = true
            scrollView.auk.settings.contentMode = .scaleAspectFill
            
            events = AppDelegate.Database.eventsName.components(separatedBy: ",")
            imageLabel.text = events[0]
            finalImages = [UIImage?](repeating: nil, count: events.count)
            
            tableView.backgroundColor = UIColor.clear
            tableView.separatorColor = UIColor.white
            tableView.rowHeight = 70
            tableView.allowsSelection = true
            tableView.delegate = self
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
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if let imageIndex = scrollView.auk.currentPageIndex{
            if (imageIndex < events.count){
                if (imageLabel.text != events[imageIndex]){
                    imageLabel.text = events[imageIndex]
                }
            }
        }
        tableView.delegate = self
        scrollView.auk.startAutoScroll(delaySeconds: 5)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ArtistTableViewCell
        
        cell.backgroundColor = UIColor.clear
        
        let row = indexPath.row
        
        let detailsStr = AppDelegate.Database.eventsDict[events[row]]
        let details = detailsStr?.components(separatedBy: ",")
        let date = details?[0]
        let monthIndex = date?.characters.index((date?.startIndex)!, offsetBy: 3)
        let month = date?.substring(to: monthIndex!)
        let startIndex = date?.index((date?.endIndex)!, offsetBy: -4)
        let endIndex = date?.index((date?.endIndex)!, offsetBy: -3)
        var day = date?[startIndex!...endIndex!]
        if ((day?.substring(to: (day?.characters.index((day?.startIndex)!, offsetBy: 1))!))! == " "){
            day = "0" + (day?.substring(from: (day?.characters.index((day?.endIndex)!, offsetBy: -1))!))!
        }

        cell.dateLabel.text = month! + "\n" + day!
        
        if (self.imagesDone == false){
            let url = URL(string: (details?[4])!)
            self.imagesURL.append(url!)
            
            URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
                if error != nil {
                    return
                }
                DispatchQueue.main.async(execute: {
                    let test = UIImage(data: data!)
                    self.finalImages[row] = test
                    var allImages = false
                    for i in 0..<self.finalImages.count{
                        if (self.finalImages[i] == nil){
                            break
                        }else if (i == self.finalImages.count - 1){
                            allImages = true
                        }
                    }
                    if (allImages == true){
                        for i in self.finalImages{
                            self.scrollView.auk.show(image: i!)
                            self.scrollView.auk.startAutoScroll(delaySeconds: 5)
                        }
                        self.imagesDone = true
                    }
                })
            }).resume()
        }
        
        cell.eventLabel.text = events[indexPath.row]
        
        cell.eventLabel.textColor = UIColor.white
        cell.dateLabel.backgroundColor = UIColor.gray
        cell.dateLabel.textColor = UIColor.white
        cell.dateLabel.textAlignment = .center
        
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        scrollView.auk.startAutoScroll(delaySeconds: 5)
        
        let row = indexPath.row
        
        let detailsStr = AppDelegate.Database.eventsDict[events[row]]
        let details = detailsStr?.components(separatedBy: ",")
            
        self.showPopupWithStyle(title: self.events[row], date: (details?[0])!, time: (details?[1])!, location: (details?[2])!, description: (details?[3])!)
            
    }
    
    func showPopupWithStyle(title: String, date: String, time: String, location: String, description: String) {
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = NSLineBreakMode.byWordWrapping
        paragraphStyle.alignment = NSTextAlignment.center
                
        let title = NSAttributedString(string: title, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 28), NSForegroundColorAttributeName: UIColor.init(colorLiteralRed: 0.46, green: 0.8, blue: 1.0, alpha: 1.0), NSParagraphStyleAttributeName: paragraphStyle])
        let lineOne = NSAttributedString(string: "Date: \(date)\nTime: \(time)\nLocation: \(location)", attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 16), NSParagraphStyleAttributeName: paragraphStyle])
        let lineTwo = NSAttributedString(string: description, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 14), NSParagraphStyleAttributeName: paragraphStyle])
        
        let button = CNPPopupButton.init(frame: CGRect(x: 0, y: 0, width: 200, height: 60))
        button.setTitleColor(UIColor.white, for: UIControlState())
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.setTitle("Done", for: UIControlState())
        
        button.backgroundColor = UIColor.init(colorLiteralRed: 0.46, green: 0.8, blue: 1.0, alpha: 1.0)
        
        button.layer.cornerRadius = 4;
        button.selectionHandler = { (button) -> Void in
            self.popupController?.dismiss(animated: true)
        }
        
        let titleLabel = UILabel()
        titleLabel.numberOfLines = 0;
        titleLabel.attributedText = title
        
        let lineOneLabel = UILabel()
        lineOneLabel.numberOfLines = 0;
        lineOneLabel.attributedText = lineOne;
        
        
        let lineTwoLabel = UILabel()
        lineTwoLabel.numberOfLines = 0;
        lineTwoLabel.attributedText = lineTwo;
        
        let popupController = CNPPopupController(contents:[titleLabel, lineOneLabel, lineTwoLabel, button])
        popupController.theme = CNPPopupTheme.default()
        popupController.theme.popupStyle = CNPPopupStyle.centered
        popupController.delegate = self
        self.popupController = popupController
        popupController.present(animated: true)
    }
    
    @IBAction func unwindToEvents(segue: UIStoryboardSegue) {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension Calendar: UIViewControllerTransitioningDelegate, CNPPopupControllerDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        presentationAnimator.mode = .presentation
        return presentationAnimator
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        presentationAnimator.mode = .dismissal
        return presentationAnimator
    }
    
    func popupControllerWillDismiss(_ controller: CNPPopupController) {
        //print("Popup controller will be dismissed")
    }
    
    func popupControllerDidPresent(_ controller: CNPPopupController) {
        //print("Popup controller presented")
    }
}

