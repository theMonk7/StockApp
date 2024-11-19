//
//  RootTabBarControllerTests.swift
//  StockPageTests
//
//  Created by Utkarsh Raj on 20/11/24.
//

import XCTest
@testable import StockPage

class RootTabBarControllerTests: XCTestCase {

    var rootTabBarController: RootTabBarController!

    override func setUp() {
        super.setUp()
        // Initialize the RootTabBarController instance
        rootTabBarController = RootTabBarController()
        // Load the view hierarchy
        _ = rootTabBarController.view
    }

    override func tearDown() {
        rootTabBarController = nil
        super.tearDown()
    }

    // Test: Ensure the tab bar has 5 view controllers
    func testTabBarHasFiveViewControllers() {
        // Verify that the tab bar has exactly 5 view controllers
        XCTAssertEqual(rootTabBarController.viewControllers?.count, 5, "Tab bar should have exactly 5 view controllers")
    }

    // Test: Ensure that the default selected tab is the third tab
    func testDefaultSelectedTab() {
        // Verify that the selectedIndex is set to 2 (third tab, as indices are 0-based)
        XCTAssertEqual(rootTabBarController.selectedIndex, 2, "The third tab should be selected by default")
    }

    // Test: Ensure the tab bar appearance settings are applied
    func testTabBarAppearanceSettings() {
        // Check the tab bar tint color
        XCTAssertEqual(rootTabBarController.tabBar.tintColor, UIColor.tabTintColor, "Tab bar tint color should match the expected color")
        
        // Check the unselected item tint color
        XCTAssertEqual(rootTabBarController.tabBar.unselectedItemTintColor, .unselectedTabItemcolor, "Tab bar unselected item color should match the expected color")
        
        // Check the tab bar background color
        XCTAssertEqual(rootTabBarController.tabBar.backgroundColor, .white, "Tab bar background color should be white")
        
        // Check the selection indicator image size and color
//        let expectedImage = UIImage.createSelectionIndicator(color: .tabTintColor, size: CGSize(width: rootTabBarController.tabBar.frame.width / CGFloat(rootTabBarController.tabBar.items!.count), height: rootTabBarController.tabBar.frame.height), lineWidth: 3.0)
//        XCTAssertEqual(rootTabBarController.tabBar.selectionIndicatorImage?.size, expectedImage?.size, "Selection indicator image size should match the expected size")
    }

    // Test: Ensure that `makeTabChildControllerWith` creates a UINavigationController for each tab
    func testTabControllersAreUINavigationControllers() {
        // Check the type of the first view controller (it should be a UINavigationController)
        let firstTab = rootTabBarController.viewControllers?.first
        XCTAssertTrue(firstTab is UINavigationController, "The view controller should be a UINavigationController")
    }

    // Test: Ensure the navigation bar appearance is correctly applied
    func testNavigationBarAppearance() {
        let firstNavController = rootTabBarController.viewControllers?.first as? UINavigationController
        let navBarAppearance = firstNavController?.navigationBar.standardAppearance
        
        // Check if the background color is set to the expected color
        XCTAssertEqual(navBarAppearance?.backgroundColor, UIColor.navBarThemeColor, "Navigation bar background color should match the expected color")
    }

}
