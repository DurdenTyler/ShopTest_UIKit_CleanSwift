//
//  HotSalesCollectionCell.swift
//  ShopTest
//
//  Created by Ivan White on 04.09.2022.
//

import UIKit

class HotSalesCollectionCell: UICollectionViewCell {
    
    private let square: UIView = {
        let square = UIView()
        square.translatesAutoresizingMaskIntoConstraints = false
        return square
    }()
    
    private let topImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "iphones")
        image.layer.cornerRadius = 10
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private let isNew: UIView = {
        let circle = UIView()
        circle.translatesAutoresizingMaskIntoConstraints = false
        circle.backgroundColor = UIColor(named: "specialOrange")
        circle.layer.cornerRadius = 15
        ///
        let labelNew = UILabel()
        labelNew.translatesAutoresizingMaskIntoConstraints = false
        labelNew.text = "New"
        labelNew.font = UIFont.systemFont(ofSize: 9, weight: .medium)
        labelNew.textColor = .white
        circle.addSubview(labelNew)
        labelNew.centerXAnchor.constraint(equalTo: circle.centerXAnchor).isActive = true
        labelNew.centerYAnchor.constraint(equalTo: circle.centerYAnchor).isActive = true
        ///
        return circle
    }()
    
    private let topLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Iphone 12"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 28, weight: .semibold)
        return label
    }()
    
    private let secondLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Blast past fast"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 13, weight: .light)
        return label
    }()
    
    private let buyNowButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        button.setTitle("Buy now!", for: .normal)
        button.tintColor = .black
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        button.addTarget(self, action: #selector(buyNowButtonFunc), for: .touchUpInside)
        button.layer.cornerRadius = 5
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setContraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        self.addSubview(square)
        self.addSubview(topImage)
        self.addSubview(isNew)
        self.addSubview(topLabel)
        self.addSubview(secondLabel)
        self.addSubview(buyNowButton)
    }
    
    @objc private func buyNowButtonFunc() {
        ///
    }
    
}

extension HotSalesCollectionCell {
    private func setContraints() {
        NSLayoutConstraint.activate([
            square.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            square.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            square.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            square.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5)
        ])
        
        NSLayoutConstraint.activate([
            topImage.topAnchor.constraint(equalTo: square.topAnchor, constant: 5),
            topImage.leadingAnchor.constraint(equalTo: square.leadingAnchor, constant: 15),
            topImage.trailingAnchor.constraint(equalTo: square.trailingAnchor, constant: -15),
            topImage.bottomAnchor.constraint(equalTo: square.bottomAnchor, constant: -5)
        ])
        
        NSLayoutConstraint.activate([
            isNew.topAnchor.constraint(equalTo: topImage.topAnchor, constant: 10),
            isNew.leadingAnchor.constraint(equalTo: topImage.leadingAnchor, constant: 20),
            isNew.heightAnchor.constraint(equalToConstant: 30),
            isNew.widthAnchor.constraint(equalToConstant: 30)
        ])
        
        NSLayoutConstraint.activate([
            topLabel.topAnchor.constraint(equalTo: isNew.bottomAnchor, constant: 17),
            topLabel.leadingAnchor.constraint(equalTo: topImage.leadingAnchor, constant: 20)
        ])
        
        NSLayoutConstraint.activate([
            secondLabel.topAnchor.constraint(equalTo: topLabel.bottomAnchor, constant: 8),
            secondLabel.leadingAnchor.constraint(equalTo: topImage.leadingAnchor, constant: 20)
        ])
        
        NSLayoutConstraint.activate([
            buyNowButton.topAnchor.constraint(equalTo: secondLabel.bottomAnchor, constant: 30),
            buyNowButton.leadingAnchor.constraint(equalTo: topImage.leadingAnchor, constant: 20),
            buyNowButton.heightAnchor.constraint(equalToConstant: 25),
            buyNowButton.widthAnchor.constraint(equalToConstant: 130)
        ])
    }
}
