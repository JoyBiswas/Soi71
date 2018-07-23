//
//  MenuTableCell.swift
//  Soi71
//
//  Created by RIO on 7/23/18.
//  Copyright © 2018 RIO. All rights reserved.
//

import UIKit

class MenuTableCell: UITableViewCell {
    
    @IBOutlet weak var menuImage: UIImageView!
    
    @IBOutlet weak var menuName: UITextView!
    
    @IBOutlet weak var menuPrice: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func viewDetileBTnTapped(_ sender: Any) {
    }
    
    @IBAction func addToChartBtnTapped(_ sender: Any) {
    }
}
