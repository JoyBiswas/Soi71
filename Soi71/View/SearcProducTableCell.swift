//
//  SearcProducTableCell.swift
//  Soi71
//
//  Created by RIO on 7/22/18.
//  Copyright © 2018 RIO. All rights reserved.
//

import UIKit

class SearcProducTableCell: UITableViewCell {
    
    @IBOutlet weak var productName:UILabel!
    @IBOutlet weak var productPrice:UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        layer.cornerRadius =  5
        layer.masksToBounds = false
       layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.23
        layer.shadowRadius = 4
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }


}
