//
//  ShippingBillingVC.swift
//  Soi71
//
//  Created by RIO on 8/13/18.
//  Copyright © 2018 RIO. All rights reserved.
//

import UIKit

var line_items = [[String:Any]]()
var shi_total = 0.0

class ShippingBillingVC: UIViewController,UITextFieldDelegate {
    var boxView = UIView()
    
    @IBOutlet weak var firstNameTF: UITextField!
    
    
    @IBOutlet weak var lastNameTF: UITextField!
    
    @IBOutlet weak var adress1TF: UITextField!
    
    @IBOutlet weak var adress2TF: UITextField!
    
    @IBOutlet weak var cityTF: UITextField!
    
    @IBOutlet weak var stateTF: UITextField!
    
    @IBOutlet weak var postalCodeTF: UITextField!
    
    @IBOutlet weak var countryTF: UITextField!
    
    @IBOutlet weak var emailTF: UITextField!
    
    @IBOutlet weak var phnNoTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.cartList()
        self.cartTotalCall()
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
                    
                    
                    if let _ = jsonResult["subtotal"] as? String,
                        let shipping_total = jsonResult["shipping_total"] as? String,
                        let _ = jsonResult["total"] as? String
                        
                    {
                        shi_total = Double(shipping_total)!
                        
                        
                        
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
                
                //var jsonResult = NSDictionary()
                do{
                    
                    if let jsonResult = try? JSONSerialization.jsonObject(with: data!, options:[]) as? NSDictionary  {
                        var jsonElement = NSDictionary()
                        
                        line_items.removeAll()
                        
                        for (_,value) in jsonResult! {
                            
                            jsonElement = value as! NSDictionary
                            
                            
                            if let product_id = jsonElement["product_id"] as? Int,
                                let _ = jsonElement["product_name"] as? String,
                                let quantity = jsonElement["quantity"] as? Int,
                                let _ = jsonElement["key"] as? String,
                                let _ = jsonElement["line_total"] as? Int
                            {
                                
                                let aOrder = ["product_id": product_id,
                                              "quantity": quantity]
                                line_items.append(aOrder)
                                
                                
                                
                                
                            }
                            
                        }
                        
                        
                        return
                    }else {
                        
                        let alertController = UIAlertController(title:"Your cart is empty.", message: "Please add product to the cart.", preferredStyle: .alert)
                        
                        
                        alertController.view.backgroundColor = UIColor.green// change background color
                        alertController.view.layer.cornerRadius = 50
                        let confirmAction = UIAlertAction(title: "OK", style: .default, handler: { (_) in
                            
                            
                            
                        })
                        alertController.addAction(confirmAction)
                        
                        self.present(alertController, animated: true, completion: nil)
                        
                        
                    }
                    
                    
                }
            }
            }.resume()
        
    }
    
    
    func creatAnOrder() {
        
        if let fname = self.firstNameTF.text,fname != "",let lname = self.lastNameTF.text,lname != "",let adress1 = self.adress1TF.text,adress1 != "",let city = self.cityTF.text,city != "",let state = self.stateTF.text,state != "",let postalCode = self.postalCodeTF.text,postalCode != "",let country = self.countryTF.text,country != "",let email = self.emailTF.text,email != "",let phnNo = self.phnNoTF.text,phnNo != "",line_items.count > 0,shi_total > 0.0 {
            self.loading()
        
        let parameters: [String: Any] = [
            
            "order":[
                "payment_details": [
                    "method_id": "COD",
                    "method_title": "Cash On Delivery",
                    "paid": false
                ],
                "billing_address": [
                    "first_name": fname,
                    "last_name": lname,
                    "address_1": adress1,
                    "address_2": self.adress2TF.text!,
                    "city": city,
                    "state": state,
                    "postcode": postalCode,
                    "country": country,
                    "email": email,
                    "phone": phnNo
                ],
                "shipping_address": [
                    "first_name": fname,
                    "last_name": lname,
                    "address_1": adress1,
                    "address_2": self.adress2TF.text!,
                    "city": city,
                    "state": state,
                    "postcode": postalCode,
                    "country": country
                ],
                "line_items":line_items,
                "shipping_lines": [
                    [
                        "method_id": "flat_rate",
                        "method_title": "Flat Rate",
                        "total": shi_total
                    ]
                ]
            ]
        ]
        //create the session object
        let session = URLSession.shared
        
        var request = URLRequest(url: URL(string:"\(urlLink)"+"/wc-api/v3/orders?"+"\(consumerKey_Sec)")!)
        
        request.httpMethod = "POST" //set http method as POST
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
            _ = NSString(data: data , encoding: String.Encoding.utf8.rawValue)
            
            
            do {
                
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                   
                    
                    let alertController = UIAlertController(title:"Suceess 👍🏽.We will contact(📞) you very soon \(fname).", message: "\(json.values)" , preferredStyle: .alert)
                    
                    
                    alertController.view.backgroundColor = UIColor.green// change background color
                    alertController.view.layer.cornerRadius = 50
                    let confirmAction = UIAlertAction(title: "OK", style: .default, handler: { (_) in
                        
                        self.boxView.removeFromSuperview()
                        
                    })
                    alertController.addAction(confirmAction)
                    
                    self.present(alertController, animated: true, completion: nil)

                    
                   
                }
            }
            catch let error {
                print(error.localizedDescription)
            }
            
        })
        task.resume()
        self.firstNameTF.text = ""
         self.lastNameTF.text = ""
          self.adress1TF.text = ""
            self.adress2TF.text = ""
             self.cityTF.text = ""
             self.postalCodeTF.text = ""
             self.countryTF.text = ""
             self.emailTF.text = ""
             self.phnNoTF.text = ""
             self.stateTF.text = ""
        }else {
            let alertController = UIAlertController(title:"Empty Field.", message: "Please check your billing adress fields carefully.", preferredStyle: .alert)
            
            
            alertController.view.backgroundColor = UIColor.red// change background color
            alertController.view.layer.cornerRadius = 75
            let confirmAction = UIAlertAction(title: "OK", style: .default, handler: { (_) in
                
                
                
            })
            alertController.addAction(confirmAction)
            
            self.present(alertController, animated: true, completion: nil)
            
        }
    }
    
    @IBAction func confirmOrderTapped(_ sender: Any) {
        
        self.creatAnOrder()
        
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
        textLabel.text = "Processing •••"
        
        boxView.addSubview(activityView)
        boxView.addSubview(textLabel)
        
        
        view.addSubview(boxView)
    }

    

    @IBAction func backPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        return true
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
    }

}
