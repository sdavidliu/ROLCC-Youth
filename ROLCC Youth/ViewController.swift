
/*
 To Do:
 - Click dots on bottom right to get full resolution
 - Update default values for cell group
 - Start off at one favorite cell group
 - Delete all unessasary images
 - Fix weird bug after opening up videos
 - Check with iPhone 7
 */

import UIKit

class ViewController: UIViewController {
    var progress: CGFloat = 0 {
        didSet {
            let progressRelativeToEnd = abs(progress - 0.5) * 2
            let alpha = pow(progressRelativeToEnd, 6)
            self.moreInfoButton.alpha = alpha
            self.settingsButton.alpha = alpha
            let scale = 0.7 + 0.3 * progressRelativeToEnd
            self.heartImageView.transform = CGAffineTransform(scaleX:scale, y:scale)
            self.dayLabel.transform = CGAffineTransform(scaleX:scale, y:scale)
            //            self.heartRateLabel.transform = CGAffineTransform(scaleX:scale, y:scale)
        }
    }
    fileprivate lazy var presentationAnimator = GuillotineTransitionAnimation()
    var tintColor: UIColor!
    @IBOutlet weak var moreInfoButton: UIButton!
    @IBOutlet weak var settingsButton: UIButton!
    @IBOutlet weak var heartImageView: UIImageView!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var heartRateLabel: UILabel!
    @IBOutlet weak var imageLogo: UIImageView!
    @IBOutlet weak var menuButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.moreInfoButton.tintColor = self.tintColor
        self.settingsButton.tintColor = self.tintColor
        self.dayLabel.textColor = self.tintColor
        self.heartRateLabel.textColor = self.tintColor
        self.heartImageView.tintColor = self.tintColor
        let origImage = menuButton.currentImage
        let tintedImage = origImage?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        menuButton.setImage(tintedImage, for: .normal)
        menuButton.tintColor = self.tintColor
        
        }
    
    override func viewDidAppear(_ animated: Bool) {
        AppDelegate.Database.layer = "home"
    }
    
    @IBAction func showMenuAction(_ sender: UIButton) {
        let menuViewController = storyboard!.instantiateViewController(withIdentifier: "MenuViewController")
        menuViewController.modalPresentationStyle = .custom
        menuViewController.transitioningDelegate = self
        
        presentationAnimator.animationDelegate = menuViewController as? GuillotineAnimationDelegate
        presentationAnimator.supportView = navigationController!.navigationBar
        presentationAnimator.presentButton = sender
        present(menuViewController, animated: true, completion: nil)
    }
    
    func showMenu(){
        let menuViewController = storyboard!.instantiateViewController(withIdentifier: "MenuViewController")
        menuViewController.modalPresentationStyle = .custom
        menuViewController.transitioningDelegate = self
        
        presentationAnimator.animationDelegate = menuViewController as? GuillotineAnimationDelegate
        presentationAnimator.supportView = navigationController!.navigationBar
        present(menuViewController, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func unwindToMainMenu(segue: UIStoryboardSegue) {
        
    }
    
}

extension ViewController: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        presentationAnimator.mode = .presentation
        return presentationAnimator
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        presentationAnimator.mode = .dismissal
        return presentationAnimator
    }
}
