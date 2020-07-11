//
//  ResourceModel.swift
//  EfrontiersTest
//
//  Created by Xavi Tordera on 10/07/2020.
//  Copyright © 2020 Xavi Tordera. All rights reserved.
//

enum Transports: Int {
    case train = 378
    case bus = 382
    case bike = 412
    case car = 467
    case motorbike = 473
}

import UIKit

struct ResourceModel: Decodable {
    var id, name: String?
    var x, y, lat, lon: Double?
    var locationType, companyZoneId: Int?
    
    func color() -> UIColor {
        guard let id = companyZoneId else {return .red} // default
        
        switch Transports(rawValue: id) {
        case .train: // train?????
            return .orange
        case .bus: // bus???
            return .lightGray
        case .bike: // Bikes
            return .purple
        case .car: // cars
            return .cyan
        case .motorbike: // motorbikes
            return .yellow
        default:
            return .red
        }
    }
    
    func image() -> UIImage? {
        guard let id = companyZoneId else {return nil} // default
        
        switch Transports(rawValue: id) {
        case .train: // train?????
            return UIImage(systemName: "tram")
        case .bus: // bus???
            return UIImage(systemName: "bus")
        case .bike: // Bikes
            return UIImage(systemName: "bicycle")
        case .car: // cars
            return UIImage(systemName: "bolt.car")
        case .motorbike: // motorcycle
            return UIImage(named: "motorcycle")
        default:
            return nil
        }
    }
}

typealias ResourcesModel = [ResourceModel]
