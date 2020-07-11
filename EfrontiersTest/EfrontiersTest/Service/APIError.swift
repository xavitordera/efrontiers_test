//
//  APIError.swift
//  EfrontiersTest
//
//  Created by Xavi Tordera on 10/07/2020.
//  Copyright © 2020 Xavi Tordera. All rights reserved.
//

import Foundation

enum APIError: LocalizedError {
    case statusCode(_ statusCode: Int)
    case invalidResponse
}
