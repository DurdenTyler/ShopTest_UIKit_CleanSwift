//
//  MainTabBarController.swift
//  ShopTest
//
//  Created by Ivan White on 01.09.2022.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar()
        setupTabBar(roundLayer: customTabBar())
    }
    
    private func tabBar() {
        viewControllers = [
            generateVC(vc: MainViewController(), image: UIImage(systemName: "house")),
            generateVC(vc: CategoriesViewController(), image: UIImage(systemName: "rectangle.stack")),
            generateVC(vc: MyCartViewController(), image: UIImage(systemName: "cart")),
            generateVC(vc: ProfileViewController(), image: UIImage(systemName: "person"))
        ]
    }
    
    private func setupTabBar(roundLayer: CAShapeLayer) {
        // Помещаем созданный слой на tabbar
        tabBar.layer.insertSublayer(roundLayer, at: 0)
        // Задаем ширину элементов
        tabBar.itemWidth = tabBar.bounds.width / 4
        tabBar.itemPositioning = .centered
        roundLayer.fillColor = UIColor(named: "blackBlue")?.cgColor
        tabBar.tintColor = UIColor(named: "specialOrange")
        tabBar.unselectedItemTintColor = .white
        
    }
    
    private func generateVC(vc: UIViewController, image: UIImage?)-> UIViewController {
        vc.tabBarItem.image = image
        return vc
    }
    
    private func customTabBar() -> CAShapeLayer {
        let positionOnX: CGFloat = 10
        let positionOnY: CGFloat = 6
        let width = tabBar.bounds.width - 20
        let height = tabBar.bounds.height + positionOnY + 10
        
        let roundLayer = CAShapeLayer()
        
        let bezierPath = UIBezierPath(roundedRect: CGRect(x: positionOnX, y: tabBar.bounds.minY - positionOnY * 2.2, width: width, height: height), cornerRadius: 25)
        
        roundLayer.path = bezierPath.cgPath
        return roundLayer
    }
}
