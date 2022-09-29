//
//  MyCartViewController.swift
//  ShopTest
//
//  Created by Ivan White on 31.08.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol MyCartDisplayLogic: AnyObject {
    func displayData(viewModel: MyCart.Model.ViewModel.ViewModelData)
}

class MyCartViewController: UIViewController, MyCartDisplayLogic {
    
    var interactor: MyCartBusinessLogic?
    var router: (NSObjectProtocol & MyCartRoutingLogic)?
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Init Objects
    
    private let buttonBack: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(named: "blackBlue")
        button.layer.cornerRadius = 10
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(buttonBackFunc), for: .touchUpInside)
        return button
    }()
    
    private let buttonAddress: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(named: "specialOrange")
        button.layer.cornerRadius = 10
        button.setImage(UIImage(systemName: "location"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(buttonAddressFunc), for: .touchUpInside)
        return button
    }()
    
    private let buttonAddressLabel: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Add address", for: .normal)
        button.setTitleColor(UIColor(named: "blackBlue"), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        button.addTarget(self, action: #selector(buttonAddressFunc), for: .touchUpInside)
        return button
    }()
    
    private let labelMyCart: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "My Cart"
        label.textColor = UIColor(named: "blackBlue")
        label.font = UIFont.systemFont(ofSize: 33, weight: .bold)
        return label
    }()
    
    private let blackBlueView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "blackBlue")
        view.layer.cornerRadius = 30
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.15
        view.layer.shadowRadius = 3
        view.layer.shadowOffset = .zero
        return view
    }()
    
    private let cartTableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = .none
        table.bounces = false
        table.separatorStyle = .none
        return table
    }()
    
    private let idCartCell = "idCartCell"
    
    // MARK: Setup
    
    private func setup() {
        let viewController        = self
        let interactor            = MyCartInteractor()
        let presenter             = MyCartPresenter()
        let router                = MyCartRouter()
        viewController.interactor = interactor
        viewController.router     = router
        interactor.presenter      = presenter
        presenter.viewController  = viewController
        router.viewController     = viewController
    }
    
    // MARK: Routing
    
    
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setContraints()
        setDelegates()
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(buttonBack)
        view.addSubview(buttonAddress)
        view.addSubview(buttonAddressLabel)
        view.addSubview(labelMyCart)
        view.addSubview(blackBlueView)
        view.addSubview(cartTableView)
        cartTableView.register(CartTableViewCell.self, forCellReuseIdentifier: idCartCell)
        
    }
    
    func displayData(viewModel: MyCart.Model.ViewModel.ViewModelData) {
        
    }
    
    private func setDelegates() {
        cartTableView.dataSource = self
        cartTableView.delegate = self
    }
    
    // MARK: Buttons func on this screen
    
    @objc private func buttonBackFunc() {
        print("buttonBack was tapped")
    }
    
    @objc private func buttonAddressFunc() {
        print("buttonAddress was tapped")
    }
    
}

// MARK: Set Constraints here
extension MyCartViewController {
    private func setContraints() {
        NSLayoutConstraint.activate([
            buttonBack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            buttonBack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 25),
            buttonBack.heightAnchor.constraint(equalToConstant: 40),
            buttonBack.widthAnchor.constraint(equalToConstant: 40)
        ])
        
        NSLayoutConstraint.activate([
            buttonAddress.centerYAnchor.constraint(equalTo: buttonBack.centerYAnchor, constant: 0),
            buttonAddress.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -25),
            buttonAddress.heightAnchor.constraint(equalToConstant: 40),
            buttonAddress.widthAnchor.constraint(equalToConstant: 40)
        ])
        
        NSLayoutConstraint.activate([
            buttonAddressLabel.centerYAnchor.constraint(equalTo: buttonAddress.centerYAnchor, constant: 0),
            buttonAddressLabel.trailingAnchor.constraint(equalTo: buttonAddress.leadingAnchor, constant: -7)
        ])
        
        NSLayoutConstraint.activate([
            labelMyCart.topAnchor.constraint(equalTo: buttonBack.bottomAnchor, constant: 44),
            labelMyCart.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 25)
        ])
        
        NSLayoutConstraint.activate([
            blackBlueView.topAnchor.constraint(equalTo: labelMyCart.bottomAnchor, constant: 35),
            blackBlueView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            blackBlueView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            blackBlueView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            cartTableView.topAnchor.constraint(equalTo: blackBlueView.topAnchor, constant: 70),
            cartTableView.leadingAnchor.constraint(equalTo: blackBlueView.leadingAnchor, constant: 10),
            cartTableView.trailingAnchor.constraint(equalTo: blackBlueView.trailingAnchor, constant: -10),
            cartTableView.heightAnchor.constraint(equalToConstant: 400)
        ])
    }
}


// MARK: - UITableViewDataSource, UITableViewDelegate
extension MyCartViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: idCartCell, for: indexPath)
                as? CartTableViewCell else {
            return UITableViewCell()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        130
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        10
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        return view
    }
    
    
}
