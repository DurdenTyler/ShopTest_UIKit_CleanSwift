//
//  FilterOptionsView.swift
//  ShopTest
//
//  Created by Ivan White on 09.09.2022.
//

import UIKit

protocol PopOverDelegate: AnyObject {
    func tapOnBrandButton()
    func tapOnPriceButton()
    func tapOnSizeButton()
    func dismissFilterOptions()
}

class FilterOptionsView: UIView {
    
    weak var popOverDelegate: PopOverDelegate?
    
    private let buttonClose: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(named: "blackBlue")
        button.layer.cornerRadius = 10
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(buttonCloseFunc), for: .touchUpInside)
        return button
    }()
    
    private let labelFilter: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Filter options"
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.textAlignment = .center
        label.textColor = UIColor(named: "blackBlue")
        return label
    }()
    
    private let buttonDone: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(named: "specialOrange")
        button.layer.cornerRadius = 10
        button.setTitle("Done", for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(buttonDoneFunc), for: .touchUpInside)
        return button
    }()
    
    private let labelBrand: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Brand"
        label.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        label.textAlignment = .center
        label.textColor = UIColor(named: "blackBlue")
        return label
    }()
    
    private let labelPrice: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Price"
        label.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        label.textAlignment = .center
        label.textColor = UIColor(named: "blackBlue")
        return label
    }()
    
    private let labelSize: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Size"
        label.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        label.textAlignment = .center
        label.textColor = UIColor(named: "blackBlue")
        return label
    }()
    
    let buttonBrand: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(named: "backgroundColor")
        button.layer.cornerRadius = 5
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.borderWidth = 1
        button.addTarget(self, action: #selector(buttonBrandFunc), for: .touchUpInside)
        
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(systemName: "chevron.backward")
        image.tintColor = .lightGray
        button.addSubview(image)
        image.trailingAnchor.constraint(equalTo: button.trailingAnchor, constant: -10).isActive = true
        image.centerYAnchor.constraint(equalTo: button.centerYAnchor, constant: 0).isActive = true
        
        return button
    }()
    
    let titleBrandOnButton: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.text = "Samsung"
        title.font = UIFont.systemFont(ofSize: 19, weight: .medium)
        title.textColor = .black
        return title
    }()
    
    let buttonPrice: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(named: "backgroundColor")
        button.layer.cornerRadius = 5
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.borderWidth = 1
        button.addTarget(self, action: #selector(buttonPriceFunc), for: .touchUpInside)
        
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(systemName: "chevron.backward")
        image.tintColor = .lightGray
        button.addSubview(image)
        image.trailingAnchor.constraint(equalTo: button.trailingAnchor, constant: -10).isActive = true
        image.centerYAnchor.constraint(equalTo: button.centerYAnchor, constant: 0).isActive = true
        
        return button
    }()
    
    let titlePriceOnButton: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.text = "$300 - $500"
        title.font = UIFont.systemFont(ofSize: 19, weight: .medium)
        title.textColor = .black
        return title
    }()
    
    let buttonSize: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(named: "backgroundColor")
        button.layer.cornerRadius = 5
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.borderWidth = 1
        button.addTarget(self, action: #selector(buttonSizeFunc), for: .touchUpInside)
        
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(systemName: "chevron.backward")
        image.tintColor = .lightGray
        button.addSubview(image)
        image.trailingAnchor.constraint(equalTo: button.trailingAnchor, constant: -10).isActive = true
        image.centerYAnchor.constraint(equalTo: button.centerYAnchor, constant: 0).isActive = true
        
        return button
    }()
    
    let titleSizeOnButton: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.text = "4.5 to 5.5 inches"
        title.font = UIFont.systemFont(ofSize: 19, weight: .medium)
        title.textColor = .black
        return title
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .white
        self.layer.cornerRadius = 25
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.3
        self.layer.shadowRadius = 5
        self.layer.shadowOffset = .zero
        self.addSubview(buttonClose)
        self.addSubview(labelFilter)
        self.addSubview(buttonDone)
        self.addSubview(labelBrand)
        self.addSubview(labelPrice)
        self.addSubview(labelSize)
        self.addSubview(buttonBrand)
        self.addSubview(titleBrandOnButton)
        self.addSubview(buttonPrice)
        self.addSubview(titlePriceOnButton)
        self.addSubview(buttonSize)
        self.addSubview(titleSizeOnButton)
    }
    
    @objc private func buttonCloseFunc() {
        popOverDelegate?.dismissFilterOptions()
    }
    
    @objc private func buttonDoneFunc() {
        print("button done was tapped")
    }
    
    @objc private func buttonBrandFunc() {
        print("button brand was tapped")
        popOverDelegate?.tapOnBrandButton()
    }
    
    @objc private func buttonPriceFunc() {
        print("button price was tapped")
        popOverDelegate?.tapOnPriceButton()
    }
    
    @objc private func buttonSizeFunc() {
        print("button size was tapped")
        popOverDelegate?.tapOnSizeButton()
    }
    
}

