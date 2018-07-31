//
//  MenuVC.swift
//  Soi71
//
//  Created by RIO on 7/23/18.
//  Copyright © 2018 RIO. All rights reserved.
//

import UIKit

class MenuVC: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate {
    
    @IBOutlet weak var searchTextField: UITextField!
    
    @IBOutlet weak var searchTextFieldImage: UIImageView!
    var inSearchMode = false
    var showSearch = false
    
    @IBOutlet weak var menuSearchBtn: UIButton!
    
    @IBOutlet weak var menuListTable: UITableView!
    var selectedIndexPath: NSIndexPath = NSIndexPath()

    
    var menu = [MenuModel]()
    var filteredObject:[MenuModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.searchTextField.isHidden = true
        self.searchTextFieldImage.isHidden = true
        self.menuListTable.reloadData()
        self.mostDownload()
        searchTextField.delegate = self
      
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if inSearchMode {
            
            return (filteredObject?.count)!
        }
        
        return menu.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        if let cell = menuListTable.dequeueReusableCell(withIdentifier: "MCell") as? MenuTableCell {
            
            
            
            let menu: MenuModel!
          
            if inSearchMode {
                menu = filteredObject?[indexPath.row]
                
            } else {
                
                menu = self.menu[indexPath.row]
                
            }
            
            cell.configureCell(menu: menu, img: nil)
            
            return cell
            
        }else {
            return MenuTableCell()
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 101.0
    }
    func mostDownload() {
        
        var request = URLRequest(url: URL(string:"https://arifgroupint.com/test/wc-api/v3/products?consumer_key=ck_d7980b18f40501ebcfe221280a9234e6d11489a1&consumer_secret=cs_f9b4f19bbfdec5464af4596e41787e86741ed973")!)
        
        //  let parameters = ["category": "hoodies"] as [String : String]
        request.httpMethod = "GET"
        request.addValue("application/javascript", forHTTPHeaderField: "Content-Type")
        request.addValue("application/javascript", forHTTPHeaderField: "Accept")
        
        
        let session = URLSession.shared
        
        session.dataTask(with: request) {data, response, err in
            print("Entered the completionHandler")
            
            if(err != nil){
                print("error")
            }else{
                
                var jsonResult = NSDictionary()
                do{
                    jsonResult = try JSONSerialization.jsonObject(with: data!, options:.allowFragments) as! NSDictionary;                    print("hisss\(jsonResult)")
                    
                    var jsonElement = NSDictionary()
                    
                    for (key,_) in jsonResult
                    {
                        if key as! String == "products" {
                            
                            let realValueDict =  jsonResult[key] as! NSArray
                            for i in 0 ..< realValueDict.count
                            {
                                
                                jsonElement = realValueDict[i] as! NSDictionary
                                print("JOYadrota \(jsonElement.allValues)")
                                if let name = jsonElement["title"] as? String,
                                    let regular_price = jsonElement["regular_price"] as? String,
                                    let categories = jsonElement["categories"] as? [String],
                                    let image = jsonElement["images"] as? [[String:Any]]{
                                    
                                    if let img = image.first {
                                        
                                        if let cate = categories.first {
                                            let aMenu = MenuModel(menuImage: img["src"] as! String, menuName: name, menuPrice: regular_price, menuCategory: cate)
                                            self.menu.append(aMenu)
                                            
                                        }
                                    }
                                    
                                    
                                }
                                
                                
                                
                                DispatchQueue.main.async(execute: {
                                    self.menuListTable.reloadData()
                                    
                                })

                                
                                
                            }
                        }
                        
                        
                        
                    }
                }catch let error as NSError{
                    print(error)
                }
            }
            }.resume()
    }



    @IBAction func manuSearchBtnTapped(_ sender: Any) {
        
        if showSearch {
            self.searchTextField.isHidden = true
            self.searchTextFieldImage.isHidden = true
           self.menuSearchBtn.setImage(UIImage(named: "searchIUconWhite.png"), for: .normal)
        }else {
            self.searchTextField.isHidden = false
            self.searchTextFieldImage.isHidden = false
            self.menuSearchBtn.setImage(UIImage(named: "searchIcon.png"), for: .normal)
            
        }
        showSearch = !showSearch
        
    }
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

 searchTextField.resignFirstResponder()
        
        return true
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.searchTextField.endEditing(true)
        
    }
    
    @IBAction func searchForProduct(_ sender: Any) {
        if searchTextField.text == nil || searchTextField.text == "" {
            
            inSearchMode = false
            self.menuListTable.reloadData()
            view.endEditing(true)
            
        } else {
            
            inSearchMode = true
            let lowerCase = searchTextField.text!.lowercased()
            
            
            filteredObject = menu.filter({$0.menuName.lowercased().hasPrefix(lowerCase) })
            
            self.menuListTable.reloadData()
            
            
            
        }
        
    }
    
    
    @IBAction func viewDetailsButtonTapped(_ sender: Any) {
        print("hello view")
        let buttonPosition:CGPoint = (sender as AnyObject).convert(CGPoint.zero, to: self.menuListTable)
        if let indexPath = self.menuListTable.indexPathForRow(at: buttonPosition) {
            self.selectedIndexPath = indexPath as NSIndexPath
            self.performSegue(withIdentifier: "toDetailsVc", sender: nil)
        }
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let indexpath = self.selectedIndexPath
        
        if segue.identifier == "toDetailsVc" {
            let vc = segue.destination as! MenuDetailsVC
            if inSearchMode {
                let menu = filteredObject?[indexpath.row]
                
                vc.menuName = menu?.menuName
                vc.menuCategory = menu?.menuCategory
                vc.menuPrice = menu?.menuPrice
              
            }else {
                
                let menu = self.menu[indexpath.row]
                
                vc.menuName = menu.menuName
                vc.menuCategory = menu.menuCategory
                vc.menuPrice = menu.menuPrice
                vc.imageString = menu.menuImage
            }

        }
    }
    
}
