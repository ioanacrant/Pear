//
//  NewsCell.swift
//  bitcamp2015 try #2
//
//  Created by Suraj Rampure on 2015-04-11.
//  Copyright (c) 2015 Suraj Rampure. All rights reserved.
//

import UIKit

class NewsCell: UITableViewCell {

    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var title: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
