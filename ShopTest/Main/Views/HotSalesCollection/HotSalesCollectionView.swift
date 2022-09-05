//
//  HotSalesCollectionView.swift
//  ShopTest
//
//  Created by Ivan White on 04.09.2022.
//

import UIKit

class HotSalesCollectionView: UIView {
    
    private let hotSalesCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        ///
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.bounces = false
        collection.showsHorizontalScrollIndicator = false
        collection.backgroundColor = .none
        return collection
    }()
    
    private let cell = HotSalesCollectionCell()
    
    private let idHotSalesCell = "idHotSalesCell"
    
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
        self.addSubview(hotSalesCollection)
        hotSalesCollection.register(HotSalesCollectionCell.self, forCellWithReuseIdentifier: idHotSalesCell)
    }
    
    private func setDelegates() {
        hotSalesCollection.delegate = self
        hotSalesCollection.dataSource = self
    }
}

// MARK: - setContrains
extension HotSalesCollectionView {
    private func setContraints() {
        NSLayoutConstraint.activate([
            hotSalesCollection.topAnchor.constraint(equalTo: self.topAnchor),
            hotSalesCollection.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            hotSalesCollection.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            hotSalesCollection.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}

// MARK: - UICollectionViewDataSource
extension HotSalesCollectionView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: idHotSalesCell, for: indexPath) as? HotSalesCollectionCell else {
            return UICollectionViewCell()
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("hotSalesCell was tapped")
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: hotSalesCollection.frame.width / 1.35, height: hotSalesCollection.frame.height)
    }
}
