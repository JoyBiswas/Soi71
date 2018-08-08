//
//  CategoryModel.swift
//  Soi71
//
//  Created by RIO on 7/23/18.
//  Copyright © 2018 RIO. All rights reserved.
//

import Foundation

class CategoryModel {
    
    private var _categoryImage:String!
    private var _categoryName:String!
    private var _categoryCount:Int!
    private var _categoryId:Int!
    
    
    var categoryImage:String {
        
        return _categoryImage
    }
    var categoryName:String {
        
        return _categoryName
    }
    var cateroryCount:Int {
        return _categoryCount
    }
    var categoryId:Int {
        return _categoryId
    }
    
    init(categoryImage:String,categoryName:String,categoryCount:Int,categoryId:Int) {
        
        
        self._categoryImage = categoryImage
        self._categoryName = categoryName
        self._categoryCount = categoryCount
        self._categoryId = categoryId
    }
    
}
