//
//  CartModel.swift
//  Soi71
//
//  Created by JOY BISWAS on 7/25/18.
//  Copyright © 2018 RIO. All rights reserved.
//

import Foundation

class CartModel {
    
    private var _productId:Int!
    private var _productName:String!
    private var _productKey:String!
    private var _productQuantity:Int!
    private var _productToalPrice:Int!
    
    
    var productId:Int {
        
        return _productId
    }
    
    var productName:String {
        
        return _productName
    }
    var productKey:String {
        
        return _productKey
    }
    var productQuantity:Int {
        
        return _productQuantity
    }
    var productTotalPrice:Int {
        
       return _productToalPrice
    }
    init(productId:Int,productName:String,productKey:String,productQuantity:Int,productTotalPrice:Int) {
        
        self._productId = productId
        self._productName = productName
        self._productKey = productKey
        self._productQuantity = productQuantity
        self._productToalPrice = productTotalPrice
        
    }
    
    
    
}
