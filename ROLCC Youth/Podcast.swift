
import UIKit

class Podcast: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    fileprivate lazy var presentationAnimator = GuillotineTransitionAnimation()
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    var podcasts = [String]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let navBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 64))
        let navigationItem = UINavigationItem()
        navigationItem.title = "Recent Podcasts"
        navBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "Avenir-Light", size: 15.0)!]
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named:"menubutton.png"), style: .plain, target: nil, action: #selector(showMenu))
        navigationItem.leftBarButtonItem?.tintColor = UIColor.gray
        navBar.items = [navigationItem]
        self.view.addSubview(navBar)
        
        let reachability = Reachability()
        
        if (reachability?.isReachable == true){
            podcasts = AppDelegate.Database.podcastNames.components(separatedBy: ",")
            
            tableView.backgroundColor = UIColor.clear
            tableView.separatorColor = UIColor.white
            tableView.rowHeight = 80
            tableView.allowsSelection = true
            tableView.delegate = self
            tableView.dataSource = self
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return podcasts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:PodcastCell = tableView.dequeueReusableCell(withIdentifier: "PodcastCell")! as! PodcastCell
        
        let wordsArray = podcasts[indexPath.row].components(separatedBy: " ")
        
        cell.backgroundColor = UIColor.clear
        cell.titleLabel.text = wordsArray[0] + " " + wordsArray[1]
        cell.dateLabel.text = wordsArray[2] + " " + wordsArray[3]
        var person = ""
        for i in 4..<wordsArray.count{
            person += wordsArray[i] + " "
        }
        let endIndex = person.index(person.endIndex, offsetBy: -1)
        person = person.substring(to: endIndex)
        cell.personLabel.text = person
        if (podcasts[indexPath.row].hasPrefix("Sunday Worship")){
            cell.podcastImage.image = UIImage(named: "worship.png")
        }else if (podcasts[indexPath.row].hasPrefix("Sunday Sermon")){
            cell.podcastImage.image = UIImage(named: "sermon.jpg")
        }else{
            cell.podcastImage.image = UIImage(named: "logo.png")
        }
                
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let row = indexPath.row
        tableView.deselectRow(at: indexPath, animated: true)
        let podcastPlayerViewController = storyboard!.instantiateViewController(withIdentifier: "PodcastPlayer") as! PodcastPlayer
        podcastPlayerViewController.url = AppDelegate.Database.podcastDict[podcasts[row]]!
        let wordsArray = podcasts[indexPath.row].components(separatedBy: " ")
        var person = ""
        for i in 4..<wordsArray.count{
            person += wordsArray[i] + " "
        }
        let endIndex = person.index(person.endIndex, offsetBy: -1)
        person = person.substring(to: endIndex)
        podcastPlayerViewController.podcastTitle = wordsArray[0] + " " + wordsArray[1] + " - " + wordsArray[2] + " " + wordsArray[3]
        podcastPlayerViewController.personTitle = person
        present(podcastPlayerViewController, animated: true, completion: nil)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

extension Podcast: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        presentationAnimator.mode = .presentation
        return presentationAnimator
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        presentationAnimator.mode = .dismissal
        return presentationAnimator
    }
}
