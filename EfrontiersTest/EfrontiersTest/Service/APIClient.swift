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
    
    func requestObject<T:Decodable>(for route: APIRouter, decoder: JSONDecoder = JSONDecoder()) -> AnyPublisher<T, Error>? {
        return getPublisher(for: route)
        .tryMap({
            try self.validate($0.data, $0.response)
        }).decode(type: T.self, decoder: decoder)
        .eraseToAnyPublisher()
    }
    
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
