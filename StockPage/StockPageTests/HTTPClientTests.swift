////
////  HTTPClientTests.swift
////  StockPageTests
////
////  Created by Utkarsh Raj on 20/11/24.
////
//
//import XCTest
//import Combine
//@testable import StockPage
//
//class PortfolioDataViewModelTests: XCTestCase {
//
//    var viewModel: PortfolioDataViewModel!
//    var cancellables: Set<AnyCancellable>!
//    
//    // Mocked Data for Tests
//    let mockStockData: [StockData] = [
//        StockData(symbol: "AAPL", quantity: 100, ltp: 150.0, avgPrice: 140.0, close: 145.0),
//        StockData(symbol: "GOOG", quantity: 50, ltp: 2500.0, avgPrice: 2400.0, close: 2450.0),
//        StockData(symbol: "MSFT", quantity: 200, ltp: 300.0, avgPrice: 280.0, close: 290.0)
//    ]
//
//    override func setUp() {
//        super.setUp()
//        viewModel = PortfolioDataViewModel()
//        cancellables = Set<AnyCancellable>()
//    }
//
//    override func tearDown() {
//        viewModel = nil
//        cancellables = nil
//        super.tearDown()
//    }
//    
//    // MARK: - Test fetchData()
//    
//    func testFetchDataSuccess() {
//        // Mock the HTTPClient's fetchData method to return mock data
//        let mockHTTPClient = MockHTTPClient()
//        HTTPClient.shared = mockHTTPClient
//        
//        // Expectation for successful data fetch
//        let expectation = XCTestExpectation(description: "Data fetch successful")
//        
//        viewModel.$stockData
//            .sink { stockData in
//                if stockData.count > 0 {
//                    // Verify that stockData is updated
//                    XCTAssertEqual(stockData.count, self.mockStockData.count, "Stock data should contain the correct number of items")
//                    expectation.fulfill()
//                }
//            }
//            .store(in: &cancellables)
//        
//        // Trigger the data fetch
//        viewModel.fetchData()
//        
//        // Wait for the async task to complete
//        wait(for: [expectation], timeout: 2.0)
//    }
//    
//    func testFetchDataFailure() {
//        // Mock the HTTPClient's fetchData method to simulate a failure
//        let mockHTTPClient = MockHTTPClient(shouldFail: true)
//        HTTPClient.shared = mockHTTPClient
//        
//        // Expectation for data fetch failure
//        let expectation = XCTestExpectation(description: "Data fetch failed")
//        
//        viewModel.$stockData
//            .sink { stockData in
//                // Ensure that stockData is still empty on failure
//                XCTAssertTrue(stockData.isEmpty, "Stock data should be empty after failure")
//                expectation.fulfill()
//            }
//            .store(in: &cancellables)
//        
//        // Trigger the data fetch
//        viewModel.fetchData()
//        
//        // Wait for the async task to complete
//        wait(for: [expectation], timeout: 2.0)
//    }
//
//    // MARK: - Test sortData()
//
//    func testSortData() {
//        // Set mock stock data
//        viewModel.stockData = mockStockData
//        
//        // Trigger sorting
//        viewModel.sortData()
//        
//        // Verify that the data is sorted by quantity in descending order
//        XCTAssertEqual(viewModel.stockData.first?.symbol, "MSFT", "The first stock should have the highest quantity")
//        XCTAssertEqual(viewModel.stockData.last?.symbol, "GOOG", "The last stock should have the lowest quantity")
//    }
//    
//    // Test when stockData is empty
//    func testSortDataWhenEmpty() {
//        // Empty stock data
//        viewModel.stockData = []
//        
//        // Trigger sorting
//        viewModel.sortData()
//        
//        // Verify that the data remains empty
//        XCTAssertTrue(viewModel.stockData.isEmpty, "Stock data should remain empty when sorting")
//    }
//    
//    // MARK: - Test searchDataWith()
//
//    func testSearchDataWith() {
//        // Set mock stock data
//        viewModel.stockData = mockStockData
//        
//        // Perform search with a symbol "AAPL"
//        let searchString = "AAPL"
//        viewModel.searchDataWith(searchString)
//        
//        // Verify that the filtered stock data contains only the matching symbol
//        XCTAssertEqual(viewModel.stockData.count, 1, "Stock data should contain only one item after search")
//        XCTAssertEqual(viewModel.stockData.first?.symbol, "AAPL", "The stock data should match the search symbol")
//    }
//    
//    // Test when there is no match in search
//    func testSearchDataWithNoMatch() {
//        // Set mock stock data
//        viewModel.stockData = mockStockData
//        
//        // Perform search with a non-existing symbol "XYZ"
//        let searchString = "XYZ"
//        viewModel.searchDataWith(searchString)
//        
//        // Verify that no data matches the search
//        XCTAssertTrue(viewModel.stockData.isEmpty, "Stock data should be empty when there is no match")
//    }
//}
//
//// MARK: - Mock Classes
//
//// Mock HTTPClient for testing fetchData()
//class MockHTTPClient: HTTPClient {
//    private var shouldFail: Bool
//    
//    init(shouldFail: Bool = false) {
//        self.shouldFail = shouldFail
//    }
//
//    override func fetchData<T: Decodable>(from url: String, responseType: T.Type) -> AnyPublisher<T, Error> {
//        if shouldFail {
//            return Fail(error: URLError(.badServerResponse))
//                .eraseToAnyPublisher()
//        } else {
//            let portfolioData = PortfolioDataModel(data: UserHoldingData(userHolding: [
//                StockData(symbol: "AAPL", quantity: 100, ltp: 150.0, avgPrice: 140.0, close: 145.0),
//                StockData(symbol: "GOOG", quantity: 50, ltp: 2500.0, avgPrice: 2400.0, close: 2450.0)
//            ]))
//            return Just(portfolioData as! T)
//                .setFailureType(to: Error.self)
//                .eraseToAnyPublisher()
//        }
//    }
//}
