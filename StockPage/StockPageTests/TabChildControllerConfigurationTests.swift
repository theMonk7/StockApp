//
//  TabChildControllerConfigurationTests.swift
//  StockPageTests
//
//  Created by Utkarsh Raj on 20/11/24.
//

import XCTest
@testable import StockPage

class TabChildControllerConfigurationTests: XCTestCase {

    // Test: Ensure the correct view controller is returned for each enum case
    func testTabViewController() {
        // Watchlist
        let watchlistVC = TabChildControllerConfiguration.watchlist.tabViewController()
        XCTAssertTrue(watchlistVC is WatchListViewController, "The watchlist case should return a WatchListViewController")
        
        // Orders
        let ordersVC = TabChildControllerConfiguration.orders.tabViewController()
        XCTAssertTrue(ordersVC is OrderViewController, "The orders case should return an OrderViewController")
        
        // Portfolio
        let portfolioVC = TabChildControllerConfiguration.portfolio.tabViewController()
        XCTAssertTrue(portfolioVC is PortfolioViewController, "The portfolio case should return a PortfolioViewController")
        
        // Funds
        let fundsVC = TabChildControllerConfiguration.funds.tabViewController()
        XCTAssertTrue(fundsVC is FundViewController, "The funds case should return a FundViewController")
        
        // Invest
        let investVC = TabChildControllerConfiguration.invest.tabViewController()
        XCTAssertTrue(investVC is InvestViewController, "The invest case should return an InvestViewController")
    }

    // Test: Ensure the correct tabTitle is returned for each enum case
    func testTabTitle() {
        // Watchlist
        XCTAssertEqual(TabChildControllerConfiguration.watchlist.tabTitle, "Watchlist", "The watchlist case should have the title 'Watchlist'")
        
        // Orders
        XCTAssertEqual(TabChildControllerConfiguration.orders.tabTitle, "Orders", "The orders case should have the title 'Orders'")
        
        // Portfolio
        XCTAssertEqual(TabChildControllerConfiguration.portfolio.tabTitle, "Portfolio", "The portfolio case should have the title 'Portfolio'")
        
        // Funds
        XCTAssertEqual(TabChildControllerConfiguration.funds.tabTitle, "Funds", "The funds case should have the title 'Funds'")
        
        // Invest
        XCTAssertEqual(TabChildControllerConfiguration.invest.tabTitle, "Invest", "The invest case should have the title 'Invest'")
    }

    // Test: Ensure the correct tabImage is returned for each enum case
    func testTabImage() {
        // Watchlist
        let watchlistImage = TabChildControllerConfiguration.watchlist.tabImage
        XCTAssertEqual(watchlistImage, UIImage(systemName: "list.bullet"), "The watchlist case should have the correct tab image")

        // Orders
        let ordersImage = TabChildControllerConfiguration.orders.tabImage
        XCTAssertEqual(ordersImage, UIImage(systemName: "clock.arrow.circlepath"), "The orders case should have the correct tab image")

        // Portfolio
        let portfolioImage = TabChildControllerConfiguration.portfolio.tabImage
        XCTAssertEqual(portfolioImage, UIImage(systemName: "suitcase"), "The portfolio case should have the correct tab image")

        // Funds
        let fundsImage = TabChildControllerConfiguration.funds.tabImage
        XCTAssertEqual(fundsImage, UIImage(systemName: "indianrupeesign"), "The funds case should have the correct tab image")

        // Invest
        let investImage = TabChildControllerConfiguration.invest.tabImage
        XCTAssertEqual(investImage, UIImage(systemName: "gearshape"), "The invest case should have the correct tab image")
    }
}
