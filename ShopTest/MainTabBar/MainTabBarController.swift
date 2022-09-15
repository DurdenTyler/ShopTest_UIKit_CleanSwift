//
//  MainTabBarController.swift
//  ShopTest
//
//  Created by Ivan White on 01.09.2022.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    private let filtersOptionsView = FilterOptionsView()
    
    private var leadingAnchor: NSLayoutConstraint!
    private var trailingAnchor: NSLayoutConstraint!
    private var bottomAnchor: NSLayoutConstraint!
    private var minTopAnchor: NSLayoutConstraint!
    private var maxTopAnchor: NSLayoutConstraint!
    
    private let mainVC = MainViewController()
    
    private var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar()
        setupTabBar(roundLayer: customTabBar())
        setDelegates()
        setView()
    }
    
    private func tabBar() {
        viewControllers = [
            generateVC(vc: mainVC, image: UIImage(systemName: "house")),
            generateVC(vc: CategoriesViewController(), image: UIImage(systemName: "rectangle.stack")),
            generateVC(vc: MyCartViewController(), image: UIImage(systemName: "cart")),
            generateVC(vc: ProfileViewController(), image: UIImage(systemName: "person"))
        ]
    }
    
    private func setupTabBar(roundLayer: CAShapeLayer) {
        tabBar.layer.insertSublayer(roundLayer, at: 0)
        tabBar.itemWidth = tabBar.bounds.width / 4
        tabBar.itemPositioning = .centered
        roundLayer.fillColor = UIColor(named: "blackBlue")?.cgColor
        tabBar.tintColor = UIColor(named: "specialOrange")
        tabBar.unselectedItemTintColor = .white
        
    }
    
    private func setDelegates() {
        filtersOptionsView.popOverDelegate = self
        mainVC.mainDelegate = self
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
    
    private func setView() {
        view.insertSubview(filtersOptionsView, aboveSubview: tabBar)
        filtersOptionsView.isHidden = true
        
        leadingAnchor =  filtersOptionsView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        trailingAnchor = filtersOptionsView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        bottomAnchor = filtersOptionsView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        minTopAnchor = filtersOptionsView.topAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        maxTopAnchor = filtersOptionsView.topAnchor.constraint(equalTo: view.bottomAnchor, constant: -255)
        
        leadingAnchor.isActive = true
        trailingAnchor.isActive = true
        bottomAnchor.isActive = false
        minTopAnchor.isActive = true
        maxTopAnchor.isActive = false
        
    }
    
    private func setupFiltersOptionsView() {
        filtersOptionsView.isHidden = false

        leadingAnchor.isActive = true
        trailingAnchor.isActive = true
        bottomAnchor.isActive = true
        minTopAnchor.isActive = false
        maxTopAnchor.isActive = true
        
        UIView.animate(withDuration: 1,
                       delay: 0,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 1,
                       options: .curveEaseOut,
                       animations: {
            self.view.layoutIfNeeded()
        },
                       completion: nil)
    }
    
    private func hideFiltersOptionsView() {
        
        leadingAnchor.isActive = true
        trailingAnchor.isActive = true
        bottomAnchor.isActive = false
        minTopAnchor.isActive = true
        maxTopAnchor.isActive = false
        
        UIView.animate(withDuration: 1,
                       delay: 0,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 1,
                       options: .curveEaseInOut,
                       animations: {
            self.view.layoutIfNeeded()
        },
                       completion: nil)
    }
    
    let popOverPhoneVC = PopOverPhoneViewController()
    let popOverPriceVC = PopOverPriceViewController()
    let popOverSizeVC = PopOverSizeViewController()
}


// MARK: PopoverDelegate
extension MainTabBarController: PopOverDelegate {
 
    func tapOnBrandButton() {
        popOverPhoneVC.modalPresentationStyle = .popover
        popOverPhoneVC.preferredContentSize = CGSize(width: 206, height: 150)
        popOverPhoneVC.titleChangeDelegate = self
        
        guard let presentVC = popOverPhoneVC.popoverPresentationController else { return }
        presentVC.delegate = self
        presentVC.sourceView = filtersOptionsView.buttonBrand
        presentVC.permittedArrowDirections = []
        presentVC.sourceRect = CGRect(x: filtersOptionsView.buttonBrand.bounds.midX - 30, y: filtersOptionsView.buttonBrand.bounds.minY - 40, width: 0, height: 0)
        present(popOverPhoneVC, animated: true)
    }
    
    func tapOnPriceButton() {
        popOverPriceVC.modalPresentationStyle = .popover
        popOverPriceVC.preferredContentSize = CGSize(width: 206, height: 120)
        popOverPriceVC.titleChangeDelegate = self
        
        guard let presentVC = popOverPriceVC.popoverPresentationController else { return }
        presentVC.delegate = self
        presentVC.sourceView = filtersOptionsView.buttonPrice
        presentVC.permittedArrowDirections = []
        presentVC.sourceRect = CGRect(x: filtersOptionsView.buttonPrice.bounds.midX - 30, y: filtersOptionsView.buttonPrice.bounds.minY - 25, width: 0, height: 0)
        present(popOverPriceVC, animated: true)
    }
    
    func tapOnSizeButton() {
        popOverSizeVC.modalPresentationStyle = .popover
        popOverSizeVC.preferredContentSize = CGSize(width: 206, height: 120)
        popOverSizeVC.titleChangeDelegate = self
        
        guard let presentVC = popOverSizeVC.popoverPresentationController else { return }
        presentVC.delegate = self
        presentVC.sourceView = filtersOptionsView.buttonSize
        presentVC.permittedArrowDirections = []
        presentVC.sourceRect = CGRect(x: filtersOptionsView.buttonSize.bounds.midX - 30, y: filtersOptionsView.buttonSize.bounds.minY + 10, width: 0, height: 0)
        present(popOverSizeVC, animated: true)
    }
    
    func dismissFilterOptions() {
        hideFiltersOptionsView()
    }
}

extension MainTabBarController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        .none
    }
}

extension MainTabBarController: PopOverVCProtocol, PopOverPriceVCProtocol, PopOverSizeVCProtocol {
    func changeTitle(text: String) {
        filtersOptionsView.titleBrandOnButton.text = text
        popOverPhoneVC.dismiss(animated: true)
    }
    
    func changePrice(text: String) {
        filtersOptionsView.titlePriceOnButton.text = text
        popOverPriceVC.dismiss(animated: true)
    }
    
    func changeSize(text: String) {
        filtersOptionsView.titleSizeOnButton.text = text
        popOverSizeVC.dismiss(animated: true)
    }
}

extension MainTabBarController: MainProtocol {
    func clickOnFilter() {
        setupFiltersOptionsView()
    }
}
