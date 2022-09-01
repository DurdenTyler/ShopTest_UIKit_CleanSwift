//
//  CategoryCollectionCell.swift
//  ShopTest
//
//  Created by Ivan White on 01.09.2022.
//

import UIKit

class CategoryCollectionCell: UICollectionViewCell{
    
    private let circle: UIView = {
        let circle = UIView()
        circle.translatesAutoresizingMaskIntoConstraints = false
        circle.backgroundColor = UIColor(named: "specialOrange")
        circle.layer.cornerRadius = 40
        return circle
    }()
    
    private let categoryImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "Phone")
        image.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        return image
    }()
    
    private let labelNameCategory: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Phones"
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = UIColor(named: "specialOrange")
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
        self.addSubview(circle)
        self.addSubview(categoryImage)
        self.addSubview(labelNameCategory)
    }
    
}

extension CategoryCollectionCell {
    private func setContraints() {
        NSLayoutConstraint.activate([
            circle.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            circle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            circle.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            circle.heightAnchor.constraint(equalToConstant: 80)
        ])
        
        NSLayoutConstraint.activate([
            categoryImage.centerYAnchor.constraint(equalTo: circle.centerYAnchor),
            categoryImage.centerXAnchor.constraint(equalTo: circle.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            labelNameCategory.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            labelNameCategory.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5)
        ])
    }
}
