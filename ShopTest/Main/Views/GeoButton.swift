//
//  GeoButton.swift
//  ShopTest
//
//  Created by Ivan White on 01.09.2022.
//

import UIKit


class GeoButton: UIButton {
    
    private let geoIcon: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(systemName: "location")
        image.tintColor = UIColor(named: "specialOrange")
        return image
    }()
    
    private let labelCity: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Moskow"
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    
    private let chevronDown: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(systemName: "chevron.down")
        image.tintColor = .gray
        return image
    }()
    
    override var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                geoIcon.alpha = 0.5
                labelCity.alpha = 0.5
                chevronDown.alpha = 0.5
            } else {
                geoIcon.alpha = 1
                labelCity.alpha = 1
                chevronDown.alpha = 1
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setContrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(geoIcon)
        self.addSubview(labelCity)
        self.addSubview(chevronDown)
    }
    
}

// MARK: - setContrains
extension GeoButton {
    private func setContrains() {
        
        NSLayoutConstraint.activate([
            geoIcon.topAnchor.constraint(equalTo: self.topAnchor),
            geoIcon.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            geoIcon.widthAnchor.constraint(equalToConstant: 20),
            geoIcon.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        NSLayoutConstraint.activate([
            labelCity.topAnchor.constraint(equalTo: self.topAnchor),
            labelCity.leadingAnchor.constraint(equalTo: geoIcon.trailingAnchor, constant: 11)
        ])
        
        NSLayoutConstraint.activate([
            chevronDown.topAnchor.constraint(equalTo: self.topAnchor, constant: 2.5),
            chevronDown.leadingAnchor.constraint(equalTo: labelCity.trailingAnchor, constant: 11),
            chevronDown.widthAnchor.constraint(equalToConstant: 18),
            chevronDown.heightAnchor.constraint(equalToConstant: 18)
        ])
    }
}
