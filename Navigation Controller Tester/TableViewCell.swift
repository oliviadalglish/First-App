//
//  TableViewCell.swift
//  Navigation Controller Tester
//
//  Created by Olivia Dalglish on 1/13/17.
//  Copyright © 2017 Olivia Dalglish. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    //@IBOutlet weak var saveButton: UIButton!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
