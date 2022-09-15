//
//  PopOverTableSizeCell.swift
//  ShopTest
//
//  Created by Ivan White on 14.09.2022.
//

import UIKit


class PopOverTableSizeCell: UITableViewCell {
    
    private let title: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 19, weight: .medium)
        return label
    }()
    
    public let popOverCellId = "mainCellId"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        backgroundColor = .white
        addSubview(title)
    }
    
    public func setConfigure(text: String) {
        title.text = text
    }
}


extension PopOverTableSizeCell {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            title.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            title.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
}
