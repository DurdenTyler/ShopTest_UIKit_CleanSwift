//
//  CategoryCollection.swift
//  ShopTest
//
//  Created by Ivan White on 04.09.2022.
//

import UIKit

class CategoryCollectionView: UIView {
    
    private let categoryCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        ///
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.bounces = false
        collection.showsHorizontalScrollIndicator = false
        collection.backgroundColor = .none
        return collection
    }()
    
    private let cell = CategoryCollectionCell()
    
    private let idCategoryCell = "idCategoryCell"
    
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
        self.addSubview(categoryCollection)
        categoryCollection.register(CategoryCollectionCell.self, forCellWithReuseIdentifier: idCategoryCell)
    }
    
    private func setDelegates() {
        categoryCollection.delegate = self
        categoryCollection.dataSource = self
    }
}

// MARK: - setContrains
extension CategoryCollectionView {
    private func setContraints() {
        NSLayoutConstraint.activate([
            categoryCollection.topAnchor.constraint(equalTo: self.topAnchor),
            categoryCollection.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            categoryCollection.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            categoryCollection.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
   }
}

// MARK: - UICollectionViewDataSource
extension CategoryCollectionView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
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
        print("TCategoryCell was tapped")
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: categoryCollection.frame.width / 4.05, height: categoryCollection.frame.height)
    }
}
