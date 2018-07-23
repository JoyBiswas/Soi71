//
//  MenuVC.swift
//  Soi71
//
//  Created by RIO on 7/23/18.
//  Copyright © 2018 RIO. All rights reserved.
//

import UIKit

class MenuVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var searchTextField: UITextField!
    
    @IBOutlet weak var searchTextFieldImage: UIImageView!
    var inSearchmood = false
    
    @IBOutlet weak var menuSearchBtn: UIButton!
    
    @IBOutlet weak var menuListTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.searchTextField.isHidden = true
        self.searchTextFieldImage.isHidden = true
        self.menuListTable.reloadData()
      
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 15
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = menuListTable.dequeueReusableCell(withIdentifier: "MCell") as? MenuTableCell {
            cell.menuImage.image = #imageLiteral(resourceName: "bg.jpg")
            cell.menuName.text = "S-01.Crispy Duck"
            cell.menuPrice.text = "$950.0"
            return cell
            
        }else {
            return MenuTableCell()
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 148.0
    }
//    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//        let shadowView = UIView()
//
//
//
//
//        let gradient = CAGradientLayer()
//        gradient.frame.size = CGSize(width: view.bounds.width, height: 45)
//        let stopColor = UIColor.darkGray.cgColor
//
//        let startColor = UIColor.darkGray.cgColor
//
//
//        gradient.colors = [stopColor.copy(alpha: 0.50)!,startColor.copy(alpha: 0.50)!]
//
//
//        gradient.locations = [0.8,0.8]
//
//        shadowView.layer.addSublayer(gradient)
//
//
//        return shadowView
//    }

    @IBAction func manuSearchBtnTapped(_ sender: Any) {
        
        if inSearchmood {
            self.searchTextField.isHidden = true
            self.searchTextFieldImage.isHidden = true
           self.menuSearchBtn.setImage(UIImage(named: "searchIUconWhite.png"), for: .normal)
        }else {
            self.searchTextField.isHidden = false
            self.searchTextFieldImage.isHidden = false
            self.menuSearchBtn.setImage(UIImage(named: "searchIcon.png"), for: .normal)
            
        }
        inSearchmood = !inSearchmood
        
    }
    

}
