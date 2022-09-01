//
//  MainInteractor.swift
//  ShopTest
//
//  Created by Ivan White on 31.08.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol MainBusinessLogic {
    func makeRequest(request: Main.Model.Request.RequestType)
}

class MainInteractor: MainBusinessLogic {
    
    var presenter: MainPresentationLogic?
    var service: MainService?
    
    func makeRequest(request: Main.Model.Request.RequestType) {
        if service == nil {
            service = MainService()
        }
    }
    
}
