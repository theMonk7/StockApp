//
//  BottomSheetUIViewModelTests.swift
//  StockPageTests
//
//  Created by Utkarsh Raj on 20/11/24.
//


import XCTest
@testable import StockPage

class BottomSheetUIViewModelTests: XCTestCase {

    func testViewModelCalculations() {
        // Mock data
        let stockData = [
            StockData(symbol: "PPM", quantity: 10, ltp: 100.0, avgPrice: 80.0, close: 95.0),
            StockData(symbol: "AVF", quantity: 5, ltp: 150.0, avgPrice: 120.0, close: 140.0)
        ]
        
        let viewModel = BottomSheetUIViewModel(stockData: stockData)
        
        // Test current value
        XCTAssertEqual(viewModel.currentValue, 1750.0, "Current value calculation is incorrect")
        
        // Test total investment
        XCTAssertEqual(viewModel.totalInvestment, 1400.0, "Total investment calculation is incorrect")
        
        // Test total P&L
        XCTAssertEqual(viewModel.totalPnL, 350.0, "Total P&L calculation is incorrect")
        
        // Test today's P&L
        XCTAssertEqual(viewModel.todayPnL, -100.0, "Today's P&L calculation is incorrect")
    }
    
    func testTextColorLogic() {
        // Positive P&L
        let positiveStockData = [
            StockData(symbol: "OPP", quantity: 10, ltp: 100.0, avgPrice: 80.0, close: 95.0)
        ]
        let positiveViewModel = BottomSheetUIViewModel(stockData: positiveStockData)
        XCTAssertEqual(positiveViewModel.totalPnLTextColor, .profitColor, "Total P&L text color should indicate profit")
        XCTAssertEqual(positiveViewModel.todayPnLTextColor, .lossColor, "Today's P&L text color should indicate loss")
        
        // Negative P&L
        let negativeStockData = [
            StockData(symbol: "XXX", quantity: 10, ltp: 70.0, avgPrice: 80.0, close: 75.0)
        ]
        let negativeViewModel = BottomSheetUIViewModel(stockData: negativeStockData)
        XCTAssertEqual(negativeViewModel.totalPnLTextColor, .lossColor, "Total P&L text color should indicate loss")
        XCTAssertEqual(negativeViewModel.todayPnLTextColor, .profitColor, "Today's P&L text color should indicate profit")
    }
}

