//
//  BestSellerCollectionView.swift
//  ShopTest
//
//  Created by Ivan White on 04.09.2022.
//

import UIKit

class BestSellerCollectionView: UIView {
    
    private let bestSellerCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 0
        ///
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.bounces = false
        collection.showsHorizontalScrollIndicator = false
        collection.backgroundColor = .red
        return collection
    }()
    
    private let cell = BestSellerCollectionCell()
    
    private let idBestSellerCell = "idBestSellerCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setContraints()
        setDelegates()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(bestSellerCollection)
        bestSellerCollection.register(BestSellerCollectionCell.self, forCellWithReuseIdentifier: idBestSellerCell)
    }
    
    private func setDelegates() {
        bestSellerCollection.delegate = self
        bestSellerCollection.dataSource = self
    }
}

// MARK: - setContrains
extension BestSellerCollectionView {
    private func setContraints() {
        NSLayoutConstraint.activate([
            bestSellerCollection.topAnchor.constraint(equalTo: self.topAnchor),
            bestSellerCollection.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            bestSellerCollection.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            bestSellerCollection.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}

// MARK: - UICollectionViewDataSource
extension BestSellerCollectionView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: idBestSellerCell, for: indexPath) as? BestSellerCollectionCell else {
            return UICollectionViewCell()
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("hotSalesCell was tapped")
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: bestSellerCollection.frame.width / 2, height: bestSellerCollection.frame.height / 2.15)
    }
}

