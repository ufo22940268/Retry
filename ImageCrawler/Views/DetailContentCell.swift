//
//  DetailContentCell.swift
//  ImageCrawler
//
//  Created by Frank Cheng on 2018/6/21.
//  Copyright © 2018 Frank Cheng. All rights reserved.
//

import UIKit

class DetailInfoCell: UITableViewCell {
    
    @IBOutlet weak var key: UILabel!
    
    @IBOutlet weak var value: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
