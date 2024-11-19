//
//  Double+Extensions.swift
//  StockPage
//
//  Created by Utkarsh Raj on 19/11/24.
//

import Foundation

extension Double {
    var indianCurrencyFormat: String? {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "en_IN")
        formatter.numberStyle = .currency
        formatter.currencySymbol = " ₹"
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter.string(from: NSNumber(value: self))
    }
}
