//
//  StationDataCellTableViewCell.swift
//  Assignment1
//
//  Created by Sachin Gupta on 5/13/18.
//  Copyright © 2018 Sachin Gupta. All rights reserved.
//

import UIKit

class StationDataCellTableViewCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var time: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
