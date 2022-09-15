//
//  PopOverViewController.swift
//  ShopTest
//
//  Created by Ivan White on 12.09.2022.
//

import UIKit

protocol PopOverVCProtocol: AnyObject {
    func changeTitle(text: String)
}

class PopOverPhoneViewController: UIViewController {
    
    private let popOverTablePhone = PopOverTablePhone()
    
    weak var titleChangeDelegate: PopOverVCProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setConstraints()
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(popOverTablePhone)
        popOverTablePhone.mainCellDelegate = self
    }
    
}

// MARK: Set Constraints here

extension PopOverPhoneViewController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            popOverTablePhone.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            popOverTablePhone.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            popOverTablePhone.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            popOverTablePhone.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
    }
}

extension PopOverPhoneViewController: PopOverTableViewProtocol {
    func selectItem(text: String) {
        print("selectItem on PopOverViewController is work")
        titleChangeDelegate?.changeTitle(text: text)
    }
}
