//
//  TabChildControllerConfiguration.swift
//  StockPage
//
//  Created by Utkarsh Raj on 17/11/24.
//

import UIKit

enum TabChildControllerConfiguration: Int {
    
    case watchlist = 0
    case orders = 1
    case portfolio = 2
    case funds = 3
    case invest = 4
    
    func tabViewController() -> UIViewController {
        switch self {
            
        case .watchlist:
            return WatchListViewController()
        case .orders:
            return OrderViewController()
        case .portfolio:
            return PortfolioViewController()
        case .funds:
            return FundViewController()
        case .invest:
            return InvestViewController()
        }
    }
    
    
    var tabTitle: String {
        switch self {
            
        case .watchlist:
            return "Watchlist"
        case .orders:
            return "Orders"
        case .portfolio:
            return "Portfolio"
        case .funds:
            return "Funds"
        case .invest:
            return "Invest"
        }
    }
    
    var tabImage: UIImage? {
        switch self {
            
        case .watchlist:
            return UIImage(systemName: "list.bullet")
        case .orders:
            return UIImage(systemName: "clock.arrow.circlepath")
        case .portfolio:
            return UIImage(systemName: "suitcase")
        case .funds:
            return UIImage(systemName: "indianrupeesign")
        case .invest:
            return UIImage(systemName: "gearshape")
        }
    }
}
