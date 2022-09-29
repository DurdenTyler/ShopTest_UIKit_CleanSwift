//
//  MainViewController.swift
//  ShopTest
//
//  Created by Ivan White on 31.08.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol MainProtocol: AnyObject {
    func clickOnFilter()
}

protocol MainDisplayLogic: AnyObject {
    func displayData(viewModel: Main.Model.ViewModel.ViewModelData)
}

class MainViewController: UIViewController, MainDisplayLogic {
    
    var interactor: MainBusinessLogic?
    var router: (NSObjectProtocol & MainRoutingLogic)?
    
    weak var mainDelegate: MainProtocol?
    
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
    
    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView(frame: .zero)
        scroll.frame = view.bounds
        scroll.contentSize = contentSize
        scroll.bounces = false
        scroll.showsVerticalScrollIndicator = false
        return scroll
    }()
    
    private var contentSize: CGSize {
        CGSize(width: view.frame.width, height: view.frame.height + 470)
    }
    
    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.frame.size = contentSize
        return contentView
    }()
    
    private let geoButton = GeoButton()
    
    private let filtersButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "filterIcon"), for: .normal)
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.tintColor = .black
        button.addTarget(self, action: #selector(filtersButtonFunc), for: .touchUpInside)
        return button
    }()
    
    private let labelSelCat: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Select Category"
        label.textColor = UIColor(named: "blackBlue")
        label.font = UIFont.systemFont(ofSize: 27, weight: .semibold)
        return label
    }()
    
    private let viewAllButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("view all", for: .normal)
        button.tintColor = UIColor(named: "specialOrange")
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        button.addTarget(self, action: #selector(viewAllButtonFunc), for: .touchUpInside)
        return button
    }()
    
    private let categoryCollection = CategoryCollectionView()
    
    private let searchTextField: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.backgroundColor = .white
        field.placeholder = "Search"
        field.textColor = .gray
        field.layer.cornerRadius = 20
        field.borderStyle = .none
        field.font = UIFont.systemFont(ofSize: 15, weight: .light)
        field.clearButtonMode = .always
        field.returnKeyType = .done
        
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "magnifyingglass")
        imageView.tintColor = UIColor(named: "specialOrange")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        field.addSubview(imageView)
        imageView.centerXAnchor.constraint(equalTo: field.leadingAnchor, constant: 25).isActive = true
        imageView.centerYAnchor.constraint(equalTo: field.centerYAnchor).isActive = true
        
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 55, height: field.frame.height))
        field.leftViewMode = .always
        return field
    }()
    
    
    private let qrCodeButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "QRCode"), for: .normal)
        button.backgroundColor = UIColor(named: "specialOrange")
        button.tintColor = .white
        button.addTarget(self, action: #selector(qrCodeButtonFunc), for: .touchUpInside)
        return button
    }()
    
    private let labelHotSal: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Hot Sales"
        label.textColor = UIColor(named: "blackBlue")
        label.font = UIFont.systemFont(ofSize: 27, weight: .semibold)
        return label
    }()
    
    private let seeMoreButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("see more", for: .normal)
        button.tintColor = UIColor(named: "specialOrange")
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        button.addTarget(self, action: #selector(seeMoreButtonFunc), for: .touchUpInside)
        return button
    }()
    
    private let hotSalesCollection = HotSalesCollectionView()
    
    private let labelBestSeller: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Best Seller"
        label.textColor = UIColor(named: "blackBlue")
        label.font = UIFont.systemFont(ofSize: 27, weight: .semibold)
        return label
    }()
    
    private let seeMore2Button: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("see more", for: .normal)
        button.tintColor = UIColor(named: "specialOrange")
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        button.addTarget(self, action: #selector(seeMore2ButtonFunc), for: .touchUpInside)
        return button
    }()
    
    private let bestSellerCollection = BestSellerCollectionView()
    
    // MARK: Setup
    
    private func setup() {
        let viewController        = self
        let interactor            = MainInteractor()
        let presenter             = MainPresenter()
        let router                = MainRouter()
        viewController.interactor = interactor
        viewController.router     = router
        interactor.presenter      = presenter
        presenter.viewController  = viewController
        router.viewController     = viewController
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupViews()
        setDelegates()
        setContraints()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        qrCodeButton.layer.cornerRadius = qrCodeButton.frame.width / 2
    }
    
    private func setupViews() {
        view.backgroundColor = UIColor(named: "backgroundColor")
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(geoButton)
        geoButton.addTarget(self, action: #selector(geoButtonFunc), for: .touchUpInside)
        contentView.addSubview(filtersButton)
        contentView.addSubview(labelSelCat)
        contentView.addSubview(viewAllButton)
        contentView.addSubview(categoryCollection)
        contentView.addSubview(searchTextField)
        contentView.addSubview(qrCodeButton)
        contentView.addSubview(labelHotSal)
        contentView.addSubview(seeMoreButton)
        contentView.addSubview(hotSalesCollection)
        contentView.addSubview(labelBestSeller)
        contentView.addSubview(seeMore2Button)
        contentView.addSubview(bestSellerCollection)
    }
    
    func displayData(viewModel: Main.Model.ViewModel.ViewModelData) {
        
    }
    
    private func setDelegates() {
        searchTextField.delegate = self
    }
    
    // MARK: Buttons func on this screen
    
    @objc private func geoButtonFunc() {
        print("geoButton was tapped")
    }
    
    @objc private func filtersButtonFunc() {
        mainDelegate?.clickOnFilter()
        print("filter was tapped")
    }
    
    @objc private func viewAllButtonFunc() {
        print("viewAllButton was tapped")
    }
    
    @objc private func qrCodeButtonFunc() {
        print("qrCodeButton was tapped")
    }
    
    @objc private func seeMoreButtonFunc() {
        print("seeMoreButton was tapped")
    }
    
    @objc private func seeMore2ButtonFunc() {
        print("seeMore2Button was tapped")
    }
    
}

