//
//  Double+ExtensionsTests.swift
//  StockPageTests
//
//  Created by Utkarsh Raj on 20/11/24.
//


import XCTest
@testable import StockPage

class DoubleExtensionsTests: XCTestCase {

    func testIndianCurrencyFormatPositiveValue() {
        let value: Double = 1234567.89
        let formattedValue = value.indianCurrencyFormat
        XCTAssertEqual(formattedValue, " ₹ 12,34,567.89", "Formatting for positive value is incorrect")
    }

    func testIndianCurrencyFormatNegativeValue() {
        let value: Double = -987654.32
        let formattedValue = value.indianCurrencyFormat
        XCTAssertEqual(formattedValue, "- ₹ 9,87,654.32", "Formatting for negative value is incorrect")
    }

    func testIndianCurrencyFormatZeroValue() {
        let value: Double = 0.0
        let formattedValue = value.indianCurrencyFormat
        XCTAssertEqual(formattedValue,  " ₹ 0.00", "Formatting for zero value is incorrect")
    }

    func testIndianCurrencyFormatSmallValue() {
        let value: Double = 12.5
        let formattedValue = value.indianCurrencyFormat
        XCTAssertEqual(formattedValue, " ₹ 12.50", "Formatting for small value is incorrect")
    }

    func testIndianCurrencyFormatLargeValue() {
        let value: Double = 9876543210.12
        let formattedValue = value.indianCurrencyFormat
        XCTAssertEqual(formattedValue, " ₹ 9,87,65,43,210.12", "Formatting for large value is incorrect")
    }
}

