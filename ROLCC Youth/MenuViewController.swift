
import UIKit

class MenuViewController: UIViewController, GuillotineMenu, UITableViewDelegate, UITableViewDataSource {
    
    var dismissButton: UIButton?
    var titleLabel: UILabel?
    @IBOutlet weak var tableView: UITableView!
    let buttons = ["Events", "Cell Group", "Videos", "Podcasts", "Gallery", "Contact", "Close"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIApplication.shared.statusBarStyle = .lightContent
        
        dismissButton = {
            let button = UIButton(frame: .zero)
            button.setImage(UIImage(named: "ic_menu"), for: .normal)
            button.addTarget(self, action: #selector(dismissButtonTapped(_:)), for: .touchUpInside)
            return button
        }()
        
        titleLabel = {
            let label = UILabel()
            label.numberOfLines = 1;
            label.text = ""
            label.font = UIFont.boldSystemFont(ofSize: 17)
            label.textColor = UIColor.white
            label.sizeToFit()
            return label
        }()
        
        tableView.backgroundColor = UIColor.clear
        tableView.separatorColor = UIColor.white
        tableView.allowsSelection = true
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return buttons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath) as! MenuCell
        
        let row = indexPath.row
        
        if (row == 0){
            cell.indicator.backgroundColor = UIColor(red: 255/255, green: 0/255, blue: 170/255, alpha: 1.0)
            cell.icon.image = UIImage(named: "eventsicon.png")
        }else if (row == 1){
            cell.indicator.backgroundColor = UIColor.orange
            cell.icon.image = UIImage(named: "groupicon.png")
        }else if (row == 2){
            cell.indicator.backgroundColor = UIColor.yellow
            cell.icon.image = UIImage(named: "videosicon.png")
        }else if (row == 3){
            cell.indicator.backgroundColor = UIColor(red: 170/255, green: 255/255, blue: 0/255, alpha: 1.0)
            cell.icon.image = UIImage(named: "podcasticon.png")
        }else if (row == 4){
            cell.indicator.backgroundColor = UIColor(red: 0/255, green: 170/255, blue: 255/255, alpha: 1.0)
            cell.icon.image = UIImage(named: "albumicon.png")
        }else if (row == 5){
            cell.indicator.backgroundColor = UIColor(red: 170/255, green: 0/255, blue: 255/255, alpha: 1.0)
            cell.icon.image = UIImage(named: "contacticon.png")
        }else if (row == 6){
            cell.indicator.backgroundColor = UIColor.gray
            cell.icon.image = UIImage(named: "closeicon.png")
        }
        
        cell.backgroundColor = UIColor.clear
        cell.label.text = buttons[row]
        cell.label.textColor = UIColor.white
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = indexPath.row
        tableView.deselectRow(at: indexPath, animated: true)
        if (row == 0){
            eventsTapped()
        }else if (row == 1){
            cellGroupTapped()
        }else if (row == 2){
            videosTapped()
        }else if (row == 3){
            podcastTapped()
        }else if (row == 4){
            galleryTapped()
        }else if (row == 5){
            contactTapped()
        }else if (row == 6){
            closeMenu()
        }
    }
    
    func eventsTapped() {
        if (AppDelegate.Database.layer == "events"){
            presentingViewController!.dismiss(animated: true, completion: nil)
        }else{
            AppDelegate.Database.layer = "events"
            let menuViewController = storyboard!.instantiateViewController(withIdentifier: "EventsViewController")
            present(menuViewController, animated: true, completion: nil)
        }
    }
    
    func cellGroupTapped() {
        if (AppDelegate.Database.layer == "cellgroup"){
            presentingViewController!.dismiss(animated: true, completion: nil)
        }else{
            AppDelegate.Database.layer = "cellgroup"
            let menuViewController = storyboard!.instantiateViewController(withIdentifier: "DemoViewController")
            present(menuViewController, animated: true, completion: nil)
        }
    }
    
    func videosTapped() {
        if (AppDelegate.Database.layer == "videos"){
            presentingViewController!.dismiss(animated: true, completion: nil)
        }else{
            AppDelegate.Database.layer = "videos"
            let menuViewController = storyboard!.instantiateViewController(withIdentifier: "VideosViewController")
            present(menuViewController, animated: true, completion: nil)
        }
    }
    
    func podcastTapped() {
        if (AppDelegate.Database.layer == "podcast"){
            presentingViewController!.dismiss(animated: true, completion: nil)
        }else{
            AppDelegate.Database.layer = "podcast"
            let menuViewController = storyboard!.instantiateViewController(withIdentifier: "PodcastViewController")
            present(menuViewController, animated: true, completion: nil)
        }
    }
    
    func galleryTapped() {
        if (AppDelegate.Database.layer == "gallery"){
            presentingViewController!.dismiss(animated: true, completion: nil)
        }else{
            AppDelegate.Database.layer = "gallery"
            let menuViewController = storyboard!.instantiateViewController(withIdentifier: "GalleryViewController")
            present(menuViewController, animated: true, completion: nil)
        }
    }
    
    func contactTapped() {
        if (AppDelegate.Database.layer == "contact"){
            presentingViewController!.dismiss(animated: true, completion: nil)
        }else{
            AppDelegate.Database.layer = "contact"
            let menuViewController = storyboard!.instantiateViewController(withIdentifier: "ContactViewController")
            present(menuViewController, animated: true, completion: nil)
        }
    }
    
    func closeMenu() {
        AppDelegate.Database.layer = "home"
        presentingViewController!.dismiss(animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.default
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    func dismissButtonTapped(_ sender: UIButton) {
        AppDelegate.Database.layer = "home"
        presentingViewController!.dismiss(animated: true, completion: nil)
    }
    
}

extension MenuViewController: GuillotineAnimationDelegate {
    
    func animatorDidFinishPresentation(_ animator: GuillotineTransitionAnimation) {
        
    }
    
    func animatorDidFinishDismissal(_ animator: GuillotineTransitionAnimation) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func animatorWillStartPresentation(_ animator: GuillotineTransitionAnimation) {
        
    }
    
    func animatorWillStartDismissal(_ animator: GuillotineTransitionAnimation) {
        
    }
}
