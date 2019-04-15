//
//  TableViewCell.swift
//  Speed Investor
//
//  Created by Edgar Palic on 3/24/19.
//  Copyright © 2019 Edgar Palic. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblCellUsername: UILabel!
    @IBOutlet weak var lblCellScore: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
