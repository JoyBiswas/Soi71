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
     var boxView = UIView()
    
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
            self.menuPriceLbl.text = "৳\(self.menuPrice!)"
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
        textLabel.backgroundColor = UIColor.black
        textLabel.textColor = UIColor.white
        textLabel.text = "Adding To Cart"
        boxView.addSubview(activityView)
        boxView.addSubview(textLabel)
        
        view.addSubview(boxView)
    }

    
    @IBAction func addToChartTapped(_ sender: Any) {
        self.addSavingPhotoView()
        if let count = Int(self.orderCountTextLbl.text!){
            let parameters: [String: Any] = ["product_id": self.menuId!,"quantity": count]
            
            
            let session = URLSession.shared
            
            
            var request = URLRequest(url: URL(string:"\(urlLink)"+"/wp-json/wc/v2/cart/add")!)
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
                    
                    if (try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any]) != nil {
                        
                        let alertController = UIAlertController(title: "Product Added To The Cart", message: "", preferredStyle: .alert)
                        
                        
                        alertController.view.backgroundColor = UIColor.green// change background color
                        alertController.view.layer.cornerRadius = 50
                        let confirmAction = UIAlertAction(title: "Back", style: .default, handler: { (_) in
                            
                            self.boxView.removeFromSuperview()
                            self.dismiss(animated: true, completion: nil)
                        })
                        let viewAction = UIAlertAction(title: "View Cart", style: .default, handler: { (_) in
                            
                            self.boxView.removeFromSuperview()
                            self.performSegue(withIdentifier: "toCart", sender: nil)
                        })
                        alertController.addAction(confirmAction)
                        alertController.addAction(viewAction)
                        
                        self.present(alertController, animated: true, completion: nil)
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
