//
//  MapViewModel.swift
//  EfrontiersTest
//
//  Created by Xavi Tordera on 08/07/2020.
//  Copyright © 2020 Xavi Tordera. All rights reserved.
//

import CoreLocation
import Combine

class MapViewModel: NSObject, ObservableObject {
    @Published var location: CLLocation?
    
    var latitude: CLLocationDegrees {
        location?.coordinate.latitude ?? 0
    }
    
    var longitude: CLLocationDegrees {
        location?.coordinate.longitude ?? 0
    }
    
    
    
    func requestPoints() {
        let xs : AnyPublisher<APIClient.shared.requestObject(for: APIRouter.resources(lat1: 35.2, long1: 21.2, lat2: 123.1, long2: 123.1))
    }
}

extension MapViewModel: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.location = locations.last
    }
}
