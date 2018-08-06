//
//  CartTableCell.swift
//  Soi71
//
//  Created by JOY BISWAS on 7/25/18.
//  Copyright © 2018 RIO. All rights reserved.
//

import UIKit

class CartTableCell: UITableViewCell {
    
    @IBOutlet weak var productImage: UIImageView!
    
    @IBOutlet weak var productName: UITextView!
    
    @IBOutlet weak var productPrice: UILabel!
    
    
    @IBOutlet weak var productQnt: UILabel!
    
    @IBOutlet weak var productTotalPrice: UILabel!
    @IBOutlet weak var qntView: UIView!
    
    
    
    
    
    var cart:CartModel!
    
    func configureCell(cart:CartModel) {
        self.cart = cart
        self.productName.text = cart.productName
        self.productTotalPrice.text = "$\(cart.productTotalPrice)"
        self.productQnt.text = "\(cart.productQuantity)"
        self.productById(id: cart.productId)
        
        
        
      
    }
    
    
    func getDataFromUrl(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            completion(data, response, error)
            }.resume()
    }
    func downloadImage(url: URL,price:String) {
        self.getDataFromUrl(url: url) { data, response, error in
            guard let data = data, error == nil else { return }
            
            DispatchQueue.main.async() {
                self.productImage.image = UIImage(data: data)
                self.productPrice.text = price
            }
        }
    }
    

    
    
  
    func productById(id:Int) {
        
        var request = URLRequest(url: URL(string:"https://arifgroupint.com/test/wc-api/v3/products/"+String(id)+"?consumer_key=ck_d7980b18f40501ebcfe221280a9234e6d11489a1&consumer_secret=cs_f9b4f19bbfdec5464af4596e41787e86741ed973")!)
        
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
                    
                    for (_,value) in jsonResult {
                        
                        jsonElement = value as! NSDictionary
                        print("humtum",jsonElement)
                        
                        if let regular_price = jsonElement["regular_price"] as? String,
                            let _ = jsonElement["categories"] as? [String],
                            let image = jsonElement["images"] as? [[String:Any]]{
                            if let img = image.first {
                                
                                
                                if let imageSrc = URL(string: img["src"] as! String) {
                                    self.downloadImage(url: imageSrc, price: regular_price)
                                    
                                }
                            }
                            
                        }
                        
                    }
                    
                    // if let productPrice = jsonResult["regular_price"] as? String {
                    
                    
                    // }
                    
                    
                    
                }catch let error as NSError{
                    print(error)
                }
            }
            }.resume()
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        qntView.layer.masksToBounds = true
        
    }



}
