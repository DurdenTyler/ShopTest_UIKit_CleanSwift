//
//  PopOverPriceViewController.swift
//  ShopTest
//
//  Created by Ivan White on 14.09.2022.
//

import UIKit

protocol PopOverPriceVCProtocol: AnyObject {
    func changePrice(text: String)
}

class PopOverPriceViewController: UIViewController {
    
    private let popOverTablePrice = PopOverTablePrice()
    
    weak var titleChangeDelegate: PopOverPriceVCProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setConstraints()
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(popOverTablePrice)
        popOverTablePrice.mainCellDelegate = self
    }
    
}

// MARK: Set Constraints here

extension PopOverPriceViewController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            popOverTablePrice.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            popOverTablePrice.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            popOverTablePrice.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            popOverTablePrice.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
    }
}

extension PopOverPriceViewController: PopOverTablePriceProtocol {
    func selectItem(text: String) {
        print("selectItem on PopOverViewController is work")
        titleChangeDelegate?.changePrice(text: text)
    }
}

