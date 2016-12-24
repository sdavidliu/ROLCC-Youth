//
//  MenuCell.swift
//  ROLCC Youth
//
//  Created by David Liu on 12/24/16.
//  Copyright © 2016 David Liu. All rights reserved.
//

import UIKit

class MenuCell: UITableViewCell {

    @IBOutlet weak var indicator: UIImageView!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
