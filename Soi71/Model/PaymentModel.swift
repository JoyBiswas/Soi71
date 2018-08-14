//
//  PaymentModel.swift
//  Soi71
//
//  Created by RIO on 8/11/18.
//  Copyright © 2018 RIO. All rights reserved.
//

import Foundation

class PaymentModel {
    
    private var _paymentTitle:String!
    
    var paymenttitle:String {
        
        return _paymentTitle
    }
    
    init(paymentTitle:String) {
        
        self._paymentTitle = paymentTitle
    }
    
}
