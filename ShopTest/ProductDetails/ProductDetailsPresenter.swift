//
//  ProductDetailsPresenter.swift
//  ShopTest
//
//  Created by Ivan White on 31.08.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol ProductDetailsPresentationLogic {
    func presentData(response: ProductDetails.Model.Response.ResponseType)
}

class ProductDetailsPresenter: ProductDetailsPresentationLogic {
    weak var viewController: ProductDetailsDisplayLogic?
    
    func presentData(response: ProductDetails.Model.Response.ResponseType) {
        
    }
    
}
