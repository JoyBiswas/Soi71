//
//  CartTableCell.swift
//  Soi71
//
//  Created by JOY BISWAS on 7/25/18.
//  Copyright © 2018 RIO. All rights reserved.
//

import UIKit

class CartTableCell: UITableViewCell {
    
    @IBOutlet weak var productImage: UIImageView!
    
    @IBOutlet weak var productName: UITextView!
    
    @IBOutlet weak var productPrice: UILabel!
    
    
    @IBOutlet weak var productQnt: UILabel!
    
    @IBOutlet weak var productTotalPrice: UILabel!
    @IBOutlet weak var qntView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        qntView.layer.masksToBounds = true
        
    }



}
