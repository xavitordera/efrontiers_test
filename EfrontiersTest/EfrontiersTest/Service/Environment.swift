//
//  Environment.swift
//  WindowSight_TV
//
//  Created by Roberto Gómez on 14/01/2020.
//  Copyright © 2020 WindowSight. All rights reserved.
//

import Foundation

public enum Environment {
    // MARK: - Keys
    enum Keys {
        enum Plist {
            static let baseURL = "BASE_URL"
        }
    }

    // MARK: - Plist
    private static let infoDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("Plist file not found")
        }
        return dict
    }()

    // MARK: - Plist values
    static let baseURL: URL = {
        guard let rootURLstring = Environment.infoDictionary[Keys.Plist.baseURL] as? String else {
            fatalError("Root URL not set in plist for this environment")
        }
        guard let url = URL(string: rootURLstring) else {
            fatalError("Root URL is invalid")
        }
        return url
    }()
}