// MARK: Set Constraints here

extension MainViewController {
    private func setContraints() {
        NSLayoutConstraint.activate([
            geoButton.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 5),
            geoButton.widthAnchor.constraint(equalToConstant: 130),
            geoButton.centerXAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            filtersButton.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 5.5),
            filtersButton.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -25),
            filtersButton.heightAnchor.constraint(equalToConstant: 16),
            filtersButton.widthAnchor.constraint(equalToConstant: 13.5)
        ])
        
        NSLayoutConstraint.activate([
            labelSelCat.topAnchor.constraint(equalTo: geoButton.bottomAnchor, constant: 5),
            labelSelCat.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 15)
        ])
        
        NSLayoutConstraint.activate([
            viewAllButton.centerYAnchor.constraint(equalTo: labelSelCat.centerYAnchor, constant: 1.5),
            viewAllButton.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -25)
        ])
        
        NSLayoutConstraint.activate([
            categoryCollection.topAnchor.constraint(equalTo: labelSelCat.bottomAnchor, constant: 15),
            categoryCollection.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            categoryCollection.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            categoryCollection.heightAnchor.constraint(equalToConstant: 115)
        ])
        
        NSLayoutConstraint.activate([
            searchTextField.topAnchor.constraint(equalTo: categoryCollection.bottomAnchor, constant: 20),
            searchTextField.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 45),
            searchTextField.widthAnchor.constraint(equalToConstant: 265),
            searchTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        NSLayoutConstraint.activate([
            qrCodeButton.centerYAnchor.constraint(equalTo: searchTextField.centerYAnchor),
            qrCodeButton.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant:  -25),
            qrCodeButton.heightAnchor.constraint(equalToConstant: 40),
            qrCodeButton.widthAnchor.constraint(equalToConstant: 40)
        ])
        
        NSLayoutConstraint.activate([
            labelHotSal.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 20),
            labelHotSal.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 15)
        ])
        
        NSLayoutConstraint.activate([
            seeMoreButton.centerYAnchor.constraint(equalTo: labelHotSal.centerYAnchor, constant: 1.5),
            seeMoreButton.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -25)
        ])
        
        NSLayoutConstraint.activate([
            hotSalesCollection.topAnchor.constraint(equalTo: labelHotSal.bottomAnchor, constant: 2),
            hotSalesCollection.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            hotSalesCollection.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            hotSalesCollection.heightAnchor.constraint(equalToConstant: 220)
        ])
        
        NSLayoutConstraint.activate([
            labelBestSeller.topAnchor.constraint(equalTo: hotSalesCollection.bottomAnchor, constant: 20),
            labelBestSeller.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 15)
        ])
        
        NSLayoutConstraint.activate([
            seeMore2Button.centerYAnchor.constraint(equalTo: labelBestSeller.centerYAnchor, constant: 1.5),
            seeMore2Button.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -25)
        ])
        
        NSLayoutConstraint.activate([
            bestSellerCollection.topAnchor.constraint(equalTo: labelBestSeller.bottomAnchor, constant: 12),
            bestSellerCollection.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            bestSellerCollection.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            bestSellerCollection.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -30)
        ])
    }
}

// MARK: UITextFieldDelegate
extension MainViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.resignFirstResponder()
    }
}
