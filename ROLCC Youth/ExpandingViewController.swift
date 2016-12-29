

import UIKit

open class ExpandingViewController: UIViewController {
    
    open var itemSize = CGSize(width: 256, height: 335)
    
    open var collectionView: UICollectionView?
    
    fileprivate var transitionDriver: TransitionDriver?
    
    open var currentIndex: Int {
        guard let collectionView = self.collectionView else { return 0 }
        
        let startOffset = (collectionView.bounds.size.width - itemSize.width) / 2
        guard let collectionLayout  = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else {
            return 0
        }
        
        let minimumLineSpacing = collectionLayout.minimumLineSpacing
        let a = collectionView.contentOffset.x + startOffset + itemSize.width / 2
        let b = itemSize.width + minimumLineSpacing
        return Int(a / b)
    }
}


extension ExpandingViewController {
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
    }
}


public extension ExpandingViewController {
    
    func pushToViewController(_ viewController: ExpandingTableViewController) {
        guard let collectionView = self.collectionView,
            let navigationController = self.navigationController else {
                return
        }
        
        viewController.transitionDriver = transitionDriver
        let insets = viewController.automaticallyAdjustsScrollViewInsets
        let tabBarHeight =  insets == true ? navigationController.navigationBar.frame.size.height : 0
        let stausBarHeight = insets == true ? UIApplication.shared.statusBarFrame.size.height : 0
        let backImage = getBackImage(viewController, headerHeight: viewController.headerHeight)
        
        transitionDriver?.pushTransitionAnimationIndex(currentIndex,
                                                       collecitionView: collectionView,
                                                       backImage: backImage,
                                                       headerHeight: viewController.headerHeight,
                                                       insets: tabBarHeight + stausBarHeight) { headerView in
                                                        viewController.tableView.tableHeaderView = headerView
                                                        self.navigationController?.pushViewController(viewController, animated: false)
        }
    }
}


extension ExpandingViewController {
    
    fileprivate func commonInit() {
        
        let layout = PageCollectionLayout(itemSize: itemSize)
        collectionView = PageCollectionView.createOnView(view,
                                                         layout: layout,
                                                         height: itemSize.height + itemSize.height / 5 * 2,
                                                         dataSource: self,
                                                         delegate: self)
        if #available(iOS 10.0, *) {
            collectionView?.isPrefetchingEnabled = false
        }
        transitionDriver = TransitionDriver(view: view)
    }
}


extension ExpandingViewController {
    
    fileprivate func getBackImage(_ viewController: UIViewController, headerHeight: CGFloat) -> UIImage? {
        let imageSize = CGSize(width: viewController.view.bounds.width, height: viewController.view.bounds.height - headerHeight)
        let imageFrame = CGRect(origin: CGPoint(x: 0, y: 0), size: imageSize)
        return viewController.view.takeSnapshot(imageFrame)
    }
    
}


extension ExpandingViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    open func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard case let cell as BasePageCollectionCell = cell else {
            return
        }
        
        cell.configureCellViewConstraintsWithSize(itemSize)
    }
    open func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        fatalError("need emplementation in subclass")
    }
    
    open func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        fatalError("need emplementation in subclass")
    }
}


extension ExpandingViewController {
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let indexPath = IndexPath(row: currentIndex, section: 0)
        if case let currentCell as BasePageCollectionCell = collectionView?.cellForItem(at: indexPath) {
            currentCell.configurationCell()
        }
    }
}

