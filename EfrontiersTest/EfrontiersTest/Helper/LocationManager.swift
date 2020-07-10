//
//  LocationManager.swift
//  EfrontiersTest
//
//  Created by Xavi Tordera on 08/07/2020.
//  Copyright © 2020 Xavi Tordera. All rights reserved.
//

import Combine
import CoreLocation

class LocationManager: NSObject, ObservableObject {
    private let locationManager = CLLocationManager()
    
    static let shared = LocationManager()

    // 1
    @Published var location: CLLocation? {
        willSet {
            objectWillChange.send()
        }
    }
    
    var currentLocation: CLLocation?
    
    // 2
    var latitude: CLLocationDegrees {
        return location?.coordinate.latitude ?? 0
    }
    
    var longitude: CLLocationDegrees {
        return location?.coordinate.longitude ?? 0
    }
    
    // 3
    override init() {
      super.init()

      locationManager.delegate = self
      locationManager.desiredAccuracy = kCLLocationAccuracyBest
      locationManager.requestWhenInUseAuthorization()
      locationManager.startUpdatingLocation()
        
        if
           CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
           CLLocationManager.authorizationStatus() ==  .authorizedAlways
        {
            self.currentLocation = locationManager.location
        }
    }
    
    
}

extension LocationManager: CLLocationManagerDelegate {
  // 4
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        self.location = location
    }
}
