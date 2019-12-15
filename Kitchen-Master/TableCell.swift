//
//  TableCell.swift
//  Kitchen-Master
//
//  Created by Zhihao Wang on 12/14/19.
//  Copyright © 2019 Zhihao Wang. All rights reserved.
//

import UIKit

class TableCell: UITableViewCell {

    @IBOutlet weak var titleLbl: UILabel!
    
    @IBOutlet weak var ingredLbl: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
