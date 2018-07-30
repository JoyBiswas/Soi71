//
//  ChartVC.swift
//  Soi71
//
//  Created by JOY BISWAS on 7/25/18.
//  Copyright © 2018 RIO. All rights reserved.
//

import UIKit

class ChartVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var cartTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.cartTable.reloadData()
    }

   
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = cartTable.dequeueReusableCell(withIdentifier: "CCELL") as? CartTableCell {
            cell.productImage.image = #imageLiteral(resourceName: "bg.jpg")
            cell.productName.text = "S1.01-kjdkskjdksjdkjjcsc"
            cell.productPrice.text = "$1250"
            cell.productQnt.text = "3"
            cell.productTotalPrice.text = "$7550"
            return cell
            
        }else {
            return CartTableCell()
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 45.0
    }

 
    @IBAction func backButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
