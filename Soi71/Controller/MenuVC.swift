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
    var boxView = UIView()
    
    @IBOutlet weak var menuSearchBtn: UIButton!
    
    @IBOutlet weak var menuListTable: UITableView!
    var selectedIndexPath: NSIndexPath = NSIndexPath()

    
    var menu = [MenuModel]()
    var filteredObject:[MenuModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
         self.loading()
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
            let selectedView = UIView()
            selectedView.layer.cornerRadius = 5.0
            selectedView.backgroundColor = nil
            cell.selectedBackgroundView = selectedView
            
            cell.configureCell(menu: menu, img: nil)
            
            return cell
            
        }else {
            return MenuTableCell()
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 101.0
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        self.boxView.removeFromSuperview()
        if let lastVisibleIndexPath = tableView.indexPathsForVisibleRows?.last {
            if indexPath == lastVisibleIndexPath {
                
            }
        }
    }
    func loading() {
        // You only need to adjust this frame to move it anywhere you want
        boxView = UIView(frame: CGRect(x: view.frame.midX - 100, y: view.frame.midY , width: 200, height: 50))
        boxView.backgroundColor = UIColor.white
        boxView.alpha = 1.0
        boxView.layer.cornerRadius = 10
        
        //Here the spinnier is initialized
        let activityView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
        activityView.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        
        activityView.startAnimating()
        
        
        let textLabel = UILabel(frame: CGRect(x: 60, y: 0, width: 132, height: 50))
        textLabel.backgroundColor = UIColor.green.withAlphaComponent(0.50)
        textLabel.textColor = UIColor.white
        textLabel.textAlignment = .center
        textLabel.text = "Loading •••"
        
        boxView.addSubview(activityView)
        boxView.addSubview(textLabel)
        
        
        view.addSubview(boxView)
    }
    
    func mostDownload() {
        
        var request = URLRequest(url: URL(string:"\(urlLink)"+"/wc-api/v3/products?"+"\(consumerKey_Sec)")!)
        
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
                    jsonResult = try JSONSerialization.jsonObject(with: data!, options:.allowFragments) as! NSDictionary;                    
                    
                    var jsonElement = NSDictionary()
                    
                    for (key,_) in jsonResult
                    {
                        if key as! String == "products" {
                            
                            let realValueDict =  jsonResult[key] as! NSArray
                            for i in 0 ..< realValueDict.count
                            {
                                
                                jsonElement = realValueDict[i] as! NSDictionary
                                
                                if let name = jsonElement["title"] as? String,
                                    let id = jsonElement["id"] as? Int,
                                    let regular_price = jsonElement["regular_price"] as? String,
                                    let categories = jsonElement["categories"] as? [String],
                                    let image = jsonElement["images"] as? [[String:Any]]{
                                    
                                    if let img = image.first {
                                        
                                        if let cate = categories.first {
                                            let aMenu = MenuModel(menuImage: img["src"] as! String, menuName: name, menuPrice: regular_price, menuCategory: cate, menuId: id)
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.selectedIndexPath = indexPath as NSIndexPath
        self.performSegue(withIdentifier: "toDetailsVc", sender: nil)
    }
    
    
    @IBAction func viewDetailsButtonTapped(_ sender: Any) {
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
                vc.imageString = menu?.menuImage
                vc.menuId = menu?.menuId
              
            }else {
                
                let menu = self.menu[indexpath.row]
                
                vc.menuName = menu.menuName
                vc.menuCategory = menu.menuCategory
                vc.menuPrice = menu.menuPrice
                vc.imageString = menu.menuImage
                vc.menuId = menu.menuId
            }

        }
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
