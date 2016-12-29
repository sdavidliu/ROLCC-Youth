
import UIKit

open class ExpandingTableViewController: UITableViewController {
    
    open var headerHeight: CGFloat = 236
    
    var transitionDriver: TransitionDriver?
}


extension ExpandingTableViewController {
    
    fileprivate func getScreen() -> UIImage? {
        let height = (headerHeight - tableView.contentOffset.y) < 0 ? 0 : (headerHeight - tableView.contentOffset.y)
        let backImageSize = CGSize(width: view.bounds.width, height: view.bounds.height - height + getTabBarHeight())
        let backImageOrigin = CGPoint(x: 0, y: height + tableView.contentOffset.y)
        return view.takeSnapshot(CGRect(origin: backImageOrigin, size: backImageSize))
    }
    
    fileprivate func getTabBarHeight() -> CGFloat {
        guard let navigationController = self.navigationController else {
            return 0
        }
        
        let insets = automaticallyAdjustsScrollViewInsets
        let tabBarHeight =  insets == true ? navigationController.navigationBar.frame.size.height : 0
        let stausBarHeight = insets == true ? UIApplication.shared.statusBarFrame.size.height : 0
        return tabBarHeight + stausBarHeight
    }
    
}


extension ExpandingTableViewController {
    
    public func popTransitionAnimation() {
        guard let transitionDriver = self.transitionDriver else {
            return
        }
        
        let backImage = getScreen()
        var offset = tableView.contentOffset.y > headerHeight ? headerHeight : tableView.contentOffset.y
        
        offset += getTabBarHeight()
        
        transitionDriver.popTransitionAnimationContantOffset(offset, backImage: backImage)
        let _ = self.navigationController?.popViewController(animated: false)
    }
}
