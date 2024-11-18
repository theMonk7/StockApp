//
//  HTTPClient.swift
//  StockPage
//
//  Created by Utkarsh Raj on 18/11/24.
//

import Foundation
import Combine

enum APIError: Error {
    case invalidURL
    case requestFailed(Error)
    case decodingFailed(Error)
}

class HTTPClient {
    static let shared = HTTPClient()
    private init() {}

    func fetchData<T: Decodable>(
        from urlString: String,
        responseType: T.Type
    ) -> AnyPublisher<T, APIError> {
        guard let url = URL(string: urlString) else {
            return Fail(error: APIError.invalidURL).eraseToAnyPublisher()
        }

        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)

            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .mapError { error in
                if let decodingError = error as? DecodingError {
                    return APIError.decodingFailed(decodingError)
                } else {
                    return APIError.requestFailed(error)
                }
            }
            .eraseToAnyPublisher()
    }
}
