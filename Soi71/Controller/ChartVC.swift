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
    
    @IBOutlet weak var cartSubTotal: UILabel!
    
    @IBOutlet weak var vatLabel: UILabel!
    
    @IBOutlet weak var cartTotal: UILabel!
    
    @IBOutlet weak var shippingTotal: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.cartT()
        self.cartTotalCall()
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
    func cartTotalCall(){
        
        
        
        var request = URLRequest(url: URL(string:"https://arifgroupint.com/test/wp-json/wc/v2/cart/totals")!)
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
                    
                    print("cart\(jsonResult)")
                    if let subtotal = jsonResult["subtotal"] as? String,
                        let shipping_total = jsonResult["shipping_total"] as? String,
                        let total = jsonResult["total"] as? String
                        
                        {
                            DispatchQueue.main.async(execute: {
                                self.cartSubTotal.text = "$\(subtotal)"
                                self.cartTotal.text = "$\(total)"
                                self.shippingTotal.text = "$\(shipping_total)"
                            })
                            
                            
                        
                        }
                    
                }catch let error as NSError{
                    print(error)
                }
            }
            }.resume()
        
    }
    func cartT(){
        
        
        
        var request = URLRequest(url: URL(string:"https://arifgroupint.com/test/wp-json/wc/v2/cart")!)
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
                    
                    for (_,value) in jsonResult {
                        
                        jsonElement = value as! NSDictionary
                        print("lolo\(jsonElement)")
                        
                        if let product_id = jsonElement["product_id"] as? Int,
                            let product_name = jsonElement["product_name"] as? String,
                            let quantity = jsonElement["quantity"] as? Int,
                            let key = jsonElement["key"] as? String
                            {
                            
                                print("Holo ki",product_id,product_name,quantity,key)
                            
                            
                        }
                    }
                    
                }catch let error as NSError{
                    print(error)
                }
            }
            }.resume()
        
    }

 
    @IBAction func backButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
