//
//  MainPresenter.swift
//  ShopTest
//
//  Created by Ivan White on 31.08.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol MainPresentationLogic {
    func presentData(response: Main.Model.Response.ResponseType)
}

class MainPresenter: MainPresentationLogic {
    weak var viewController: MainDisplayLogic?
    
    func presentData(response: Main.Model.Response.ResponseType) {
        
    }
    
}
