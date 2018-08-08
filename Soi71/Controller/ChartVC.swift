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
    
    var aCartList = [CartModel]()
    var boxView = UIView()
    var selectedIndexPath: NSIndexPath = NSIndexPath()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.cartList()
        self.cartTotalCall()
        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return aCartList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if let cell = cartTable.dequeueReusableCell(withIdentifier: "CCELL") as? CartTableCell {
            
            let cart = aCartList[indexPath.row]
            
            cell.configureCell(cart: cart)
            
            return cell
            
        }else {
            return CartTableCell()
        }
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 45.0
    }
    func cartTotalCall(){
        
        
        
        var request = URLRequest(url: URL(string:"\(urlLink)"+"/wp-json/wc/v2/cart/totals")!)
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
    func cartList(){
        
        
        
        var request = URLRequest(url: URL(string:"\(urlLink)"+"/wp-json/wc/v2/cart")!)
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
                    self.aCartList.removeAll()
                    
                    for (_,value) in jsonResult {
                        
                        jsonElement = value as! NSDictionary
                        
                        
                        if let product_id = jsonElement["product_id"] as? Int,
                            let product_name = jsonElement["product_name"] as? String,
                            let quantity = jsonElement["quantity"] as? Int,
                            let key = jsonElement["key"] as? String,
                            let productPrice = jsonElement["line_total"] as? Int
                        {
                            
                            
                            let aCart = CartModel(productId: product_id, productName: product_name, productKey: key, productQuantity: quantity, productTotalPrice: productPrice)
                            
                            self.aCartList.append(aCart)
                            
                            
                        }
                        DispatchQueue.main.async(execute: {
                            self.cartTable.reloadData()
                            
                        })
                        
                    }
                    
                }catch let error as NSError{
                    print(error)
                }
            }
            }.resume()
        
    }
    // popUp section action
    func addSavingPhotoView() {
        // You only need to adjust this frame to move it anywhere you want
        boxView = UIView(frame: CGRect(x: view.frame.midX - 90, y: view.frame.midY - 25, width: 180, height: 50))
        boxView.backgroundColor = UIColor.white
        boxView.alpha = 0.8
        boxView.layer.cornerRadius = 10
        
        //Here the spinnier is initialized
        let activityView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
        activityView.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        activityView.startAnimating()
        
        let textLabel = UILabel(frame: CGRect(x: 60, y: 0, width: 200, height: 50))
        textLabel.backgroundColor = UIColor.red
        textLabel.textColor = UIColor.white
        textLabel.text = "Deleting The Item"
        
        boxView.addSubview(activityView)
        boxView.addSubview(textLabel)
        
        view.addSubview(boxView)
    }

    
    @IBAction func removeAItemFromCart(_ sender: Any) {
        let buttonPosition:CGPoint = (sender as AnyObject).convert(CGPoint.zero, to: self.cartTable)
        if let indexPath = self.cartTable.indexPathForRow(at: buttonPosition) {
            
           self.addSavingPhotoView()
            
            self.selectedIndexPath = indexPath as NSIndexPath
            let aItem = self.aCartList[indexPath.row]
            
            if  aItem.productKey != "" {
                let item = aItem.productKey
                let parameters: [String: Any] = ["cart_item_key":item]
                
                
                let session = URLSession.shared
                
                
                var request = URLRequest(url: URL(string:"\(urlLink)"+"/wp-json/wc/v2/cart/cart-item")!)
                request.httpMethod = "DELETE" //set http method as POST
                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                request.addValue("application/json", forHTTPHeaderField: "Accept")
                
                do {
                    request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) // pass dictionary to nsdata object and set it as request body
                } catch let error {
                    print(error.localizedDescription)
                }
                
                
                
                //create dataTask using the session object to send data to the server
                let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
                    
                    guard error == nil else {
                        return
                    }
                    
                    guard let data = data else {
                        return
                    }
                    let nsstr = NSString(data: data , encoding: String.Encoding.utf8.rawValue)
                    let alertController = UIAlertController(title: aItem.productName, message: nsstr as String?, preferredStyle: .alert)
                    
                    
                    alertController.view.backgroundColor = UIColor.green// change background color
                    alertController.view.layer.cornerRadius = 50
                    let confirmAction = UIAlertAction(title: "Ok", style: .default, handler: { (_) in
                        
                        self.boxView.removeFromSuperview()
                        
                    })
                    alertController.addAction(confirmAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                    DispatchQueue.main.async(execute: {
                        self.cartList()
                        self.cartTotalCall()
                        self.cartTable.backgroundColor = UIColor.black
                        
                    })
                    
                    
                    
                    
                })
                
                task.resume()
                
                
                
            }
            
        }
        
        
    }
    
    
    @IBAction func backButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
