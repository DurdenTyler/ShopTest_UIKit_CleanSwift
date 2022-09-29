//
//  ImageCollectionCell.swift
//  ShopTest
//
//  Created by Ivan White on 16.09.2022.
//

import UIKit

class ImageCollectionCell: UICollectionViewCell {
    
    private let topImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "productDetail")
        image.layer.cornerRadius = 10
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        return image
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
        self.backgroundColor = .white
        self.layer.cornerRadius = 20
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.15
        self.layer.shadowRadius = 3
        self.layer.shadowOffset = .zero
        self.addSubview(topImage)

    }
    
    override var isSelected: Bool {
        didSet {
            if self.isSelected {
                self.transform = CGAffineTransform(scaleX: 1, y: 1)

            } else {
                self.transform = CGAffineTransform(scaleX: 0.85, y: 0.85)
            }
        }
    }
    
}

extension ImageCollectionCell {
    private func setContraints() {
        NSLayoutConstraint.activate([
            topImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            topImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            topImage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            topImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)
        ])
    }
}
