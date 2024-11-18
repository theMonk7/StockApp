//
//  RootTabBarController.swift
//  StockPage
//
//  Created by Utkarsh Raj on 17/11/24.
//

import UIKit

class RootTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Set Up Tab Bar Controller
        setupTabBar()
    }
    
    // MARK: - Private methods
    
    private func setupTabBar() {
        let watchNavController = makeTabChildControllerWith(.watchlist)
        let orderNavController = makeTabChildControllerWith(.orders)
        let portfolioNavController = makeTabChildControllerWith(.portfolio)
        let fundNavController = makeTabChildControllerWith(.funds)
        let investNavController = makeTabChildControllerWith(.invest)
        // Set the view controllers of the tab bar
        self.viewControllers = [watchNavController, orderNavController, portfolioNavController, fundNavController, investNavController]

        tabBar.tintColor = UIColor.tabTintColor
        tabBar.unselectedItemTintColor = .gray
        tabBar.backgroundColor = .white
        let tabBarAppearance: UITabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithOpaqueBackground()
        
        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        UITabBar.appearance().standardAppearance = tabBarAppearance
    }
    // TODO: - Refactor
    private func makeTabChildControllerWith(_ config: TabChildControllerConfiguration) -> UINavigationController {
        
        let vc = config.tabViewController()
        vc.tabBarItem = UITabBarItem(title: config.tabTitle, image: config.tabImage, tag: config.rawValue)
        
        let navController = UINavigationController(rootViewController: vc)
        let appearance = UINavigationBarAppearance()
        appearance.configureWithDefaultBackground()
        appearance.backgroundColor = UIColor.navBarThemeColor
        UINavigationBar.appearance().tintColor = UIColor.white
        navController.navigationBar.scrollEdgeAppearance = appearance
        navController.navigationBar.standardAppearance = appearance
        return navController
        
    }
}

