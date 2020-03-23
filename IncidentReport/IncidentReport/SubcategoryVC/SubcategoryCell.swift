//
//  SubcategoryCell.swift
//  IncidentReport
//
//  Created by Arpita Jain on 20/03/20.
//  Copyright © 2020 Arpita Jain. All rights reserved.
//

import UIKit

class SubcategoryCell: UITableViewCell {

    @IBOutlet weak var imageSubCategory: UIImageView!
    @IBOutlet weak var labelSubCategory: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
