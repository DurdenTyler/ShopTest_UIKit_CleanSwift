//
//  ProductDetailsViewController.swift
//  ShopTest
//
//  Created by Ivan White on 31.08.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import Cosmos

protocol ProductDetailsDisplayLogic: AnyObject {
    func displayData(viewModel: ProductDetails.Model.ViewModel.ViewModelData)
}

class ProductDetailsViewController: UIViewController, ProductDetailsDisplayLogic {
    
    var interactor: ProductDetailsBusinessLogic?
    var router: (NSObjectProtocol & ProductDetailsRoutingLogic)?
    
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
    
    private var centerSepUnderShop: NSLayoutConstraint!
    private var centerSepUnderDetails: NSLayoutConstraint!
    private var centerSepUnderFeatures: NSLayoutConstraint!
    
    private var widthSepUnderShop: NSLayoutConstraint!
    private var widthSepUnderDetails: NSLayoutConstraint!
    private var widthSepUnderFeatures: NSLayoutConstraint!
    
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
    
    private let labelProductDetails: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Product Details"
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.textAlignment = .center
        label.textColor = UIColor(named: "blackBlue")
        return label
    }()
    
    private let buttonCart: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(named: "specialOrange")
        button.layer.cornerRadius = 10
        button.setImage(UIImage(systemName: "bag"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(buttonCartFunc), for: .touchUpInside)
        return button
    }()
    
    private let imagesCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 15
        layout.sectionInset = UIEdgeInsets(top: 0, left: 60, bottom: 0, right: 60)
        
        ///
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.bounces = false
        collection.showsHorizontalScrollIndicator = false
        collection.backgroundColor = .none
        return collection
    }()
    
    private let cell = ImageCollectionCell()
    
    private let idImageCell = "idImageCell"
    
    private let whiteView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 30
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.15
        view.layer.shadowRadius = 3
        view.layer.shadowOffset = .zero
        return view
    }()
    
    private let labelTitleProduct: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Galaxy Note 20 Ultra"
        label.font = UIFont.systemFont(ofSize: 25, weight: .medium)
        label.textAlignment = .center
        label.textColor = UIColor(named: "blackBlue")
        return label
    }()
    
    private let buttonAddToFavorite: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(named: "blackBlue")
        button.layer.cornerRadius = 11
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(buttonAddToFavoriteFunc), for: .touchUpInside)
        return button
    }()
    
    private var rating: CosmosView = {
        let rating = CosmosView()
        rating.translatesAutoresizingMaskIntoConstraints = false
        rating.settings.updateOnTouch = false
        rating.settings.fillMode = .half
        rating.rating = 3.5
        return rating
    }()
    
    private let buttonShop: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Shop", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.setTitleColor(UIColor(named: "blackBlue"), for: .selected)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 22, weight: .regular)
        button.addTarget(self, action: #selector(buttonShopFunc), for: .touchUpInside)
        return button
    }()
    
    private let buttonDetails: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Details", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.setTitleColor(UIColor(named: "blackBlue"), for: .selected)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 22, weight: .regular)
        button.addTarget(self, action: #selector(buttonDetailsFunc), for: .touchUpInside)
        return button
    }()
    
    private let buttonFeatures: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Features", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.setTitleColor(UIColor(named: "blackBlue"), for: .selected)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 22, weight: .regular)
        button.addTarget(self, action: #selector(buttonFeaturesFunc), for: .touchUpInside)
        return button
    }()
    
    private let orangeSeparator: UIView = {
        let sep = UIView()
        sep.translatesAutoresizingMaskIntoConstraints = false
        sep.backgroundColor = UIColor(named: "specialOrange")
        sep.layer.cornerRadius = 2.5
        return sep
    }()
    
    private let cheapImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "cheap")
        return image
    }()
    
    private let cameraImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "camera")
        return image
    }()
    
    private let ozyImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "ozy")
        return image
    }()
    
    private let ssdImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "ssd")
        return image
    }()
    
    private let cheapLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Exynos 990"
        label.font = UIFont.systemFont(ofSize: 12, weight: .light)
        label.textAlignment = .center
        label.textColor = .gray
        return label
    }()
    
    private let cameraLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "108 + 12 mp"
        label.font = UIFont.systemFont(ofSize: 12, weight: .light)
        label.textAlignment = .center
        label.textColor = .gray
        return label
    }()
    
    private let ozyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "8 GB"
        label.font = UIFont.systemFont(ofSize: 12, weight: .light)
        label.textAlignment = .center
        label.textColor = .gray
        return label
    }()
    
    private let ssdLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "256 GB"
        label.font = UIFont.systemFont(ofSize: 12, weight: .light)
        label.textAlignment = .center
        label.textColor = .gray
        return label
    }()
    
    private let labelSelectClrAndCpct: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Select color and capacity"
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.textAlignment = .center
        label.textColor = UIColor(named: "blackBlue")
        return label
    }()
    
    private let buttonColorBrown: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .darkGray
        button.addTarget(self, action: #selector(buttonColorBrownFunc), for: .touchUpInside)
        button.tintColor = .white
        return button
    }()
    
    private let buttonColorBlackBlue: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(named: "blackBlue")
        button.addTarget(self, action: #selector(buttonColorBlackBlueFunc), for: .touchUpInside)
        button.tintColor = .white
        return button
    }()
    
    private let button128GB: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("128 GB", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.setTitleColor(.white, for: .selected)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        button.layer.cornerRadius = 11
        button.addTarget(self, action: #selector(button128GBFunc), for: .touchUpInside)
        return button
    }()
    
    private let button256GB: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("256 GB", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.setTitleColor( .white, for: .selected)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        button.layer.cornerRadius = 11
        button.addTarget(self, action: #selector(button256GBFunc), for: .touchUpInside)
        return button
    }()
    
    private let buttonAddToCart: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Add to Cart       $1.500.00", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        button.layer.cornerRadius = 11
        button.backgroundColor = UIColor(named: "specialOrange")
        button.addTarget(self, action: #selector(buttonAddToCartFunc), for: .touchUpInside)
        return button
    }()
    
    
    // MARK: Setup
    
    private func setup() {
        let viewController        = self
        let interactor            = ProductDetailsInteractor()
        let presenter             = ProductDetailsPresenter()
        let router                = ProductDetailsRouter()
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
        setup()
        setupViews()
        setContraints()
        setDelegates()
        definedSepConstraints()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        buttonColorBrown.layer.cornerRadius = buttonColorBrown.frame.width / 2
        buttonColorBlackBlue.layer.cornerRadius = buttonColorBlackBlue.frame.width / 2
    }
    
    private func setupViews() {
        view.backgroundColor = UIColor(named: "backgroundColor")
        view.addSubview(buttonBack)
        view.addSubview(labelProductDetails)
        view.addSubview(buttonCart)
        view.addSubview(imagesCollection)
        imagesCollection.register(ImageCollectionCell.self, forCellWithReuseIdentifier: idImageCell)
        view.addSubview(whiteView)
        view.addSubview(labelTitleProduct)
        view.addSubview(buttonAddToFavorite)
        view.addSubview(rating)
        view.addSubview(buttonShop)
        view.addSubview(buttonDetails)
        view.addSubview(buttonFeatures)
        buttonShop.isSelected = true
        buttonShop.titleLabel?.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        view.addSubview(orangeSeparator)
        view.addSubview(cheapImage)
        view.addSubview(cameraImage)
        view.addSubview(ozyImage)
        view.addSubview(ssdImage)
        view.addSubview(cheapLabel)
        view.addSubview(cameraLabel)
        view.addSubview(ozyLabel)
        view.addSubview(ssdLabel)
        view.addSubview(labelSelectClrAndCpct)
        view.addSubview(buttonColorBrown)
        view.addSubview(buttonColorBlackBlue)
        view.addSubview(button128GB)
        view.addSubview(button256GB)
        buttonColorBrown.isSelected = true
        buttonColorBrown.setImage(UIImage(systemName: "checkmark"), for: .normal)
        button128GB.isSelected = true
        button128GB.backgroundColor = UIColor(named: "specialOrange")
        view.addSubview(buttonAddToCart)
    }
    
    func displayData(viewModel: ProductDetails.Model.ViewModel.ViewModelData) {
        
    }
    
    private func setDelegates() {
        imagesCollection.dataSource = self
        imagesCollection.delegate = self
    }
    
    // MARK: Buttons func on this screen
    
    @objc private func buttonBackFunc() {
        print("buttonBack was tapped")
    }
    
    @objc private func buttonCartFunc() {
        print("buttonCart was tapped")
    }
    
    @objc private func buttonAddToFavoriteFunc() {
        print("buttonAddToFavorite was tapped")
    }
    
    @objc private func buttonShopFunc() {
        print("buttonShop was tapped")
        sepUnderShop()
        buttonShop.isSelected = true
        buttonShop.titleLabel?.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        
        if buttonShop.isSelected {
            buttonDetails.isSelected = false
            buttonDetails.titleLabel?.font = UIFont.systemFont(ofSize: 22, weight: .regular)
            buttonFeatures.isSelected = false
            buttonFeatures.titleLabel?.font = UIFont.systemFont(ofSize: 22, weight: .regular)
            
        }
    }
    
    @objc private func buttonDetailsFunc() {
        print("buttonDetails was tapped")
        sepUnderDetails()
        buttonDetails.isSelected = true
        buttonDetails.titleLabel?.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        
        if buttonDetails.isSelected {
            buttonShop.isSelected = false
            buttonShop.titleLabel?.font = UIFont.systemFont(ofSize: 22, weight: .regular)
            buttonFeatures.isSelected = false
            buttonFeatures.titleLabel?.font = UIFont.systemFont(ofSize: 22, weight: .regular)
        }
    }
    
    @objc private func buttonFeaturesFunc() {
        print("buttonFeatures was tapped")
        sepUnderFeatures()
        buttonFeatures.isSelected = true
        buttonFeatures.titleLabel?.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        
        if buttonFeatures.isSelected {
            buttonShop.isSelected = false
            buttonShop.titleLabel?.font = UIFont.systemFont(ofSize: 22, weight: .regular)
            buttonDetails.isSelected = false
            buttonDetails.titleLabel?.font = UIFont.systemFont(ofSize: 22, weight: .regular)
        }
    }
    
    @objc private func buttonColorBrownFunc() {
        print("buttonColorBrown was tapped")
        buttonColorBrown.isSelected = true
        
        if buttonColorBrown.isSelected {
            buttonColorBlackBlue.isSelected = false
            buttonColorBlackBlue.setImage(.none, for: .normal)
            buttonColorBrown.setImage(UIImage(systemName: "checkmark"), for: .normal)
        }
    }
    
    @objc private func buttonColorBlackBlueFunc() {
        print("buttonColorBlackBlue was tapped")
        buttonColorBlackBlue.isSelected = true
        
        if buttonColorBlackBlue.isSelected {
            buttonColorBrown.isSelected = false
            buttonColorBrown.setImage(.none, for: .normal)
            buttonColorBlackBlue.setImage(UIImage(systemName: "checkmark"), for: .normal)
        }
    }
    
    @objc private func button128GBFunc() {
        print("button128GB was tapped")
        button128GB.isSelected = true
        
        if button128GB.isSelected {
            button256GB.isSelected = false
            button256GB.backgroundColor = .none
            button128GB.backgroundColor = UIColor(named: "specialOrange")
        }
    }
    
    @objc private func button256GBFunc() {
        print("button256GB was tapped")
        button256GB.isSelected = true
        
        if button256GB.isSelected {
            button128GB.isSelected = false
            button128GB.backgroundColor = .none
            button256GB.backgroundColor = UIColor(named: "specialOrange")
        }
    }
    
    @objc private func buttonAddToCartFunc() {
        print("buttonAddToCart was tapped")
    }
    
}

// MARK: Set Constraints here
extension ProductDetailsViewController {
    private func setContraints() {
        NSLayoutConstraint.activate([
            buttonBack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            buttonBack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 25),
            buttonBack.heightAnchor.constraint(equalToConstant: 40),
            buttonBack.widthAnchor.constraint(equalToConstant: 40)
        ])
        
        NSLayoutConstraint.activate([
            labelProductDetails.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor, constant: 0),
            labelProductDetails.centerYAnchor.constraint(equalTo: buttonBack.centerYAnchor, constant: 0)
        ])
        
        NSLayoutConstraint.activate([
            buttonCart.centerYAnchor.constraint(equalTo: buttonBack.centerYAnchor, constant: 0),
            buttonCart.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -25),
            buttonCart.heightAnchor.constraint(equalToConstant: 40),
            buttonCart.widthAnchor.constraint(equalToConstant: 40)
        ])
        
        NSLayoutConstraint.activate([
            imagesCollection.topAnchor.constraint(equalTo: buttonBack.bottomAnchor, constant: 10),
            imagesCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imagesCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imagesCollection.heightAnchor.constraint(equalToConstant: 300)
        ])
        
        NSLayoutConstraint.activate([
            whiteView.topAnchor.constraint(equalTo: imagesCollection.bottomAnchor, constant: 3),
            whiteView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            whiteView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            whiteView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            labelTitleProduct.topAnchor.constraint(equalTo: whiteView.topAnchor, constant: 25),
            labelTitleProduct.leadingAnchor.constraint(equalTo: whiteView.safeAreaLayoutGuide.leadingAnchor, constant: 30)
        ])
        
        NSLayoutConstraint.activate([
            buttonAddToFavorite.centerYAnchor.constraint(equalTo: labelTitleProduct.centerYAnchor),
            buttonAddToFavorite.trailingAnchor.constraint(equalTo: whiteView.safeAreaLayoutGuide.trailingAnchor, constant: -30),
            buttonAddToFavorite.heightAnchor.constraint(equalToConstant: 37),
            buttonAddToFavorite.widthAnchor.constraint(equalToConstant: 42)
        ])
        
        NSLayoutConstraint.activate([
            rating.topAnchor.constraint(equalTo: labelTitleProduct.bottomAnchor, constant: 10),
            rating.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30)
        ])
        
        NSLayoutConstraint.activate([
            buttonShop.topAnchor.constraint(equalTo: rating.bottomAnchor, constant: 15),
            buttonShop.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30)
        ])
        
        NSLayoutConstraint.activate([
            buttonDetails.centerYAnchor.constraint(equalTo: buttonShop.centerYAnchor, constant: 0),
            buttonDetails.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor, constant: -10)
        ])
        
        NSLayoutConstraint.activate([
            buttonFeatures.centerYAnchor.constraint(equalTo: buttonShop.centerYAnchor, constant: 0),
            buttonFeatures.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30)
        ])
        
        NSLayoutConstraint.activate([
            cheapImage.topAnchor.constraint(equalTo: buttonShop.bottomAnchor, constant: 20),
            cheapImage.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 45),
            cheapImage.widthAnchor.constraint(equalToConstant: 25),
            cheapImage.heightAnchor.constraint(equalToConstant: 25)
        ])
        
        NSLayoutConstraint.activate([
            cheapLabel.topAnchor.constraint(equalTo: cheapImage.bottomAnchor, constant: 10),
            cheapLabel.centerXAnchor.constraint(equalTo: cheapImage.centerXAnchor, constant: 2)
        ])
        
        NSLayoutConstraint.activate([
            cameraImage.centerYAnchor.constraint(equalTo: cheapImage.centerYAnchor, constant: 0),
            cameraImage.leadingAnchor.constraint(equalTo: cheapImage.trailingAnchor, constant: 75),
            cameraImage.widthAnchor.constraint(equalToConstant: 26),
            cameraImage.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        NSLayoutConstraint.activate([
            cameraLabel.topAnchor.constraint(equalTo: cameraImage.bottomAnchor, constant: 12),
            cameraLabel.centerXAnchor.constraint(equalTo: cameraImage.centerXAnchor, constant: 8)
        ])
        
        NSLayoutConstraint.activate([
            ozyImage.centerYAnchor.constraint(equalTo: cheapImage.centerYAnchor, constant: 0),
            ozyImage.leadingAnchor.constraint(equalTo: cameraImage.trailingAnchor, constant: 75),
            ozyImage.widthAnchor.constraint(equalToConstant: 26),
            ozyImage.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        NSLayoutConstraint.activate([
            ozyLabel.topAnchor.constraint(equalTo: ozyImage.bottomAnchor, constant: 12),
            ozyLabel.centerXAnchor.constraint(equalTo: ozyImage.centerXAnchor, constant: 2)
        ])
        
        NSLayoutConstraint.activate([
            ssdImage.centerYAnchor.constraint(equalTo: cheapImage.centerYAnchor, constant: 0),
            ssdImage.leadingAnchor.constraint(equalTo: ozyImage.trailingAnchor, constant: 58),
            ssdImage.widthAnchor.constraint(equalToConstant: 17),
            ssdImage.heightAnchor.constraint(equalToConstant: 23)
        ])
        
        NSLayoutConstraint.activate([
            ssdLabel.topAnchor.constraint(equalTo: ssdImage.bottomAnchor, constant: 10),
            ssdLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30)
        ])
        
        NSLayoutConstraint.activate([
            labelSelectClrAndCpct.topAnchor.constraint(equalTo: cheapLabel.bottomAnchor, constant: 25),
            labelSelectClrAndCpct.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30)
        ])
        
        NSLayoutConstraint.activate([
            buttonColorBrown.topAnchor.constraint(equalTo: labelSelectClrAndCpct.bottomAnchor, constant: 10),
            buttonColorBrown.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            buttonColorBrown.widthAnchor.constraint(equalToConstant: 40),
            buttonColorBrown.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        NSLayoutConstraint.activate([
            buttonColorBlackBlue.topAnchor.constraint(equalTo: labelSelectClrAndCpct.bottomAnchor, constant: 10),
            buttonColorBlackBlue.leadingAnchor.constraint(equalTo: buttonColorBrown.trailingAnchor, constant: 10),
            buttonColorBlackBlue.widthAnchor.constraint(equalToConstant: 40),
            buttonColorBlackBlue.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        NSLayoutConstraint.activate([
            button128GB.centerYAnchor.constraint(equalTo: buttonColorBlackBlue.centerYAnchor, constant: 0),
            button128GB.leadingAnchor.constraint(equalTo: buttonColorBlackBlue.trailingAnchor, constant: 40),
            button128GB.widthAnchor.constraint(equalToConstant: 75),
            button128GB.heightAnchor.constraint(equalToConstant: 38)
        ])
        
        NSLayoutConstraint.activate([
            button256GB.centerYAnchor.constraint(equalTo: buttonColorBlackBlue.centerYAnchor, constant: 0),
            button256GB.leadingAnchor.constraint(equalTo: button128GB.trailingAnchor, constant: 10),
            button256GB.widthAnchor.constraint(equalToConstant: 75),
            button256GB.heightAnchor.constraint(equalToConstant: 38)
        ])
        
        NSLayoutConstraint.activate([
            buttonAddToCart.topAnchor.constraint(equalTo: button128GB.bottomAnchor, constant: 31),
            buttonAddToCart.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            buttonAddToCart.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30),
            buttonAddToCart.heightAnchor.constraint(equalToConstant: 55)
        ])
    }
}

// MARK: - UICollectionViewDataSource
extension ProductDetailsViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: idImageCell, for: indexPath) as? ImageCollectionCell else {
            return UICollectionViewCell()
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("hotSalesCell was tapped")
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: imagesCollection.frame.width - 120, height: imagesCollection.frame.height - 20)
    }
}