// MARK: Set Constraints here

extension FilterOptionsView {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            buttonClose.topAnchor.constraint(equalTo: self.topAnchor, constant: 15),
            buttonClose.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            buttonClose.widthAnchor.constraint(equalToConstant: 35),
            buttonClose.heightAnchor.constraint(equalToConstant: 35)
        ])
        
        NSLayoutConstraint.activate([
            labelFilter.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: -10),
            labelFilter.centerYAnchor.constraint(equalTo: buttonClose.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            buttonDone.centerYAnchor.constraint(equalTo: buttonClose.centerYAnchor),
            buttonDone.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            buttonDone.widthAnchor.constraint(equalToConstant: 80)
        ])
        
        NSLayoutConstraint.activate([
            labelBrand.topAnchor.constraint(equalTo: buttonClose.bottomAnchor, constant: 30),
            labelBrand.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40)
        ])
        
        NSLayoutConstraint.activate([
            buttonBrand.centerYAnchor.constraint(equalTo: labelBrand.centerYAnchor, constant: 0),
            buttonBrand.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
            buttonBrand.heightAnchor.constraint(equalToConstant: 35),
            buttonBrand.widthAnchor.constraint(equalToConstant: 200)
        ])
        
        NSLayoutConstraint.activate([
            titleBrandOnButton.centerXAnchor.constraint(equalTo: buttonBrand.centerXAnchor, constant: -5),
            titleBrandOnButton.centerYAnchor.constraint(equalTo: buttonBrand.centerYAnchor, constant: 0)
        ])
        
        NSLayoutConstraint.activate([
            labelPrice.topAnchor.constraint(equalTo: labelBrand.bottomAnchor, constant: 20),
            labelPrice.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40)
        ])
        
        NSLayoutConstraint.activate([
            buttonPrice.centerYAnchor.constraint(equalTo: labelPrice.centerYAnchor, constant: 0),
            buttonPrice.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
            buttonPrice.heightAnchor.constraint(equalToConstant: 35),
            buttonPrice.widthAnchor.constraint(equalToConstant: 200)
        ])
        
        NSLayoutConstraint.activate([
            titlePriceOnButton.centerXAnchor.constraint(equalTo: buttonPrice.centerXAnchor, constant: -5),
            titlePriceOnButton.centerYAnchor.constraint(equalTo: buttonPrice.centerYAnchor, constant: 0)
        ])
        
        NSLayoutConstraint.activate([
            labelSize.topAnchor.constraint(equalTo: labelPrice.bottomAnchor, constant: 20),
            labelSize.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40)
        ])
        
        NSLayoutConstraint.activate([
            buttonSize.centerYAnchor.constraint(equalTo: labelSize.centerYAnchor, constant: 0),
            buttonSize.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
            buttonSize.heightAnchor.constraint(equalToConstant: 35),
            buttonSize.widthAnchor.constraint(equalToConstant: 200)
        ])
        
        NSLayoutConstraint.activate([
            titleSizeOnButton.centerXAnchor.constraint(equalTo: buttonSize.centerXAnchor, constant: -5),
            titleSizeOnButton.centerYAnchor.constraint(equalTo: buttonSize.centerYAnchor, constant: 0)
        ])
    }
}
