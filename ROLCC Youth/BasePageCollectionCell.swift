
import UIKit

open class BasePageCollectionCell: UICollectionViewCell {
    
    @IBInspectable open var yOffset: CGFloat = 40
    
    
    struct Constants {
        static let backContainer = "backContainerViewKey"
        static let shadowView      = "shadowViewKey"
        static let frontContainer  = "frontContainerKey"
        
        static let backContainerY  = "backContainerYKey"
        static let frontContainerY = "frontContainerYKey"
    }
    
    
    @IBOutlet open weak var frontContainerView: UIView!
    @IBOutlet open weak var backContainerView: UIView!
    
    @IBOutlet open weak var backConstraintY: NSLayoutConstraint!
    @IBOutlet open weak var frontConstraintY: NSLayoutConstraint!
    
    var shadowView: UIView?
    
    open var isOpened = false
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        configureOutletFromDecoder(aDecoder)
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
}


extension BasePageCollectionCell {
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        
        commonInit()
    }
    
    fileprivate func commonInit() {
        configurationViews()
        shadowView = createShadowViewOnView(frontContainerView)
    }
}


extension BasePageCollectionCell {
    
    public func cellIsOpen(_ isOpen: Bool, animated: Bool = true) {
        if isOpen == isOpened { return }
        
        frontConstraintY.constant = isOpen == true ? -frontContainerView.bounds.size.height / 5 : 0
        backConstraintY.constant  = isOpen == true ? frontContainerView.bounds.size.height / 5 - yOffset / 2 : 0
        
        if let widthConstant = backContainerView.getConstraint(.width) {
            widthConstant.constant = isOpen == true ? frontContainerView.bounds.size.width + yOffset : frontContainerView.bounds.size.width
        }
        
        if let heightConstant = backContainerView.getConstraint(.height) {
            heightConstant.constant = isOpen == true ? frontContainerView.bounds.size.height + yOffset : frontContainerView.bounds.size.height
        }
        
        isOpened = isOpen
        configurationCell()
        
        if animated == true {
            UIView.animate(withDuration: 0.3, delay: 0, options: UIViewAnimationOptions(), animations: {
                self.contentView.layoutIfNeeded()
            }, completion: nil)
        } else {
            self.contentView.layoutIfNeeded()
        }
        
    }
}


extension BasePageCollectionCell {
    
    fileprivate func configurationViews() {
        backContainerView.layer.masksToBounds = true
        backContainerView.layer.cornerRadius  = 5
        
        frontContainerView.layer.masksToBounds = true
        frontContainerView.layer.cornerRadius  = 5
        
        contentView.layer.masksToBounds = false
        layer.masksToBounds             = false
    }
    
    fileprivate func createShadowViewOnView(_ view: UIView?) -> UIView? {
        guard let view = view else {return nil}
        
        let shadow = Init(UIView(frame: .zero)) {
            $0.backgroundColor                           = UIColor(white: 0, alpha: 0)
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.layer.masksToBounds                       = false;
            $0.layer.shadowColor                         = UIColor.black.cgColor
            $0.layer.shadowRadius                        = 10
            $0.layer.shadowOpacity                       = 0.3
            $0.layer.shadowOffset                        = CGSize(width: 0, height:0)
        }
        contentView.insertSubview(shadow, belowSubview: view)
        
        for info: (attribute: NSLayoutAttribute, scale: CGFloat)  in [(NSLayoutAttribute.width, 0.8), (NSLayoutAttribute.height, 0.9)] {
            if let frontViewConstraint = view.getConstraint(info.attribute) {
                shadow >>>- {
                    $0.attribute = info.attribute
                    $0.constant  = frontViewConstraint.constant * info.scale
                    return
                }
            }
        }
        
        for info: (attribute: NSLayoutAttribute, offset: CGFloat)  in [(NSLayoutAttribute.centerX, 0), (NSLayoutAttribute.centerY, 30)] {
            (contentView, shadow, view) >>>- {
                $0.attribute = info.attribute
                $0.constant  = info.offset
                return
            }
        }
        
        let width  = shadow.getConstraint(.width)?.constant
        let height = shadow.getConstraint(.height)?.constant
        
        shadow.layer.shadowPath = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: width!, height: height!), cornerRadius: 0).cgPath
        
        return shadow
    }
    
    
    func configurationCell() {
        let i: CGFloat = self.isOpened ? 1 : -1
        let superHeight = superview?.frame.size.height ?? 0
        
        frame.size.height += i * superHeight
        frame.origin.y -= i * superHeight / 2
        frame.origin.x -= i * yOffset / 2
        frame.size.width += i * yOffset
    }
    
    
    func configureCellViewConstraintsWithSize(_ size: CGSize) {
        guard isOpened == false && frontContainerView.getConstraint(.width)?.constant != size.width else { return }
        
        [frontContainerView, backContainerView].forEach {
            let constraintWidth = $0?.getConstraint(.width)
            constraintWidth?.constant = size.width
            
            let constraintHeight = $0?.getConstraint(.height)
            constraintHeight?.constant = size.height
        }
    }
}


