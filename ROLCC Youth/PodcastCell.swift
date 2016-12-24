//
//  PodcastCell.swift
//  ROLCC Youth
//
//  Created by David Liu on 12/23/16.
//  Copyright © 2016 David Liu. All rights reserved.
//

import UIKit

class PodcastCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var podcastImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
