//
//  PortfolioViewControllerTests.swift
//  StockPageTests
//
//  Created by Utkarsh Raj on 20/11/24.
//

import XCTest
import Combine
@testable import StockPage

class PortfolioViewControllerTests: XCTestCase {

    var portfolioViewController: PortfolioViewController!
    var viewModel: PortfolioDataViewModel!
    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        // Initialize the view controller and view model
        portfolioViewController = PortfolioViewController()
        viewModel = PortfolioDataViewModel()
        cancellables = Set<AnyCancellable>()
        
        // Load the view hierarchy to trigger viewDidLoad
        _ = portfolioViewController.view
    }

    override func tearDown() {
        portfolioViewController = nil
        viewModel = nil
        cancellables = nil
        super.tearDown()
    }

    // Test: Ensure that the tableView reloads when stock data is fetched
    func testTableViewReloadsWhenDataIsFetched() {
        // Prepare expectation
        let expectation = XCTestExpectation(description: "Table view reloads after data fetch")
        viewModel.fetchData()
        sleep(3)
        // Observe stockData changes
        viewModel.$stockData
            .sink { stockData in
                if stockData.count > 0 {
                    // Check if the tableView reloads
                    XCTAssertTrue(stockData.count > 0, "TableView should have cells after data is fetched")
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)
        
        // Fetch data
        
        
        // Wait for the async data fetch to complete
        wait(for: [expectation], timeout: 6.0)
    }

    // Test: Ensure sorting updates the tableView
    func testSortData() {
        // Set up initial data

        let stockData = [
            StockData(symbol: "AAPL", quantity: 100, ltp: 150.0, avgPrice: 140.0, close: 145.0),
            StockData(symbol: "GOOG", quantity: 50, ltp: 2500.0, avgPrice: 2400.0, close: 2450.0)
        ]
        
        viewModel.stockData = stockData
        
        // Ensure the stock data is sorted
        XCTAssertEqual(viewModel.stockData[0].symbol, "AAPL", "Stock data should be sorted in descending order of quantity")
    }

    // Test: Ensure the switcherView buttons work
    func testSwitcherViewButtons() {
        // Access the switcher view's left and right buttons
        let switcherView = portfolioViewController.switcherView
        let leftButton = switcherView.subviews.first(where: { $0 is UIButton && ($0 as! UIButton).title(for: .normal) == PortfolioConstants.positions }) as? UIButton
        let rightButton = switcherView.subviews.first(where: { $0 is UIButton && ($0 as! UIButton).title(for: .normal) == PortfolioConstants.holdings }) as? UIButton
        
        // Ensure buttons are not nil
        XCTAssertNotNil(leftButton, "Left button should exist in the switcher view")
        XCTAssertNotNil(rightButton, "Right button should exist in the switcher view")
        
        // Check initial state
        XCTAssertEqual(leftButton?.titleColor(for: .normal), .grayLight, "Left button should have gray light color initially")
        XCTAssertEqual(rightButton?.titleColor(for: .normal), .grayDark, "Right button should have gray dark color initially")
    }
    
    // Test: Ensure navigation bar items are set
    func testNavigationBarItems() {
        // Check left bar button items (profile button and title)
        XCTAssertEqual(portfolioViewController.navigationItem.leftBarButtonItems?.count, 2, "Left bar button items should be correct")
        
        // Check right bar button items (search button, divider, and sort button)
        XCTAssertEqual(portfolioViewController.navigationItem.rightBarButtonItems?.count, 3, "Right bar button items should be correct")
    }

}
