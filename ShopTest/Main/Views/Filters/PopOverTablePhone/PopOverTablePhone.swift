//
//  PopOverCollectionView.swift
//  ShopTest
//
//  Created by Ivan White on 12.09.2022.
//

import UIKit

protocol PopOverTableViewProtocol: AnyObject {
    func selectItem(text: String)
}

class PopOverTablePhone: UITableView {
    
    weak var mainCellDelegate: PopOverTableViewProtocol?
    
    private var cellConfiguireArray = ["Samsung", "Apple", "Huawei", "Xiaomi", "Meizu", "Nokia", "Motorola"]
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        self.delegate = self
        self.dataSource = self
        self.backgroundColor = .none
        self.bounces = false
        self.showsVerticalScrollIndicator = false
        self.translatesAutoresizingMaskIntoConstraints = false
        self.register(PopOverTablePhoneCell.self, forCellReuseIdentifier: PopOverTablePhoneCell().popOverCellId)
    }
}

// MARK: - UICollectionViewDataSource
extension PopOverTablePhone: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cellConfiguireArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PopOverTablePhoneCell().popOverCellId, for: indexPath) as? PopOverTablePhoneCell else {
            return UITableViewCell()
        }
        let text = cellConfiguireArray[indexPath.row]
        cell.setConfigure(text: text)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selectItem on tableView is work")
        let text = cellConfiguireArray[indexPath.row]
        mainCellDelegate?.selectItem(text: text)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    
}