extension ProductDetailsViewController {
    func scrollViewWillEndDragging(
        _ scrollView: UIScrollView,
        withVelocity velocity: CGPoint,
        targetContentOffset: UnsafeMutablePointer<CGPoint>
    ) {
        targetContentOffset.pointee = scrollView.contentOffset
        var indexes = imagesCollection.indexPathsForVisibleItems
        indexes.sort()
        var index = indexes.first!
        let cell = self.imagesCollection.cellForItem(at: index)!
        if velocity.x > 0 {
            index.row += 1
        } else if velocity.x == 0 {
            let position = self.imagesCollection.contentOffset.x - cell.frame.origin.x
            if position > cell.frame.size.width / 2 {
                index.row += 1
            }
        }
        
        self.imagesCollection.scrollToItem(at: index, at: .centeredHorizontally, animated: true )
        self.imagesCollection.selectItem(at: index, animated: true, scrollPosition: .centeredHorizontally)
    }
}


// MARK: - Here we constraint orangeSeparator under buttons
extension ProductDetailsViewController {
    private func definedSepConstraints() {
        centerSepUnderShop = orangeSeparator.centerXAnchor.constraint(equalTo: buttonShop.centerXAnchor, constant: 0)
        centerSepUnderDetails = orangeSeparator.centerXAnchor.constraint(equalTo: buttonDetails.centerXAnchor, constant: 0)
        centerSepUnderFeatures = orangeSeparator.centerXAnchor.constraint(equalTo: buttonFeatures.centerXAnchor, constant: 0)
        
        widthSepUnderShop = orangeSeparator.widthAnchor.constraint(equalToConstant: 64)
        widthSepUnderDetails = orangeSeparator.widthAnchor.constraint(equalToConstant: 78)
        widthSepUnderFeatures = orangeSeparator.widthAnchor.constraint(equalToConstant: 96)
        
        orangeSeparator.topAnchor.constraint(equalTo: buttonShop.bottomAnchor, constant: 2).isActive = true
        centerSepUnderShop.isActive = true
        widthSepUnderShop.isActive = true
        orangeSeparator.heightAnchor.constraint(equalToConstant: 4).isActive = true
    }
    
