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
    
    @IBOutlet weak var menuImageView: UIImageView!
    
    
    @IBOutlet weak var menuNameTV: UITextView!
    
    @IBOutlet weak var menuPriceLbl: UILabel!
    
    @IBOutlet weak var orderCountTextLbl: UILabel!
    
    
    @IBOutlet weak var categoryLbl: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        if menuName != "",menuPrice != "",menuCategory != "",imageString != "" {

            let url = URL(string: self.imageString)!

            self.downloadImage(url: url)
            self.menuNameTV.text = self.menuName!
            self.menuPriceLbl.text = "$\(self.menuPrice!)"
            self.categoryLbl.text = self.menuCategory!
            self.orderCountTextLbl.text = "3"
        }
//
       
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
    }
    
    
}
