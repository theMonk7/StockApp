//
//  PortfolioDataViewModel.swift
//  StockPage
//
//  Created by Utkarsh Raj on 18/11/24.
//

import Foundation
import Combine

class PortfolioDataViewModel: ObservableObject {
    @Published var stockData: [StockData] = []
    @Published var isLoading = false
    
    private var cancellables = Set<AnyCancellable>()
    
    func fetchData() {
        isLoading = true
        HTTPClient.shared.fetchData(from: Constant.apiEndPoint, responseType: PortfolioDataModel.self)
            .sink { completion in
                switch completion {
                case .finished:
                    print("Finished successfully")
                case .failure(let error):
                    print("Error: \(error)")
                }
            } receiveValue: { [weak self] portfolioData in
                self?.stockData = portfolioData.data.userHolding
                self?.isLoading = false
            }
            .store(in: &cancellables) 

    }
}
