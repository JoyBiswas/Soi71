//
//  PaymentVC.swift
//  Soi71
//
//  Created by RIO on 8/11/18.
//  Copyright © 2018 RIO. All rights reserved.
//

import UIKit


class PaymentVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    var payMent = [PaymentModel]()
    
    @IBOutlet weak var paymentTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
   
        self.paymentGateWay()
    }
    

    
    func paymentGateWay() {
        
        var request = URLRequest(url: URL(string:"\(urlLink)"+"/wp-json/wc/v2/payment_gateways?"+"\(consumerKey_Sec)")!)
        
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
                    jsonResult = try JSONSerialization.jsonObject(with: data!, options:.allowFragments) as! NSArray;
                    
                    var jsonElement = NSDictionary()
                    print("Paymmmment",jsonResult)
                    
                    for i in 0 ..< jsonResult.count {
                        
                        jsonElement = jsonResult[i] as! NSDictionary
                        
                        if let title = jsonElement["title"] as? String {
                            
                            let apayMent = PaymentModel(paymentTitle: title)
                            
                            self.payMent.append(apayMent)
                            
                        }
                        
                        DispatchQueue.main.async(execute: {
                            self.paymentTable.reloadData()
                            
                        })
                    }
                    
                    
                }catch let error as NSError{
                    print(error)
                }
            }
            }.resume()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.payMent.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let pay = payMent[indexPath.row]
        
        if let cell = paymentTable.dequeueReusableCell(withIdentifier: "PayCell") as? PaymentTableCell {
            
            
                cell.radioButton.setImage(UIImage(named: "elips.png"), for: .selected)
            
                 cell.radioButton.setImage(UIImage(named: "elipsEmpty.png"), for: .normal)
            
           
          
            cell.radioButton.isSelected = false
            
            cell.paymentTitle.text = pay.paymenttitle
            return cell
            
        }else {
            
            return PaymentTableCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let pay = payMent[indexPath.row]
        
        if pay.paymenttitle == "Cash on delivery" {
            
            self.performSegue(withIdentifier: "toBilling", sender: nil)
        }
        
    }

    
    @IBAction func payMentSelectionTapped(_ sender: UIButton!) {
        
        let buttonPosition:CGPoint = (sender as AnyObject).convert(CGPoint.zero, to: self.paymentTable)
    
       
        
        if (sender.isSelected)
        {
            sender.isSelected = false
        }
        else
        {
            sender.isSelected = true
            if let indexPath = self.paymentTable.indexPathForRow(at: buttonPosition) {
                
                let pay = payMent[indexPath.row]
                
                if pay.paymenttitle == "Cash on delivery" {
                    
                    self.performSegue(withIdentifier: "toBilling", sender: nil)
                }
                
            }
        }
        
    }
    
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        
    }
    
}
