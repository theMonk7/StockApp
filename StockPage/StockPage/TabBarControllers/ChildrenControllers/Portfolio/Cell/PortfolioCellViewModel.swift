//
//  PortfolioCellViewModel.swift
//  StockPage
//
//  Created by Utkarsh Raj on 18/11/24.
//

import UIKit

struct PortfolioCellViewModel {
    private let stockData: StockData
    
    init(stockData: StockData) {
        self.stockData = stockData
    }
    
    private var totalPnl: Double {
        stockData.ltp*stockData.quantity - stockData.avgPrice*stockData.quantity
    }
    
    private var todayPnl: Double {
        (stockData.close - stockData.ltp)*stockData.quantity
    }
    
    var formattedQuantity: String {
        return "\(stockData.quantity)"
    }
    var formattedLtp: String {
        return "₹ " + String(format: "%.2f", stockData.ltp)
    }
    var formattedTotalPnl: String {
        return totalPnl > 0 ? "₹ " + String(format: "%.2f", totalPnl) : "- ₹" + String(format: "%.2f", -totalPnl)
    }
    var formattedTodayPnl: String {
        return "₹ " + String(format: "%.2f", todayPnl)
    }
    
    var pnlTextColor: UIColor {
        totalPnl < 0 ? .lossColor : .profitColor
    }
    
    var stockName: String {
        return stockData.symbol
    }
}
