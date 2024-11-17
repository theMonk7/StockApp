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
        
        let watchVC = WatchListViewController()
        let orderVC = OrderViewController()
        let portfolioVC = PortfolioViewController()
        let fundVC = FundViewController()
        let investVC = InvestViewController()
        
        // Set tab bar items with titles and icons
        watchVC.tabBarItem = UITabBarItem(title: "Watchlist", image: UIImage(systemName: "list.bullet"), tag: 0)
        orderVC.tabBarItem = UITabBarItem(title: "Orders", image: UIImage(systemName: "clock.arrow.circlepath"), tag: 1)
        portfolioVC.tabBarItem = UITabBarItem(title: "Portfolio", image: UIImage(systemName: "suitcase"), tag: 2)
        fundVC.tabBarItem = UITabBarItem(title: "Funds", image: UIImage(systemName: "indianrupeesign"), tag: 3)
        investVC.tabBarItem = UITabBarItem(title: "Invest", image: UIImage(systemName: "gearshape"), tag: 4)
        
        // Embed the view controllers in navigation controllers if needed
        let watchNavController = UINavigationController(rootViewController: watchVC)
        let orderNavController = UINavigationController(rootViewController: orderVC)
        let portfolioNavController = UINavigationController(rootViewController: portfolioVC)
        let fundNavController = UINavigationController(rootViewController: fundVC)
        let investNavController = UINavigationController(rootViewController: investVC)
        
        // Set the view controllers of the tab bar
        viewControllers = [watchNavController, orderNavController, portfolioNavController, fundNavController, investNavController]
        
        // Customize the appearance of the tab bar
        tabBar.tintColor = .systemBlue
        tabBar.unselectedItemTintColor = .gray
        tabBar.backgroundColor = .white
    }
    
    


}

