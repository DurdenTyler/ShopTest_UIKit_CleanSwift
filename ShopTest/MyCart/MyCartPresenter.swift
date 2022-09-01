//
//  MyCartPresenter.swift
//  ShopTest
//
//  Created by Ivan White on 31.08.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol MyCartPresentationLogic {
    func presentData(response: MyCart.Model.Response.ResponseType)
}

class MyCartPresenter: MyCartPresentationLogic {
    weak var viewController: MyCartDisplayLogic?
    
    func presentData(response: MyCart.Model.Response.ResponseType) {
        
    }
    
}
