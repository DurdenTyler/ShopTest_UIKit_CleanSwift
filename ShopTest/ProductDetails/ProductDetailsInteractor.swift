//
//  ProductDetailsInteractor.swift
//  ShopTest
//
//  Created by Ivan White on 31.08.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol ProductDetailsBusinessLogic {
    func makeRequest(request: ProductDetails.Model.Request.RequestType)
}

class ProductDetailsInteractor: ProductDetailsBusinessLogic {
    
    var presenter: ProductDetailsPresentationLogic?
    var service: ProductDetailsService?
    
    func makeRequest(request: ProductDetails.Model.Request.RequestType) {
        if service == nil {
            service = ProductDetailsService()
        }
    }
    
}
