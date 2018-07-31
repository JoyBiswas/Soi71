//
//  CategoryTableCell.swift
//  Soi71
//
//  Created by RIO on 7/23/18.
//  Copyright © 2018 RIO. All rights reserved.
//

import UIKit

class CategoryTableCell:UITableViewCell {

    
    @IBOutlet weak var categoryName:UILabel!
    @IBOutlet weak var categoryImage:UIImageView!
    
   
    
    var category:CategoryModel!
    
    func configureCell(category:CategoryModel ,img:UIImage?) {
        self.category = category
        self.categoryName.text = "\(category.categoryName) (\(category.cateroryCount))"
        
        if let url = URL(string: category.categoryImage) {
        
        
        if img != nil {
            self.categoryImage.image = img
            
            
        }else {
            
            self.downloadImage(url: url)
            
        }
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
                self.categoryImage.image = UIImage(data: data)
            }
        }
    }
    

    
    
}
