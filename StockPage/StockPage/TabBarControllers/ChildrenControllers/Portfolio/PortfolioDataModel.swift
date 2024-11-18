//
//  PortfolioDataModel.swift
//  StockPage
//
//  Created by Utkarsh Raj on 18/11/24.
//

import Foundation

struct PortfolioDataModel: Decodable {
    let data: UserHoldingData
}

struct UserHoldingData: Decodable {
    let userHolding: [StockData]
}

struct StockData: Decodable {
    let symbol: String
    let quantity: Double
    let ltp: Double
    let avgPrice: Double
    let close: Double
    

}
