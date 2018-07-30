//
//  HelpCode.swift
//  Soi71
//
//  Created by RIO on 7/30/18.
//  Copyright © 2018 RIO. All rights reserved.
//

import Foundation

class HelpCode {
    
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
}
