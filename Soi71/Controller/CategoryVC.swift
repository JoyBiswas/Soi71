//
//  CategoryVC.swift
//  Soi71
//
//  Created by RIO on 7/23/18.
//  Copyright © 2018 RIO. All rights reserved.
//

import UIKit

class CategoryVC: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var categoryTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.categoryTable.reloadData()

    }
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 15
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = categoryTable.dequeueReusableCell(withIdentifier: "CCell") as? CategoryTableCell {
            cell.categoryName.text = "Appetizers (100)"
            return cell
            
        }else {
            return CategoryTableCell()
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 50.0
    }
    

    @IBAction func backButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

}
