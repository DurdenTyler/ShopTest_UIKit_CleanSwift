//
//  PopOverSizeViewController.swift
//  ShopTest
//
//  Created by Ivan White on 14.09.2022.
//

import UIKit

protocol PopOverSizeVCProtocol: AnyObject {
    func changeSize(text: String)
}

class PopOverSizeViewController: UIViewController {
    
    private let popOverTableSize = PopOverTableSize()
    
    weak var titleChangeDelegate: PopOverSizeVCProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setConstraints()
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(popOverTableSize)
        popOverTableSize.mainCellDelegate = self
    }
    
}

// MARK: Set Constraints here

extension PopOverSizeViewController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            popOverTableSize.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            popOverTableSize.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            popOverTableSize.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            popOverTableSize.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
    }
}

extension PopOverSizeViewController: PopOverTableSizeProtocol {
    func selectItem(text: String) {
        print("selectItem on PopOverViewController is work")
        titleChangeDelegate?.changeSize(text: text)
    }
}
