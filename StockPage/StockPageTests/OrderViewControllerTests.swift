//
//  OrderViewControllerTests.swift
//  StockPageTests
//
//  Created by Utkarsh Raj on 20/11/24.
//

import XCTest
@testable import StockPage

class OrderViewControllerTests: XCTestCase {
    
    var viewController: OrderViewController!

    override func setUpWithError() throws {
        try super.setUpWithError()
        viewController = OrderViewController()
        _ = viewController.view // Trigger `viewDidLoad`
    }

    override func tearDownWithError() throws {
        viewController = nil
        try super.tearDownWithError()
    }
    
    func testViewControllerBackgroundColor() {
        // Verify background color
        XCTAssertEqual(viewController.view.backgroundColor, .white, "Background color should be white")
    }
    
    func testNavigationBarItems() {
        guard let leftItems = viewController.navigationItem.leftBarButtonItems else {
            XCTFail("Left bar button items should not be nil")
            return
        }
        
        // Test profile button
        let profileButton = leftItems.first
        XCTAssertNotNil(profileButton, "Profile button should exist")
        XCTAssertEqual(profileButton?.image, UIImage(systemName: "person.circle"), "Profile button should have correct image")
        XCTAssertEqual(profileButton?.style, .plain, "Profile button style should be plain")
        
        // Test title label
        guard let titleItem = leftItems.last, let titleLabel = titleItem.customView as? UILabel else {
            XCTFail("Title item or label should exist")
            return
        }
        XCTAssertEqual(titleLabel.text, "Orders", "Title label should display 'Order'")
        XCTAssertEqual(titleLabel.textColor, .white, "Title label color should be white")
    }
}
