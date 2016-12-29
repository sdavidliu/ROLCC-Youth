
import UIKit

class PageCollectionView: UICollectionView {
    
}

extension PageCollectionView {
    
    class func createOnView(_ view: UIView,
                            layout: UICollectionViewLayout,
                            height: CGFloat,
                            dataSource: UICollectionViewDataSource,
                            delegate: UICollectionViewDelegate) -> PageCollectionView {
        
        let collectionView = Init(PageCollectionView(frame: CGRect.zero, collectionViewLayout: layout)) {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.decelerationRate                          = UIScrollViewDecelerationRateFast
            $0.showsHorizontalScrollIndicator            = false
            $0.dataSource                                = dataSource
            $0.delegate                                  = delegate
            $0.backgroundColor                           = UIColor(white: 0, alpha: 0)
        }
        view.addSubview(collectionView)
        
        collectionView >>>- {
            $0.attribute = .height
            $0.constant  = height
            return
        }
        [NSLayoutAttribute.left, .right, .centerY].forEach { attribute in
            (view, collectionView) >>>- {
                $0.attribute = attribute
                return
            }
        }
        
        return collectionView
    }
    
}
