//
//  MenuTableCell.swift
//  Soi71
//
//  Created by RIO on 7/23/18.
//  Copyright © 2018 RIO. All rights reserved.
//

import UIKit

class MenuTableCell: UITableViewCell {
    
    @IBOutlet weak var menuImage: UIImageView!
    
    @IBOutlet weak var menuName: UITextView!
    
    @IBOutlet weak var menuPrice: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    
    
    var menu:MenuModel!
    
    func configureCell(menu:MenuModel ,img:UIImage?) {
        self.menu = menu
        self.menuName.text = menu.menuName
        self.menuPrice.text = "$\(menu.menuPrice)"
        
        if let url = URL(string: menu.menuImage) {
            
            
            if img != nil {
                self.menuImage.image = img
                
                
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
                self.menuImage.image = UIImage(data: data)
            }
        }
    }
    
    
    
    
    
    

    @IBAction func viewDetileBTnTapped(_ sender: Any) {
    }
    
    @IBAction func addToChartBtnTapped(_ sender: Any) {
        print("Add to chart Pressed")
    }
}
