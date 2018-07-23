//
//  SoiHomeVC.swift
//  Soi71
//
//  Created by RIO on 7/21/18.
//  Copyright © 2018 RIO. All rights reserved.
//

import UIKit

class SoiHomeVC: UIViewController {
    
    @IBOutlet weak var menuButton: UIButton!
    
    @IBOutlet weak var menuWidth: NSLayoutConstraint!
    
    @IBOutlet weak var menuView: UIView!
    var menuShow = false
    
    @IBOutlet weak var aboutusBTN: UIButton!
    
    @IBOutlet weak var accountBTn: UIButton!
    
    
    @IBOutlet weak var menuViewBTN: UIButton!
    
    @IBOutlet weak var saleMenuBtn: UIButton!
    @IBOutlet weak var menuCategoriesBTN: UIButton!
    
    @IBOutlet weak var reservationBTN: UIButton!
    
    @IBOutlet weak var ordersBTn: UIButton!
    
    @IBOutlet weak var contactBTn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menuWidth.constant = 0

        // Do any additional setup after loading the view.
        self.saleMenuBtn.isHidden = true
        self.menuCategoriesBTN.isHidden = true
        self.reservationBTN.isHidden = true
    }

    

    @IBAction func menuButtonTapped(_ sender: Any) {
        self.manuBtn()
        
        
    }
     func manuBtn() {
        let btnBgColor = UIColor(rgb: 0x222222)
        if(menuShow)
        {
            menuWidth.constant = 0
            menuButton.backgroundColor = btnBgColor
            self.saleMenuBtn.isHidden = true
            self.menuCategoriesBTN.isHidden = true
            self.reservationBTN.isHidden = true
            handelanimation()
            
        }
        else{
            menuWidth.constant = 160
            menuButton.backgroundColor = nil
            self.saleMenuBtn.isHidden = false
            self.menuCategoriesBTN.isHidden = false
            self.reservationBTN.isHidden = false
            handelanimationForMenuShow()
            
            
        }
        menuShow = !menuShow
    }
    
    func handelanimationForMenuShow()
    {
        UIView.animate(withDuration: 0.9, animations: {
            self.view.layoutIfNeeded()
        })
        
        
        
    }
    func handelanimation()
    {
        UIView.animate(withDuration: 0.2, animations: {
            self.view.layoutIfNeeded()
        })
        
        
        
    }
    
}
extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}
