//
//  HeaderCell.swift
//  UITableViewCellForHeader
//
//  Created by RTC-HN158 on 5/8/17.
//  Copyright © 2017 NhatHM. All rights reserved.
//

import UIKit

class HeaderCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
