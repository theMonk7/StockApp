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
    var todayPnl: Double {
        (stockData.close - stockData.ltp)*stockData.quantity
    }
    
    var formattedQuantity: String {
        return "\(Int(stockData.quantity))"
    }
    var ltp: Double {
        return stockData.ltp
    }
    
    var pnlTextColor: UIColor {
        totalPnl < 0 ? .lossColor : .profitColor
    }
    
    var stockName: String {
        return stockData.symbol
    }
}
