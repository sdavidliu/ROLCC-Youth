//
//  DemoCollectionViewCell.swift
//  TestCollectionView
//
//  Created by Alex K. on 12/05/16.
//  Copyright © 2016 Alex K. All rights reserved.
//

import UIKit

class DemoCollectionViewCell: BasePageCollectionCell {
  
  @IBOutlet weak var backgroundImageView: UIImageView!
  @IBOutlet weak var customTitle: UILabel!
    @IBOutlet weak var groupDescription: UILabel!
    @IBOutlet weak var leaders: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var leftLabel: UILabel!
    @IBOutlet weak var rightLabel: UILabel!
  
    override func awakeFromNib() {
        super.awakeFromNib()
      
      customTitle.layer.shadowRadius = 2
      customTitle.layer.shadowOffset = CGSize(width: 0, height: 3)
      customTitle.layer.shadowOpacity = 0.2
    }
}
