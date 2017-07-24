//
//  NestedItemTableViewCell.swift
//  Checklist
//
//  Created by Emily Chang on 7/23/17.
//  Copyright © 2017 Emily Chang. All rights reserved.
//

import UIKit

class NestedItemTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nestedItemLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
