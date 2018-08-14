//
//  HelpCode.swift
//  Soi71
//
//  Created by RIO on 7/30/18.
//  Copyright © 2018 RIO. All rights reserved.
//

import Foundation

class HelpCode {
    
    var dict = [
        
        "id":[1],
        "url":["joy"],
        "coun":[3]
        
        
        
    ]
    
        func mostDownload() {
    
            var request = URLRequest(url: URL(string:"https://arifgroupint.com/test/wp-json/wc/v2/products?consumer_key=ck_d7980b18f40501ebcfe221280a9234e6d11489a1&consumer_secret=cs_f9b4f19bbfdec5464af4596e41787e86741ed973")!)
    
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
    
                    var jsonResult = NSArray()
                    do{
                        jsonResult = try JSONSerialization.jsonObject(with: data!, options:.allowFragments) as! NSArray;                    print("hisss\(jsonResult)")
    
                        var jsonElement = NSDictionary()
    
                        for i in 0 ..< jsonResult.count
                        {
                            jsonElement = jsonResult[i] as! NSDictionary
                            print("Jitendronath\(jsonElement.allValues)")
    
                            //                        if let name = jsonElement["name"] as? String,
                            print("KLKL\(String(describing: jsonElement["images"] ))")
                            if let image = jsonElement["images"] as? [[String:Any]],
                                let id = jsonElement["id"] as? Int,
                                let slug = jsonElement["slug"] as? String,
                                let tax_status = jsonElement["tax_status"] as? String,
                                let in_stock = jsonElement["in_stock"] as? Int,
                                let regular_price = jsonElement["regular_price"] as? String,
                                let categories = jsonElement["categories"] as? [[String:Any]]
                            {
                                //,categories,,,,dimension,
                                let cat = categories.first
                                print(id,slug,tax_status,in_stock,regular_price,cat!["name"]!)
    
                               // let imaagee = image.first
    
    
    
    
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
    
    
    func creatAnCustomer() {
        
        let parameters: [String: Any] = [
            
            "customer":[
                
                "email": "john.doe@example.com",
                "first_name": "John",
                "last_name": "Doe",
                "username": "john.doe",
                "billing_address":[
                    "first_name": "John",
                    "last_name": "Doe",
                    "company": "",
                    "address_1": "969 Market",
                    "address_2": "",
                    "city": "San Francisco",
                    "state": "CA",
                    "postcode": "94103",
                    "country": "US",
                    "email": "john.doe@example.com",
                    "phone": "(555) 555-5555"
                ],
                "shipping_address":[
                
                    "first_name": "John",
                    "last_name": "Doe",
                    "company": "",
                    "address_1": "969 Market",
                    "address_2": "",
                    "city": "San Francisco",
                    "state": "CA",
                    "postcode": "94103",
                    "country": "US"
                
                ]
            
            ]
        ]
        
        
     
        
        //create the url with URL
       //change the url
        
        //create the session object
        let session = URLSession.shared
        
      var request = URLRequest(url: URL(string:"https://arifgroupint.com/test/wc-api/v3/customers?consumer_key=ck_d7980b18f40501ebcfe221280a9234e6d11489a1&consumer_secret=cs_f9b4f19bbfdec5464af4596e41787e86741ed973")!)
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
            let nsstr = NSString(data: data , encoding: String.Encoding.utf8.rawValue)
            print("JOUUU\(nsstr!)")
            
            do {
                
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                    
                    // handle json...
                    print(json)
                }
            }
            catch let error {
                print(error.localizedDescription)
            }
            
        })
        task.resume()
    }
    
    
    func creatAnOrder() {
        
        let parameters: [String: Any] = [
            
            "order":[
                "payment_details": [
                    "method_id": "bacs",
                    "method_title": "Direct Bank Transfer",
                    "paid": true
                ],
                "billing_address": [
                    "first_name": "Joy",
                    "last_name": "Biswas",
                    "address_1": "kaderabad Housing",
                    "address_2": "",
                    "city": "Dhaka",
                    "state": "D",
                    "postcode": "1207",
                    "country": "BD",
                    "email": "cjoydevb@gmail.com",
                    "phone": "+8801946999547"
                ],
                "shipping_address": [
                    "first_name": "Joy",
                    "last_name": "Biswas",
                    "address_1": "kaderabad Housing",
                    "address_2": "",
                    "city": "Dhaka",
                    "state": "D",
                    "postcode": "1207",
                    "country": "BD"
                ],
                "customer_id": 2,
                "line_items": [
                    [
                        "product_id": 58,
                        "quantity": 2
                    ]
                ],
                "shipping_lines": [
                    [
                        "method_id": "flat_rate",
                        "method_title": "Flat Rate",
                        "total": 10
                    ]
                ]
                
            ]
        ]
        
        //create the session object
        let session = URLSession.shared
        
        var request = URLRequest(url: URL(string:"https://arifgroupint.com/test/wc-api/v3/customers?consumer_key=ck_d7980b18f40501ebcfe221280a9234e6d11489a1&consumer_secret=cs_f9b4f19bbfdec5464af4596e41787e86741ed973")!)
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
            let nsstr = NSString(data: data , encoding: String.Encoding.utf8.rawValue)
            print("JOUUU\(nsstr!)")
            
            do {
                
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                    
                    // handle json...
                    print(json)
                }
            }
            catch let error {
                print(error.localizedDescription)
            }
            
        })
        task.resume()
    }
    
    func dictionaryHandle(){
        dict["url"]?.append("joyadrotajoyadrotajoyadrotajoyadrotajoyadrotajoyadrotajoyadrotajoyadrotavjoyadrotajoyadrota")
        dict["id"]?.append(3)
        
        for (key,_) in dict {
            if key == "url" {
                
                print(dict[key]!)
            }
        }
        print(dict)
        
    }
    
    
}
