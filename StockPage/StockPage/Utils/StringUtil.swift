//
//  StringUtil.swift
//  StockPage
//
//  Created by Utkarsh Raj on 18/11/24.
//

import Foundation


class StringUtil {
    static let shared = StringUtil()
    private init() {}
    
    func formatCurrency(value: Double, locale: Locale = .current) -> String? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = locale
        return formatter.string(from: NSNumber(value: value))
    }
}
