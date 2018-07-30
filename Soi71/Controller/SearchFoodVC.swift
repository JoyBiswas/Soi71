//
//  SearchFoodVC.swift
//  Soi71
//
//  Created by RIO on 7/22/18.
//  Copyright © 2018 RIO. All rights reserved.
//

import UIKit

class SearchFoodVC: UIViewController,UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate{
    
    
    @IBOutlet weak var popupView: UIView!
    
    @IBOutlet weak var searchProductTable:UITableView!
    
    @IBOutlet weak var popupImageView: UIImageView!
    
    var viewShow = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
       self.popupView.isHidden = true
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 15
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = searchProductTable.dequeueReusableCell(withIdentifier: "SCell") as? SearcProducTableCell {
            cell.productName.text = "S-01.Crispy Duck"
            cell.productPrice.text = "$955"
            let selectedView = UIView()
            selectedView.layer.cornerRadius = 5.0
            selectedView.backgroundColor = UIColor(rgb: 0x42B72A)
            cell.selectedBackgroundView = selectedView
            
            return cell
            
        }else {
            return SearcProducTableCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.manuBtn()
        
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 65.0
    }
    func manuBtn() {
        
        if(viewShow == true )
        {
            
            let image = UIImage(named: "popCross.png") as UIImage?
            let button = UIButton(type: UIButtonType.custom) as UIButton
            button.frame = CGRect(x: popupImageView.frame.width-55, y: 10, width: 45, height: 45)
             button.setImage(image, for: .normal)
            
            
            button.addTarget(self, action: #selector(self.tapBlurButton(_:)), for: .touchUpInside)
            
          button.clipsToBounds = true
            button.isUserInteractionEnabled = true
            
            self.popupView.addSubview(button)
           
            

           self.popupView.isHidden = false
            handelanimation()

           
            
        }
        else{
           self.popupView.isHidden = true
          
            
        }
        
        
    }
    @objc func tapBlurButton(_ sender: UIButton) {
        self.popupView.isHidden = true
    }
  
    @objc func handelanimation()
    {
        popupView.center = view.center
        popupView.alpha = 1
        popupView.transform = CGAffineTransform(scaleX: 0.8, y: 1.2)
        
        self.view.addSubview(popupView)
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [],  animations: {
            //use if you want to darken the background
            //self.viewDim.alpha = 0.8
            //go back to original form
            self.popupView.transform = .identity
        })
    }
    
 
    
    func handleTap(gestureRecognizer: UIGestureRecognizer) {
       self.popupView.isHidden = true
        
    }

    
    @IBAction func cancelPopup(_ sender: Any) {
        self.popupView.isHidden = true
    }
    
}
extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}
