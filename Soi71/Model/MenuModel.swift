//
//  MenuModel.swift
//  Soi71
//
//  Created by RIO on 7/23/18.
//  Copyright © 2018 RIO. All rights reserved.
//

import Foundation
class MenuModel {
    private var _menuImage:String!
    private var _menuName:String!
    private var _menuPrice:String!
    private var _menuCategory:String!
    private var _menuId:Int
    
    
    var menuImage:String {
        
        return _menuImage
    }
    var menuName:String {
        
        return _menuName
    }
    var menuPrice:String {
        return _menuPrice
    }
    var menuCategory:String {
        
        return _menuCategory
    }
    var menuId:Int {
        
        return _menuId
    }
    
    init(menuImage:String,menuName:String,menuPrice:String,menuCategory:String,menuId:Int) {
        
        
        self._menuImage = menuImage
        self._menuName = menuName
        self._menuPrice = menuPrice
        self._menuCategory = menuCategory
        self._menuId = menuId
    }
    
}
