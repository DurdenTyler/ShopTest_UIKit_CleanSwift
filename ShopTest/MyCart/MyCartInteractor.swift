//
//  MyCartInteractor.swift
//  ShopTest
//
//  Created by Ivan White on 31.08.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol MyCartBusinessLogic {
    func makeRequest(request: MyCart.Model.Request.RequestType)
}

class MyCartInteractor: MyCartBusinessLogic {
    
    var presenter: MyCartPresentationLogic?
    var service: MyCartService?
    
    func makeRequest(request: MyCart.Model.Request.RequestType) {
        if service == nil {
            service = MyCartService()
        }
    }
    
}
