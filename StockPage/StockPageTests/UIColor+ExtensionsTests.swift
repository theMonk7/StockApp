//
//  UIColor+ExtensionsTests.swift
//  StockPageTests
//
//  Created by Utkarsh Raj on 20/11/24.
//

import XCTest
@testable import StockPage

class UIColorExtensionsTests: XCTestCase {

    func testNavBarThemeColor() {
        let expectedColor = UIColor(red: 2/255, green: 50/255, blue: 100/255, alpha: 1)
        XCTAssertEqual(UIColor.navBarThemeColor, expectedColor, "navBarThemeColor does not match the expected value")
    }

    func testTabTintColor() {
        let expectedColor = UIColor(red: 36/255, green: 72/255, blue: 143/255, alpha: 1)
        XCTAssertEqual(UIColor.tabTintColor, expectedColor, "tabTintColor does not match the expected value")
    }

    func testUnselectedTabItemColor() {
        let expectedColor = UIColor(red: 100/255, green: 100/255, blue: 100/255, alpha: 1)
        XCTAssertEqual(UIColor.unselectedTabItemcolor, expectedColor, "unselectedTabItemcolor does not match the expected value")
    }

    func testCellTextPlaceholderColor() {
        let expectedColor = UIColor(red: 170/255, green: 170/255, blue: 170/255, alpha: 1)
        XCTAssertEqual(UIColor.cellTextPlaceholderColor, expectedColor, "cellTextPlaceholderColor does not match the expected value")
    }

    func testProfitColor() {
        let expectedColor = UIColor(red: 68/255, green: 157/255, blue: 122/255, alpha: 1)
        XCTAssertEqual(UIColor.profitColor, expectedColor, "profitColor does not match the expected value")
    }

    func testLossColor() {
        let expectedColor = UIColor(red: 197/255, green: 76/255, blue: 80/255, alpha: 1)
        XCTAssertEqual(UIColor.lossColor, expectedColor, "lossColor does not match the expected value")
    }

    func testBottomSheetColor() {
        let expectedColor = UIColor(red: 243/255, green: 243/255, blue: 243/255, alpha: 1)
        XCTAssertEqual(UIColor.bottomSheetColor, expectedColor, "bottomSheetColor does not match the expected value")
    }

    func testGrayLight() {
        let expectedColor = UIColor(red: 153/255, green: 153/255, blue: 153/255, alpha: 1)
        XCTAssertEqual(UIColor.grayLight, expectedColor, "grayLight does not match the expected value")
    }

    func testGrayDark() {
        let expectedColor = UIColor(red: 70/255, green: 70/255, blue: 70/255, alpha: 1)
        XCTAssertEqual(UIColor.grayDark, expectedColor, "grayDark does not match the expected value")
    }
}

