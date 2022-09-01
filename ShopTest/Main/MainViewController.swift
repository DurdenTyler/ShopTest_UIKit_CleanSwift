//
//  MainViewController.swift
//  ShopTest
//
//  Created by Ivan White on 31.08.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol MainDisplayLogic: AnyObject {
    func displayData(viewModel: Main.Model.ViewModel.ViewModelData)
}

class MainViewController: UIViewController, MainDisplayLogic {
    
    var interactor: MainBusinessLogic?
    var router: (NSObjectProtocol & MainRoutingLogic)?
    
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
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 27, weight: .semibold)
        return label
    }()
    
    private let viewAllButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("view all", for: .normal)
        button.tintColor = UIColor(named: "specialOrange")
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        button.addTarget(self, action: #selector(viewAllButtonFunc), for: .touchUpInside)
        return button
    }()
    
    private let categoryCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 3
        layout.scrollDirection = .horizontal
        ///
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.bounces = false
        collection.showsHorizontalScrollIndicator = false
        collection.backgroundColor = .none
        return collection
    }()
    
    private let idCategoryCell = "idCategoryCell"
    
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
    
    private func setupViews() {
        view.backgroundColor = UIColor(named: "backgroundColor")
        view.addSubview(geoButton)
        geoButton.addTarget(self, action: #selector(geoButtonFunc), for: .touchUpInside)
        view.addSubview(filtersButton)
        view.addSubview(labelSelCat)
        view.addSubview(viewAllButton)
        view.addSubview(categoryCollection)
        categoryCollection.register(CategoryCollectionCell.self, forCellWithReuseIdentifier: idCategoryCell)
    }
    
    func displayData(viewModel: Main.Model.ViewModel.ViewModelData) {
        
    }
    
    private func setDelegates() {
        categoryCollection.delegate = self
        categoryCollection.dataSource = self
    }
    
    // MARK: Buttons func on this screen
    
    @objc private func geoButtonFunc() {
        print("geoButton was tapped")
    }
    
    @objc private func filtersButtonFunc() {
        print("filtersButton was tapped")
    }
    
    @objc private func viewAllButtonFunc() {
        print("viewAllButton was tapped")
    }
    
}

// MARK: Set Constraints here

extension MainViewController {
    private func setContraints() {
        NSLayoutConstraint.activate([
            geoButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            geoButton.widthAnchor.constraint(equalToConstant: 130),
            geoButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            filtersButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5.5),
            filtersButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -25),
            filtersButton.heightAnchor.constraint(equalToConstant: 16),
            filtersButton.widthAnchor.constraint(equalToConstant: 13.5)
        ])
        
        NSLayoutConstraint.activate([
            labelSelCat.topAnchor.constraint(equalTo: geoButton.bottomAnchor, constant: 10),
            labelSelCat.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20)
        ])
        
        NSLayoutConstraint.activate([
            viewAllButton.centerYAnchor.constraint(equalTo: labelSelCat.centerYAnchor, constant: 1.5),
            viewAllButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -25)
        ])
        
        NSLayoutConstraint.activate([
            categoryCollection.topAnchor.constraint(equalTo: labelSelCat.bottomAnchor, constant: 10),
            categoryCollection.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            categoryCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            categoryCollection.heightAnchor.constraint(equalToConstant: 115)
        ])
    }
}

// MARK: - UICollectionViewDataSource
extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: idCategoryCell, for: indexPath) as? CategoryCollectionCell else {
            return UICollectionViewCell()
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("TapCell")
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: categoryCollection.frame.width / 4, height: categoryCollection.frame.height)
    }
}

