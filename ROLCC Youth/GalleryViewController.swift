
import UIKit
import SwiftPhotoGallery

class GalleryViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    let reuseIdentifier = "collectionCell"
    fileprivate lazy var presentationAnimator = GuillotineTransitionAnimation()
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    var gallery = [String]()
    var images = [UIImage]()
    
    override func viewDidLoad() {
        let navBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 64))
        let navigationItem = UINavigationItem()
        navigationItem.title = "Gallery"
        navBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "Avenir-Light", size: 15.0)!]
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named:"menubutton.png"), style: .plain, target: nil, action: #selector(showMenu))
        navigationItem.leftBarButtonItem?.tintColor = UIColor.gray
        navBar.items = [navigationItem]
        self.view.addSubview(navBar)
        
        let reachability = Reachability()
        
        if (reachability?.isReachable == true){
            gallery = AppDelegate.Database.galleryName.components(separatedBy: ",")
        }else{
            //tableView.isHidden = true
            
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
    
    override func viewDidAppear(_ animated: Bool) {
        images = []
    }
    
    func showMenu(){
        let menuViewController = storyboard!.instantiateViewController(withIdentifier: "MenuViewController")
        menuViewController.modalPresentationStyle = .custom
        menuViewController.transitioningDelegate = self
        
        presentationAnimator.animationDelegate = menuViewController as? GuillotineAnimationDelegate
        present(menuViewController, animated: true, completion: nil)
    }
    
    
    // MARK: - UICollectionViewDataSource protocol
    
    // tell the collection view how many cells to make
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.gallery.count
    }
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! MyCollectionViewCell
        
        let imagesUrl = (AppDelegate.Database.galleryDict[gallery[indexPath.item]]!).components(separatedBy: ",")
        URLSession.shared.dataTask(with: URL(string: imagesUrl[0])!, completionHandler: { (data, response, error) in
            if error != nil {
                return
            }
            DispatchQueue.main.async(execute: {
                let test = UIImage(data: data!)
                cell.imageView.image = test
                cell.imageView.layer.opacity = 0.5
            })
        }).resume()
        
        cell.myLabel.text = gallery[indexPath.item]
        cell.backgroundColor = UIColor.clear
        cell.layer.cornerRadius = 5
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //print("You selected cell #\(indexPath.item)!")
        
        let imagesUrl = (AppDelegate.Database.galleryDict[gallery[indexPath.item]]!).components(separatedBy: ",")
        
        for url in imagesUrl{
            URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: { (data, response, error) in
                if error != nil {
                    return
                }
                DispatchQueue.main.async(execute: {
                    let test = UIImage(data: data!)
                    self.images.append(test!)
                    if (self.images.count == imagesUrl.count){
                        let gallery = SwiftPhotoGallery(delegate: self, dataSource: self)
                        gallery.backgroundColor = UIColor.white
                        gallery.pageIndicatorTintColor = UIColor.gray.withAlphaComponent(0.5)
                        gallery.currentPageIndicatorTintColor = UIColor(red: 0.0, green: 0.66, blue: 0.875, alpha: 1.0)
                        
                        gallery.hidePageControl = false
                        self.present(gallery, animated: true, completion: nil)
                    }
                })
            }).resume()
        }
    }
}

extension GalleryViewController: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        presentationAnimator.mode = .presentation
        return presentationAnimator
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        presentationAnimator.mode = .dismissal
        return presentationAnimator
    }
}

// MARK: SwiftPhotoGalleryDataSource Methods
extension GalleryViewController: SwiftPhotoGalleryDataSource {
    
    func numberOfImagesInGallery(gallery: SwiftPhotoGallery) -> Int {
        return images.count
    }
    
    func imageInGallery(gallery: SwiftPhotoGallery, forIndex: Int) -> UIImage? {
        return images[forIndex]
    }
}

// MARK: SwiftPhotoGalleryDelegate Methods
extension GalleryViewController: SwiftPhotoGalleryDelegate {
    
    func galleryDidTapToClose(gallery: SwiftPhotoGallery) {
        dismiss(animated: true, completion: nil)
    }
}
