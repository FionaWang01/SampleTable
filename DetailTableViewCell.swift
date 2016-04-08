//
//  DetailTableViewCell.swift
//  SampleTable
//
//  Created by babykang on 16/4/8.
//  Copyright © 2016年 babykang. All rights reserved.
//

import UIKit

class DetailTableViewCell: UITableViewCell {
    
    @IBOutlet weak var mapButton: UIButton!
    @IBOutlet weak var FieldLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
   
}