    private func sepUnderShop() {
        centerSepUnderFeatures.isActive = false
        centerSepUnderDetails.isActive = false
        centerSepUnderShop.isActive = true
        
        widthSepUnderDetails.isActive = false
        widthSepUnderFeatures.isActive = false
        widthSepUnderShop.isActive = true
        
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 1,
                       options: .curveEaseOut,
                       animations: {
                        self.view.layoutIfNeeded()
        },
                       completion: nil)
    }
    
    
    private func sepUnderDetails() {
        centerSepUnderShop.isActive = false
        centerSepUnderFeatures.isActive = false
        centerSepUnderDetails.isActive = true
        
        widthSepUnderShop.isActive = false
        widthSepUnderFeatures.isActive = false
        widthSepUnderDetails.isActive = true
        
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 1,
                       options: .curveEaseOut,
                       animations: {
                        self.view.layoutIfNeeded()
        },
                       completion: nil)
    }
    
    private func sepUnderFeatures() {
        centerSepUnderShop.isActive = false
        centerSepUnderDetails.isActive = false
        centerSepUnderFeatures.isActive = true
        
        widthSepUnderShop.isActive = false
        widthSepUnderDetails.isActive = false
        widthSepUnderFeatures.isActive = true
        
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 1,
                       options: .curveEaseOut,
                       animations: {
                        self.view.layoutIfNeeded()
        },
                       completion: nil)
    }
    
    
}
