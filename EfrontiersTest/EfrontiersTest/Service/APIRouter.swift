//
//  APIRouter.swift
//  EfrontiersTest
//
//  Created by Xavi Tordera on 10/07/2020.
//  Copyright © 2020 Xavi Tordera. All rights reserved.
//

import Foundation

enum APIRouter {
    case resources(lat1: Double, long1: Double, lat2: Double, long2: Double)
    
    static let baseURL = Environment.baseURL
    
    var headers: [String : String]? {
        return [
            "Accept" : "application/json"
        ]
    }
    
    var method: String {
        switch self {
        case .resources: return "GET"
        }
    }
    
    var urlParameters: [URLQueryItem]? {
        switch self {
        case .resources(let lat1,
                        let long1,
                        let lat2,
                        let long2):
            return [
                URLQueryItem.init(name: kParamZoneLeft, value: "\(lat1),\(long1)"),
                 URLQueryItem.init(name: kParamZoneRight, value: "\(lat2),\(long2)")
            ]
        }
    }
    
    var path: String {
        switch self {
        case .resources(let lat1, let long1, let lat2, let long2):
            return String.init(format: kGETResources, lat1, long1, lat2, long2)
        }
    }
    
    
    func asURLRequest() -> URLRequest {
        let url = APIRouter.baseURL.appendingPathComponent(self.path)
        
        let urlComp = url.absoluteString
        
        guard var components = URLComponents.init(string: urlComp) else {
            return URLRequest.init(url: url)
        }
        
        components.queryItems = self.urlParameters
        var urlRequest = URLRequest.init(url: url)
        if let url = components.url {
            urlRequest = URLRequest(url: url)
        }
        
        urlRequest.httpMethod = self.method
        urlRequest.allHTTPHeaderFields = self.headers
        
        return urlRequest
    }
}
