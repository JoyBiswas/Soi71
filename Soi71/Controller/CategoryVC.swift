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
    func mostDownload() {
        
        var request = URLRequest(url: URL(string:"https://arifgroupint.com/test/wc-api/v3/products/categories?consumer_key=ck_d7980b18f40501ebcfe221280a9234e6d11489a1&consumer_secret=cs_f9b4f19bbfdec5464af4596e41787e86741ed973")!)
        
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
                        if key as! String == "product_categories" {
                            
                           let realValueDict =  jsonResult[key] as! NSArray
                            for i in 0 ..< realValueDict.count
                            {
                                
                                jsonElement = realValueDict[i] as! NSDictionary
                                print("JOYadrota \(jsonElement.allValues)")
                                if let name = jsonElement["name"] as? String,let count = jsonElement["count"] as? Int,
                                    let image = jsonElement["image"] as? String {
                                   
                                    print("cjoy",name,image,count)
                                    
                                    let aCategory = CategoryModel(categoryImage: image, categoryName: name, categoryCount: count)
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
