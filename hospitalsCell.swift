//
//  hospitalsCell.swift
//  Medicana
//
//  Created by Mohamed Hammam on 6/26/19.
//  Copyright © 2019 Mohamed Hammam. All rights reserved.
//

import UIKit

class hospitalsCell: UITableViewCell {

    @IBOutlet weak var hospitalNameLa: UILabel!
    @IBOutlet weak var hospitalCityLa: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