extension BasePageCollectionCell {
    
    fileprivate func highlightedImageFalseOnView(_ view: UIView) {
        for item in view.subviews {
            if case let imageView as UIImageView = item {
                imageView.isHighlighted = false
            }
            if item.subviews.count > 0 {
                highlightedImageFalseOnView(item)
            }
        }
    }
    
    fileprivate func copyShadowFromView(_ fromView: UIView, toView: UIView) {
        fromView.layer.shadowPath    = toView.layer.shadowPath
        fromView.layer.masksToBounds = toView.layer.masksToBounds
        fromView.layer.shadowColor   = toView.layer.shadowColor
        fromView.layer.shadowRadius  = toView.layer.shadowRadius
        fromView.layer.shadowOpacity = toView.layer.shadowOpacity
        fromView.layer.shadowOffset  = toView.layer.shadowOffset
    }
    
    
    func copyCell() -> BasePageCollectionCell? {
        highlightedImageFalseOnView(contentView)
        
        let data = NSKeyedArchiver.archivedData(withRootObject: self)
        guard case let copyView as BasePageCollectionCell = NSKeyedUnarchiver.unarchiveObject(with: data),
            let shadowView = self.shadowView else {
                return nil
        }
        
        copyView.backContainerView.layer.masksToBounds  = backContainerView.layer.masksToBounds
        copyView.backContainerView.layer.cornerRadius   = backContainerView.layer.cornerRadius
        
        copyView.frontContainerView.layer.masksToBounds = frontContainerView.layer.masksToBounds
        copyView.frontContainerView.layer.cornerRadius  = frontContainerView.layer.cornerRadius
        
        copyShadowFromView(copyView.shadowView!, toView: shadowView)
        
        for index in 0..<copyView.frontContainerView.subviews.count {
            copyShadowFromView(copyView.frontContainerView.subviews[index], toView: frontContainerView.subviews[index])
        }
        return copyView
    }
    
    open override func encode(with coder: NSCoder) {
        super.encode(with: coder)
        coder.encode(backContainerView, forKey: Constants.backContainer)
        coder.encode(frontContainerView, forKey: Constants.frontContainer)
        coder.encode(frontConstraintY, forKey: Constants.frontContainerY)
        coder.encode(backConstraintY, forKey: Constants.backContainerY)
        coder.encode(shadowView, forKey: Constants.shadowView)
    }
    
    fileprivate func configureOutletFromDecoder(_ coder: NSCoder) {
        if case let shadowView as UIView = coder.decodeObject(forKey: Constants.shadowView) {
            self.shadowView = shadowView
        }
        
        if case let backView as UIView = coder.decodeObject(forKey: Constants.backContainer) {
            backContainerView = backView
        }
        
        if case let frontView as UIView = coder.decodeObject(forKey: Constants.frontContainer) {
            frontContainerView = frontView
        }
        
        if case let constraint as NSLayoutConstraint = coder.decodeObject(forKey: Constants.frontContainerY) {
            frontConstraintY = constraint
        }
        
        if case let constraint as NSLayoutConstraint = coder.decodeObject(forKey: Constants.backContainerY) {
            backConstraintY = constraint
        }
    }
}
