//
//  ResourceModel.swift
//  EfrontiersTest
//
//  Created by Xavi Tordera on 10/07/2020.
//  Copyright © 2020 Xavi Tordera. All rights reserved.
//

import Foundation

struct ResourceModel: Decodable {
    var id: String?
    var name: String?
    var x: Double?
    var y: Double?
    var locationType: Int?
    var companyZoneId: Int?
    var lat: Double?
    var lon: Double?
}

typealias ResourcesModel = [ResourceModel]
