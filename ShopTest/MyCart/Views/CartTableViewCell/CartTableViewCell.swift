//
//  CartTableViewCell.swift
//  ShopTest
//
//  Created by Ivan White on 28.09.2022.
//

import UIKit

class CartTableViewCell: UITableViewCell {
    
    private let cell: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .none
        view.layer.cornerRadius = 5
        return view
    }()
    
    private let mainImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "productDetail")
        image.layer.cornerRadius = 10
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private let labelTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Galaxy Note 20 Ultra"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        label.setLineHeight(lineHeight: 3)
        return label
    }()
    
    private let labelPrice: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "$3000.00"
        label.textColor = UIColor(named: "specialOrange")
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        return label
    }()
    
    private let rhombus: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .gray
        view.layer.opacity = 0.4
        view.layer.cornerRadius = 15
        return view
    }()
    
    private let buttonPlus: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(buttonPlusFunc), for: .touchUpInside)
        return button
    }()
    
    private let buttonMinus: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "minus"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(buttonMinusFunc), for: .touchUpInside)
        return button
    }()
    
    private let labelCount: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "2"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        return label
    }()
    
    private let buttonDelete: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "trash"), for: .normal)
        button.tintColor = .gray
        button.layer.opacity = 0.4
        button.addTarget(self, action: #selector(buttonDeleteFunc), for: .touchUpInside)
        return button
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setContraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        backgroundColor = .clear
        selectionStyle = .none /// чтоб ячейка ни как не выделялась
        self.addSubview(cell)
        self.addSubview(mainImage)
        self.addSubview(labelTitle)
        self.addSubview(labelPrice)
        self.addSubview(rhombus)
        contentView.addSubview(buttonPlus)
        contentView.addSubview(buttonMinus)
        self.addSubview(labelCount)
        contentView.addSubview(buttonDelete)
        
    }
    
    @objc private func buttonPlusFunc() {
        print("buttonPlus was tapped")
    }
    
    @objc private func buttonMinusFunc() {
        print("buttonMinus was tapped")
    }
    
    @objc private func buttonDeleteFunc() {
        print("buttonDelete was tapped")
    }
    
}

// MARK: Set Constraints here
extension CartTableViewCell {
    private func setContraints() {
        NSLayoutConstraint.activate([
            cell.topAnchor.constraint(equalTo: self.topAnchor, constant: 3),
            cell.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 3),
            cell.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -3),
            cell.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -3)
        ])
        
        NSLayoutConstraint.activate([
            mainImage.topAnchor.constraint(equalTo: cell.topAnchor, constant: 11),
            mainImage.leadingAnchor.constraint(equalTo: cell.leadingAnchor, constant: 14),
            mainImage.widthAnchor.constraint(equalToConstant: 100),
            mainImage.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        NSLayoutConstraint.activate([
            labelTitle.topAnchor.constraint(equalTo: cell.topAnchor, constant: 15),
            labelTitle.leadingAnchor.constraint(equalTo: mainImage.trailingAnchor, constant: 13),
            labelTitle.widthAnchor.constraint(equalToConstant: 120)
        ])
        
        NSLayoutConstraint.activate([
            labelPrice.topAnchor.constraint(equalTo: labelTitle.bottomAnchor, constant: 8),
            labelPrice.leadingAnchor.constraint(equalTo: mainImage.trailingAnchor, constant: 13)
        ])
        
        NSLayoutConstraint.activate([
            rhombus.topAnchor.constraint(equalTo: labelTitle.topAnchor, constant: 3),
            rhombus.bottomAnchor.constraint(equalTo: labelPrice.bottomAnchor, constant: -1),
            rhombus.leadingAnchor.constraint(equalTo: labelTitle.trailingAnchor, constant: 30),
            rhombus.widthAnchor.constraint(equalToConstant: 30)
        ])
        
        NSLayoutConstraint.activate([
            buttonPlus.bottomAnchor.constraint(equalTo: rhombus.bottomAnchor, constant: -5),
            buttonPlus.centerXAnchor.constraint(equalTo: rhombus.centerXAnchor, constant: 0)
        ])
        
        NSLayoutConstraint.activate([
            buttonMinus.topAnchor.constraint(equalTo: rhombus.topAnchor, constant: 5),
            buttonMinus.centerXAnchor.constraint(equalTo: rhombus.centerXAnchor, constant: 0)
        ])
        
        NSLayoutConstraint.activate([
            labelCount.centerXAnchor.constraint(equalTo: rhombus.centerXAnchor, constant: 0),
            labelCount.centerYAnchor.constraint(equalTo: rhombus.centerYAnchor, constant: -2)
        ])
        
        NSLayoutConstraint.activate([
            buttonDelete.centerYAnchor.constraint(equalTo: rhombus.centerYAnchor, constant: 0),
            buttonDelete.leadingAnchor.constraint(equalTo: rhombus.trailingAnchor, constant: 25)
        ])
    }
}


extension UILabel {
    
    func setLineHeight(lineHeight: CGFloat) {
        guard let text = self.text else { return }
        
        let attributeString = NSMutableAttributedString(string: text)
        let style = NSMutableParagraphStyle()
        
        style.lineSpacing = lineHeight
        attributeString.addAttribute(
            NSAttributedString.Key.paragraphStyle,
            value: style,
            range: NSMakeRange(0, attributeString.length))
        
        self.attributedText = attributeString
    }

}
