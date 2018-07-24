//
//  SearchFoodVC.swift
//  Soi71
//
//  Created by RIO on 7/22/18.
//  Copyright © 2018 RIO. All rights reserved.
//

import UIKit

class SearchFoodVC: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
   
    @IBOutlet weak var searchProductTable:UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

      
       
   
        self.searchProductTable.reloadData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 15
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = searchProductTable.dequeueReusableCell(withIdentifier: "SCell") as? SearcProducTableCell {
            cell.productName.text = "S-01.Crispy Duck"
            cell.productPrice.text = "$955"
            
          
            
            return cell
            
        }else {
            return SearcProducTableCell()
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 65.0
    }
    

}
