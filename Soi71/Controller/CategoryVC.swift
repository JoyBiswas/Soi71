//
//  CategoryVC.swift
//  Soi71
//
//  Created by RIO on 7/23/18.
//  Copyright © 2018 RIO. All rights reserved.
//

import UIKit



class CategoryVC: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var categoryTable: UITableView!
    
    var category = [CategoryModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
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
            return cell
            
        }else {
            return CategoryTableCell()
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 50.0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cat = category[indexPath.row]
        
//
//        https://mysite.com/wc-api/v1/products?filter[categories]=gedgets&consumer_key=ck_9354534x&consumer_secret=cs_dx7345345

        
        var request = URLRequest(url: URL(string:"\(urlLink)"+"/wc-api/v1/products?"+"[\(cat.categoryName)]"+"=gedgets&"+"\(consumerKey_Sec)")!)
        
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
                    print("Omg",jsonResult)
                    var jsonElement = NSDictionary()
                    
                
                        
                        
                        
                        
                    }
                catch let error as NSError{
                    print(error)
                }
            }
            }.resume()
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
