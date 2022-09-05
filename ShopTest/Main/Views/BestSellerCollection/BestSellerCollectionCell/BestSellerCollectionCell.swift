//
//  BestSellerCollectionCell.swift
//  ShopTest
//
//  Created by Ivan White on 04.09.2022.
//

import UIKit


// Кастить ячейку
class BestSellerCollectionCell: UICollectionViewCell {
    
    private let square: UIView = {
        let square = UIView()
        square.translatesAutoresizingMaskIntoConstraints = false
        square.backgroundColor = .yellow
        square.layer.cornerRadius = 5
        return square
    }()
    
    private let topImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "samsungs20ultra")
        image.layer.cornerRadius = 10
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFit
        return image
    }()
//
//    private let isNew: UIView = {
//        let circle = UIView()
//        circle.translatesAutoresizingMaskIntoConstraints = false
//        circle.backgroundColor = UIColor(named: "specialOrange")
//        circle.layer.cornerRadius = 15
//        ///
//        let labelNew = UILabel()
//        labelNew.translatesAutoresizingMaskIntoConstraints = false
//        labelNew.text = "New"
//        labelNew.font = UIFont.systemFont(ofSize: 9, weight: .medium)
//        labelNew.textColor = .white
//        circle.addSubview(labelNew)
//        labelNew.centerXAnchor.constraint(equalTo: circle.centerXAnchor).isActive = true
//        labelNew.centerYAnchor.constraint(equalTo: circle.centerYAnchor).isActive = true
//        ///
//        return circle
//    }()
//
//    private let topLabel: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.text = "Iphone 12"
//        label.textColor = .white
//        label.font = UIFont.systemFont(ofSize: 22, weight: .medium)
//        return label
//    }()
//
//    private let secondLabel: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.text = "Blast past fast"
//        label.textColor = .white
//        label.font = UIFont.systemFont(ofSize: 9, weight: .light)
//        return label
//    }()
//
//    private let buyNowButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.backgroundColor = .white
//        button.setTitle("Buy now!", for: .normal)
//        button.tintColor = .black
//        button.titleLabel?.font = UIFont.systemFont(ofSize: 9, weight: .bold)
//        button.addTarget(self, action: #selector(buyNowButtonFunc), for: .touchUpInside)
//        button.layer.cornerRadius = 5
//        return button
//    }()
    
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

    }
    
    @objc private func buyNowButtonFunc() {
        ///
    }
    
}

extension BestSellerCollectionCell {
    private func setContraints() {
        NSLayoutConstraint.activate([
            square.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            square.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            square.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15),
            square.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 5)
        ])
        
        NSLayoutConstraint.activate([
            topImage.topAnchor.constraint(equalTo: square.topAnchor, constant: 0),
            topImage.leadingAnchor.constraint(equalTo: square.leadingAnchor),
            topImage.trailingAnchor.constraint(equalTo: square.trailingAnchor),
            topImage.bottomAnchor.constraint(equalTo: square.bottomAnchor, constant: -55)
        ])
    }
}
