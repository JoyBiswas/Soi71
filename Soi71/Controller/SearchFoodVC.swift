//
//  SearchFoodVC.swift
//  Soi71
//
//  Created by RIO on 7/22/18.
//  Copyright © 2018 RIO. All rights reserved.
//

import UIKit

class SearchFoodVC: UIViewController,UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate,UITextFieldDelegate{
    
    
    @IBOutlet weak var popupView: UIView!
    
    @IBOutlet weak var searchProductTable:UITableView!
    
    @IBOutlet weak var popupImageView: UIImageView!
    @IBOutlet weak var searchTextField: UITextField!
    
    
    //PopUp section
    
    @IBOutlet weak var menuImageView: UIImageView!
    
    
    @IBOutlet weak var menuNameTV: UITextView!
    
    @IBOutlet weak var menuPriceLbl: UILabel!
    
    @IBOutlet weak var orderCountTextLbl: UILabel!
    
    
    @IBOutlet weak var categoryLbl: UILabel!
    
    
    var menu = [SearchProductModel]()
    var filteredObject:[SearchProductModel]?
    
    var viewShow = true
    var inSearchMode = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mostDownload()
        searchTextField.delegate = self
      
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
        if inSearchMode {
            
            return (filteredObject?.count)!
        }
        
        return menu.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = searchProductTable.dequeueReusableCell(withIdentifier: "SCell") as? SearcProducTableCell {
            let menu: SearchProductModel!
            
            if inSearchMode {
                menu = filteredObject?[indexPath.row]
                
            } else {
                
                menu = self.menu[indexPath.row]
                
            }
            cell.productName.text = menu.menuName
            cell.productPrice.text = "$\(menu.menuPrice)"
            
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
        
        
        if inSearchMode {
            let menu = filteredObject?[indexPath.row]
            
            let url = URL(string: (menu?.menuImage)!)!
            
            self.downloadImage(url: url)
            
            self.menuNameTV.text = menu?.menuName
            self.categoryLbl.text = menu?.menuCategory
            self.menuPriceLbl.text = "$\(String(describing: menu?.menuPrice))"
            self.manuBtn()
            
        }else {
            
            let menu = self.menu[indexPath.row]
            
            let url = URL(string: menu.menuImage)!
            self.downloadImage(url: url)
            
            self.menuNameTV.text = menu.menuName
            self.categoryLbl.text = menu.menuCategory
            self.menuPriceLbl.text = "$\(menu.menuPrice)"
            self.manuBtn()
        }
        
        
        
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 65.0
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
    
    
    
    func mostDownload() {
        
        var request = URLRequest(url: URL(string:"https://arifgroupint.com/test/wc-api/v3/products?consumer_key=ck_d7980b18f40501ebcfe221280a9234e6d11489a1&consumer_secret=cs_f9b4f19bbfdec5464af4596e41787e86741ed973")!)
        
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
                    jsonResult = try JSONSerialization.jsonObject(with: data!, options:.allowFragments) as! NSDictionary;                    print("hisss\(jsonResult)")
                    
                    var jsonElement = NSDictionary()
                    
                    for (key,_) in jsonResult
                    {
                        if key as! String == "products" {
                            
                            let realValueDict =  jsonResult[key] as! NSArray
                            for i in 0 ..< realValueDict.count
                            {
                                
                                jsonElement = realValueDict[i] as! NSDictionary
                                print("JOYadrota \(jsonElement.allValues)")
                                if let name = jsonElement["title"] as? String,
                                    let regular_price = jsonElement["regular_price"] as? String,
                                    let categories = jsonElement["categories"] as? [String],
                                    let image = jsonElement["images"] as? [[String:Any]]{
                                    
                                    if let img = image.first {
                                        
                                        if let cate = categories.first {
                                            let aMenu = SearchProductModel(menuImage: img["src"] as! String, menuName: name, menuPrice: regular_price, menuCategory: cate)
                                            self.menu.append(aMenu)
                                            
                                        }
                                    }
                                    
                                    
                                }
                                
                                
                                
                                DispatchQueue.main.async(execute: {
                                    self.searchProductTable.reloadData()
                                    
                                })
                                
                                
                                
                            }
                        }
                        
                        
                        
                    }
                }catch let error as NSError{
                    print(error)
                }
            }
            }.resume()
    }
    
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        searchTextField.resignFirstResponder()
        
        return true
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.searchTextField.endEditing(true)
        
    }
    
    @IBAction func searchForProduct(_ sender: Any) {
        if searchTextField.text == nil || searchTextField.text == "" {

            inSearchMode = false
            self.searchProductTable.reloadData()
            view.endEditing(true)

        } else {

            inSearchMode = true
            let lowerCase = searchTextField.text!.lowercased()


            filteredObject = menu.filter({$0.menuName.lowercased().hasPrefix(lowerCase) })

            self.searchProductTable.reloadData()



        }
        
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

    // popUp section action
    
    
    @IBAction func plusButtonForCount(_ sender: Any) {
        
        self.orderCountTextLbl.text = String(Int(self.orderCountTextLbl.text!)!+1)
    }
    
    @IBAction func minusButtonCount(_ sender: Any) {
        self.orderCountTextLbl.text = String(Int(self.orderCountTextLbl.text!)!-1)
    }
    
    @IBAction func addToChartTapped(_ sender: Any) {
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
