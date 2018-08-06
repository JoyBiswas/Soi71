//
//  MenuDetailsVC.swift
//  Soi71
//
//  Created by RIO on 7/24/18.
//  Copyright © 2018 RIO. All rights reserved.
//

import UIKit

class MenuDetailsVC: UIViewController {
    var menuName:String!
    var menuPrice:String!
    var menuCategory:String!
    var imageString:String!
    var menuId:Int!
    
    @IBOutlet weak var menuImageView: UIImageView!
    
    
    @IBOutlet weak var menuNameTV: UITextView!
    
    @IBOutlet weak var menuPriceLbl: UILabel!
    
    @IBOutlet weak var orderCountTextLbl: UILabel!
    
    
    @IBOutlet weak var categoryLbl: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        if menuName != "",menuPrice != "",menuCategory != "",imageString != "" {

            let url = URL(string: self.imageString)

            self.downloadImage(url: url!)
            self.menuNameTV.text = self.menuName!
            self.menuPriceLbl.text = "$\(self.menuPrice!)"
            self.categoryLbl.text = self.menuCategory!
            self.orderCountTextLbl.text = "3"
        }

       
    }
    
    func getDataFromUrl(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            completion(data, response, error)
            }.resume()
    }
    func downloadImage(url: URL) {
        self.getDataFromUrl(url: url) { data, response, error in
            guard let data = data, error == nil else { return }
            
            DispatchQueue.main.async() {
                self.menuImageView.image = UIImage(data: data)
            }
        }
    }

    @IBAction func plusButtonForCount(_ sender: Any) {
        
        self.orderCountTextLbl.text = String(Int(self.orderCountTextLbl.text!)!+1)
    }
    
    @IBAction func minusButtonCount(_ sender: Any) {
         self.orderCountTextLbl.text = String(Int(self.orderCountTextLbl.text!)!-1)
    }
    
    @IBAction func addToChartTapped(_ sender: Any) {
        if let count = Int(self.orderCountTextLbl.text!){
            let parameters: [String: Any] = ["product_id": self.menuId!,"quantity": count]
            
            
            let session = URLSession.shared
            
            
            var request = URLRequest(url: URL(string:"https://arifgroupint.com/test/wp-json/wc/v2/cart/add")!)
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
    }

    
    @IBAction func backButtonPreesed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
