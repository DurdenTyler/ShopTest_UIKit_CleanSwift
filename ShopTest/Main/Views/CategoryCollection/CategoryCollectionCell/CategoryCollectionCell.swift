//
//  CategoryCollectionCell.swift
//  ShopTest
//
//  Created by Ivan White on 01.09.2022.
//

import UIKit

class CategoryCollectionCell: UICollectionViewCell {
    
    private let circle: UIView = {
        let circle = UIView()
        circle.translatesAutoresizingMaskIntoConstraints = false
        circle.backgroundColor = .white
        circle.layer.cornerRadius = 40
        return circle
    }()
    
    private let categoryImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "Phone")?.withTintColor(.lightGray)
        image.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        return image
    }()
    
    private let labelNameCategory: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Phones"
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = .black
        return label
    }()
    
    override var isSelected: Bool {
        didSet {
            if self.isSelected {
                self.circle.backgroundColor = UIColor(named: "specialOrange")
                self.categoryImage.image = UIImage(named: "Phone")?.withTintColor(.white)
                self.labelNameCategory.textColor = UIColor(named: "specialOrange")

            } else {
                self.circle.backgroundColor = .white
                self.categoryImage.image = UIImage(named: "Phone")?.withTintColor(.lightGray)
                self.labelNameCategory.textColor = .black
            }
        }
    }
    
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
            circle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            circle.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            circle.heightAnchor.constraint(equalToConstant: 80)
        ])
        
        NSLayoutConstraint.activate([
            categoryImage.centerYAnchor.constraint(equalTo: circle.centerYAnchor),
            categoryImage.centerXAnchor.constraint(equalTo: circle.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            labelNameCategory.centerXAnchor.constraint(equalTo: circle.centerXAnchor),
            labelNameCategory.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5)
        ])
    }
}
