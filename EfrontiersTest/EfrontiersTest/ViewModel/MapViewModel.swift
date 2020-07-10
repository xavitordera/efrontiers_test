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
    @Published var dataSource: ResourcesModel = [] {
        willSet {
//            debugPrint(oldValue)
            debugPrint(newValue)
        }
    }
    @Published var error: APIError?
    var cancellable: AnyCancellable?
    
    var latitude: CLLocationDegrees {
        location?.coordinate.latitude ?? 0
    }
    
    var longitude: CLLocationDegrees {
        location?.coordinate.longitude ?? 0
    }
    
    func requestPoints() {
        let xs : AnyPublisher<ResourcesModel, Error>? = APIClient.shared.requestObject(for: APIRouter.resources(lat1: 38.711046, long1: -9.160096, lat2: 38.739429, long2: -9.137115))
        
        cancellable = xs?.receive(on: RunLoop.main)
        .replaceError(with: [])
            .assign(to: \MapViewModel.dataSource, on: self)
    
    }
}

extension MapViewModel: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.location = locations.last
    }
}
