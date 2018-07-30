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
        self.mostDownload()
      
        
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
            cell.menuName.text = "S-01.Crispy Duck,01kkjkjksdhjhhS1kkjkjksdhjhh"
            cell.menuPrice.text = "$950.0"
            
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
                                if let name = jsonElement["title"] as? String,let count = jsonElement["id"] as? Int,let regular_price = jsonElement["regular_price"] as? String,
                                    let categories = jsonElement["categories"] as? [String],let image = jsonElement["images"] as? [[String:Any]]{
                                    
                                    let img = image.first
                                    print(name,count,regular_price,categories.first as! String,img!["src"] as! String)
                                    
                                }
                                
                                
                                
                                
                                
                                
                            }
                        }
                        
                        
                        DispatchQueue.main.async(execute: {
                            
                            
                        })
                        
                    }
                }catch let error as NSError{
                    print(error)
                }
            }
            }.resume()
    }



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
    
    
    @IBAction func viewDetailsButtonTapped(_ sender: Any) {
        print("hello view")
        let buttonPosition:CGPoint = (sender as AnyObject).convert(CGPoint.zero, to: self.menuListTable)
        if let indexPath = self.menuListTable.indexPathForRow(at: buttonPosition) {
            print(indexPath.row )
            self.performSegue(withIdentifier: "toDetailsVc", sender: nil)
        }
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toDetailsVc" {
            let vc = segue.destination as! MenuDetailsVC
            vc.name = "yello"
        }
    }
    
}
