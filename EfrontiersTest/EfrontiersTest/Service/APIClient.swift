//
//  APIClient.swift
//  EfrontiersTest
//
//  Created by Xavi Tordera on 10/07/2020.
//  Copyright © 2020 Xavi Tordera. All rights reserved.
//

import Foundation
import Combine


final class APIClient {
    
    static let shared = APIClient()
    
    private func getPublisher(for route: APIRouter) -> URLSession.DataTaskPublisher {
        return URLSession.shared.dataTaskPublisher(for: route.asURLRequest())
    }
    
    /// Returns a publisher with the promise of a decodable object T
    /// - Parameters:
    ///   - route: Route (enpoint) to perform the request to
    ///   - decoder: Decoder (JSON by default)
    /// - Returns: Publisher to manage the task
    func requestObject<T:Decodable>(for route: APIRouter, decoder: JSONDecoder = JSONDecoder()) -> AnyPublisher<T, Error>? {
        return getPublisher(for: route)
        .tryMap({
            try self.validate($0.data, $0.response)
        }).decode(type: T.self, decoder: decoder)
        .eraseToAnyPublisher()
    }
    
    /// Validates a given data and url response
    /// - Parameters:
    ///   - data: Data to be validated and returned
    ///   - response: response to be validated
    /// - Throws: API ERROR with a description
    /// - Returns: same Data as given 
    private func validate(_ data: Data, _ response: URLResponse) throws -> Data {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.invalidResponse
        }
        guard (200..<300).contains(httpResponse.statusCode) else {
            throw APIError.statusCode(httpResponse.statusCode)
        }
        return data
    }
}
