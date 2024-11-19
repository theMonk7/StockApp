//
//  BottomSheetUIViewModel.swift
//  StockPage
//
//  Created by Utkarsh Raj on 19/11/24.
//

import UIKit

class BottomSheetUIViewModel {
    private let stockData: [StockData]
    
    init(stockData: [StockData]) {
        self.stockData = stockData
    }
    
    var currentValue: Double {
        stockData.reduce(0) { partialResult, stockData in
            return partialResult + stockData.ltp*stockData.quantity
        }
    }
    var totalInvestment: Double {
        stockData.reduce(0) { partialResult, stockData in
            return partialResult + stockData.avgPrice*stockData.quantity
        }
    }
    var totalPnL: Double {
        currentValue - totalInvestment
    }
    var todayPnL: Double {
        stockData.reduce(0) { partialResult, stockData in
            return partialResult + (stockData.close-stockData.ltp)*stockData.quantity
        }
    }
    
    var totalPnLTextColor: UIColor {
        totalPnL < 0 ? .lossColor : .profitColor
    }
    var todayPnLTextColor: UIColor {
        todayPnL < 0 ? .lossColor : .profitColor
    }
    
}
