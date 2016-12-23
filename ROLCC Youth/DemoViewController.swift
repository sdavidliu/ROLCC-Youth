//
//  DemoViewController.swift
//  TestCollectionView
//
//  Created by Alex K. on 12/05/16.
//  Copyright © 2016 Alex K. All rights reserved.
//

import UIKit

class DemoViewController: ExpandingViewController {
  
  typealias ItemInfo = (imageName: String, title: String)
  fileprivate var cellsIsOpen = [Bool]()
  fileprivate let items: [ItemInfo] = [("berryessa", "Berryessa"),("cupertino1", "Cupertino 1"),("cupertino2", "Cupertino 2"),("cupertinoJH", "Cupertino JH"),("evergreen", "Evergreen"),("fremontA", "Fremont A"),("fremontB", "Fremont B"),("fremontJH", "Fremont JH"),("morganHill", "Morgan Hill"),("paloAlto", "Palo Alto"),("paloAltoJH", "Palo Alto JH"),("sanCarlos", "San Carlos"),("saratoga1", "Saratoga 1"),("saratoga2", "Saratoga 2"),("saratogaJH", "Saratoga JH"),("sunnyvaleJH", "Sunnyvale JH")]
    fileprivate lazy var presentationAnimator = GuillotineTransitionAnimation()
  
  @IBOutlet weak var pageLabel: UILabel!
}

// MARK: life cicle

extension DemoViewController {
  
  override func viewDidLoad() {
    itemSize = CGSize(width: 256, height: 335)
    super.viewDidLoad()
    
    let navBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 64))
    let navigationItem = UINavigationItem()
    navigationItem.title = "Cell Group"
    navBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "Avenir-Light", size: 15.0)!]
    navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named:"menubutton.png"), style: .plain, target: nil, action: #selector(showMenu))
    navigationItem.leftBarButtonItem?.tintColor = UIColor.gray
    navBar.items = [navigationItem]
    self.view.addSubview(navBar)
    
    registerCell()
    fillCellIsOpeenArry()
    addGestureToView(collectionView!)
    configureNavBar()
  }
    
    func showMenu(){
        let menuViewController = storyboard!.instantiateViewController(withIdentifier: "MenuViewController")
        menuViewController.modalPresentationStyle = .custom
        menuViewController.transitioningDelegate = self
        
        presentationAnimator.animationDelegate = menuViewController as? GuillotineAnimationDelegate
        present(menuViewController, animated: true, completion: nil)
    }
}

// MARK: Helpers 

extension DemoViewController {
  
  fileprivate func registerCell() {
    
    let nib = UINib(nibName: String(describing: DemoCollectionViewCell.self), bundle: nil)
    collectionView?.register(nib, forCellWithReuseIdentifier: String(describing: DemoCollectionViewCell.self))
  }
  
  fileprivate func fillCellIsOpeenArry() {
    for _ in items {
      cellsIsOpen.append(false)
    }
  }
  
  fileprivate func getViewController() -> ExpandingTableViewController {
    let storyboard = UIStoryboard(storyboard: .Main)
    let toViewController: DemoTableViewController = storyboard.instantiateViewController()
    return toViewController
  }
  
  fileprivate func configureNavBar() {
    navigationItem.leftBarButtonItem?.image = navigationItem.leftBarButtonItem?.image!.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
  }
}

/// MARK: Gesture

extension DemoViewController {
  
  fileprivate func addGestureToView(_ toView: UIView) {
    let gesutereUp = Init(UISwipeGestureRecognizer(target: self, action: #selector(DemoViewController.swipeHandler(_:)))) {
      $0.direction = .up
    }
    
    let gesutereDown = Init(UISwipeGestureRecognizer(target: self, action: #selector(DemoViewController.swipeHandler(_:)))) {
      $0.direction = .down
    }
    toView.addGestureRecognizer(gesutereUp)
    toView.addGestureRecognizer(gesutereDown)
  }

  func swipeHandler(_ sender: UISwipeGestureRecognizer) {
    let indexPath = IndexPath(row: currentIndex, section: 0)
    guard let cell  = collectionView?.cellForItem(at: indexPath) as? DemoCollectionViewCell else { return }
    // double swipe Up transition
    if cell.isOpened == true && sender.direction == .up {
      pushToViewController(getViewController())
      
      if let rightButton = navigationItem.rightBarButtonItem as? AnimatingBarButton {
        rightButton.animationSelected(true)
      }
    }
    
    let open = sender.direction == .up ? true : false
    cell.cellIsOpen(open)
    cellsIsOpen[(indexPath as NSIndexPath).row] = cell.isOpened
  }
}

// MARK: UIScrollViewDelegate 

extension DemoViewController {
  
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    pageLabel.text = "\(currentIndex+1)/\(items.count)"
  }
}

// MARK: UICollectionViewDataSource

extension DemoViewController {
  
  override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    super.collectionView(collectionView, willDisplay: cell, forItemAt: indexPath)
    guard let cell = cell as? DemoCollectionViewCell else { return }

    let index = (indexPath as NSIndexPath).row % items.count
    let info = items[index]
    cell.backgroundImageView?.image = UIImage(named: info.imageName)
    cell.customTitle.text = info.title
    let cgInfo = AppDelegate.Database.cellGroups
    cell.leftLabel.text = cgInfo[info.title]?["Day"]
    cell.rightLabel.text = cgInfo[info.title]?["Time"]
    cell.groupDescription.text = cgInfo[info.title]?["Description"]
    cell.leaders.text = cgInfo[info.title]?["Head"]
    cell.email.text = cgInfo[info.title]?["Email"]
    cell.cellIsOpen(cellsIsOpen[index], animated: false)
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: IndexPath) {
    guard let cell = collectionView.cellForItem(at: indexPath) as? DemoCollectionViewCell
          , currentIndex == (indexPath as NSIndexPath).row else { return }
    
    if cell.isOpened == false {
      cell.cellIsOpen(true)
    } else {
        
       cell.cellIsOpen(false)
      //pushToViewController(getViewController())
        
        //let storyboard = UIStoryboard(storyboard: .Main)
        //let toViewController: BerryessaView = storyboard.instantiateViewController()
        //pushToViewController(toViewController)
      
      if let rightButton = navigationItem.rightBarButtonItem as? AnimatingBarButton {
        rightButton.animationSelected(true)
      }
    }
  }
}

// MARK: UICollectionViewDataSource
extension DemoViewController {
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return items.count
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    return collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: DemoCollectionViewCell.self), for: indexPath)
  }
}

extension DemoViewController: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        presentationAnimator.mode = .presentation
        return presentationAnimator
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        presentationAnimator.mode = .dismissal
        return presentationAnimator
    }
}
