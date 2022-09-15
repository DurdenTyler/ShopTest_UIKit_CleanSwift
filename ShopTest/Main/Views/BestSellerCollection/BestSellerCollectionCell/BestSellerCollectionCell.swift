//
//  BestSellerCollectionCell.swift
//  ShopTest
//
//  Created by Ivan White on 04.09.2022.
//

import UIKit

class BestSellerCollectionCell: UICollectionViewCell {
    
    private let square: UIView = {
        let square = UIView()
        square.translatesAutoresizingMaskIntoConstraints = false
        square.backgroundColor = .white
        square.layer.cornerRadius = 10
        return square
    }()
    
    private let topImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "samsungs20ultra")
        image.layer.cornerRadius = 10
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        return image
    }()

    private let addToFavorite: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        button.layer.cornerRadius = 16
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.5
        button.layer.shadowRadius = 1.5
        button.layer.shadowOffset = .zero
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.tintColor = UIColor(named: "specialOrange")
        button.addTarget(self, action: #selector(addToFavoriteFunc), for: .touchUpInside)
        return button
    }()

    private let newPrice: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "$1,047"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return label
    }()

    private let oldPrice: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "$1,500"
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        return label
    }()
    
    private let line: UIView = {
        let line = UIView()
        line.translatesAutoresizingMaskIntoConstraints = false
        line.backgroundColor = .lightGray
        return line
    }()
    
    private let title: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Samsung Galaxy S20 Ultra"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 10, weight: .light)
        return label
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
        self.addSubview(addToFavorite)
        self.addSubview(newPrice)
        self.addSubview(oldPrice)
        self.addSubview(line)
        self.addSubview(title)

    }
    
    @objc private func addToFavoriteFunc() {
        ///
    }
    
}

extension BestSellerCollectionCell {
    private func setContraints() {
        NSLayoutConstraint.activate([
            square.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            square.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            square.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15),
            square.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)
        ])
        
        NSLayoutConstraint.activate([
            topImage.topAnchor.constraint(equalTo: square.topAnchor, constant: 0),
            topImage.leadingAnchor.constraint(equalTo: square.leadingAnchor),
            topImage.trailingAnchor.constraint(equalTo: square.trailingAnchor),
            topImage.bottomAnchor.constraint(equalTo: square.bottomAnchor, constant: -45)
        ])
        
        NSLayoutConstraint.activate([
            addToFavorite.topAnchor.constraint(equalTo: topImage.topAnchor, constant: 13),
            addToFavorite.trailingAnchor.constraint(equalTo: topImage.trailingAnchor, constant: -13),
            addToFavorite.heightAnchor.constraint(equalToConstant: 32),
            addToFavorite.widthAnchor.constraint(equalToConstant: 32)
        ])
        
        NSLayoutConstraint.activate([
            newPrice.topAnchor.constraint(equalTo: topImage.bottomAnchor, constant: 0),
            newPrice.leadingAnchor.constraint(equalTo: square.leadingAnchor, constant: 15)
        ])
        
        NSLayoutConstraint.activate([
            oldPrice.bottomAnchor.constraint(equalTo: newPrice.bottomAnchor, constant: -2),
            oldPrice.leadingAnchor.constraint(equalTo: newPrice.trailingAnchor, constant: 5)
        ])
        
        NSLayoutConstraint.activate([
            line.heightAnchor.constraint(equalToConstant: 1),
            line.widthAnchor.constraint(equalToConstant: 40),
            line.centerYAnchor.constraint(equalTo: oldPrice.centerYAnchor),
            line.centerXAnchor.constraint(equalTo: oldPrice.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: newPrice.bottomAnchor, constant: 6),
            title.leadingAnchor.constraint(equalTo: square.leadingAnchor, constant: 15),
            title.bottomAnchor.constraint(equalTo: square.bottomAnchor, constant: -10)
        ])
    }
}
