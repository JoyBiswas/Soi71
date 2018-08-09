//
//  CategoryVC.swift
//  Soi71
//
//  Created by RIO on 7/23/18.
//  Copyright © 2018 RIO. All rights reserved.
//

import UIKit



class CategoryVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var boxView = UIView()
    @IBOutlet weak var categoryTable: UITableView!
    var selectedIndexPath: NSIndexPath = NSIndexPath()

    
    var category = [CategoryModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loading()
        self.categoryTable.reloadData()
        self.mostDownload()

    }
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return category.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let category = self.category[indexPath.row]
        if let cell = categoryTable.dequeueReusableCell(withIdentifier: "CCell") as? CategoryTableCell {
            
            
            cell.configureCell(category: category, img: nil)
            let selectedView = UIView()
            selectedView.layer.cornerRadius = 5.0
            selectedView.backgroundColor = UIColor(rgb: 0x42B72A)
            cell.selectedBackgroundView = selectedView
            return cell
            
        }else {
            return CategoryTableCell()
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 50.0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.selectedIndexPath = indexPath as NSIndexPath
        self.performSegue(withIdentifier: "toDetails", sender: nil)
        
 
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        self.boxView.removeFromSuperview()
        if let lastVisibleIndexPath = tableView.indexPathsForVisibleRows?.last {
            if indexPath == lastVisibleIndexPath {
                
            }
        }
    }
    func loading() {
        // You only need to adjust this frame to move it anywhere you want
        boxView = UIView(frame: CGRect(x: view.frame.midX - 100, y: view.frame.midY , width: 200, height: 50))
        boxView.backgroundColor = UIColor.white
        boxView.alpha = 1.0
        boxView.layer.cornerRadius = 10
        
        //Here the spinnier is initialized
        let activityView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
        activityView.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
       
        activityView.startAnimating()
        
        
        let textLabel = UILabel(frame: CGRect(x: 60, y: 0, width: 132, height: 50))
        textLabel.backgroundColor = UIColor.green.withAlphaComponent(0.50)
        textLabel.textColor = UIColor.white
        textLabel.textAlignment = .center
        textLabel.text = "Loading •••"
        
        boxView.addSubview(activityView)
        boxView.addSubview(textLabel)
        
        
        view.addSubview(boxView)
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let indexpath = self.selectedIndexPath
        
       
        if segue.identifier == "toDetails" {
            let vc = segue.destination as! SearchFoodVC
              let cat = category[indexpath.row]
                vc.categoryName = cat.categoryName
                vc.catName = true
            
        }
    }
    func mostDownload() {
        
        var request = URLRequest(url: URL(string:"\(urlLink)"+"/wc-api/v3/products/categories?"+"\(consumerKey_Sec)")!)
        
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
                    
                    for (key,_) in jsonResult
                    {
                        if key as! String == "product_categories" {
                            
                           let realValueDict =  jsonResult[key] as! NSArray
                            for i in 0 ..< realValueDict.count
                            {
                                
                                jsonElement = realValueDict[i] as! NSDictionary
                                if let name = jsonElement["name"] as? String,let count = jsonElement["count"] as? Int,
                                    let image = jsonElement["image"] as? String,
                                    let catId = jsonElement["id"] as? Int
                                {
                                   
                                    print("cjoy",name,image,count)
                                    
                                    let aCategory = CategoryModel(categoryImage: image, categoryName: name, categoryCount: count, categoryId: catId)
                                    self.category.append(aCategory)
                                    
                                    
                                }
                                
                                    
                                DispatchQueue.main.async(execute: {
                                    
                                    self.categoryTable.reloadData()
                                    
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
    

    @IBAction func backButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

}
