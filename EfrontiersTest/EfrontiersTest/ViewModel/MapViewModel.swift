//
//  MapViewModel.swift
//  EfrontiersTest
//
//  Created by Xavi Tordera on 08/07/2020.
//  Copyright © 2020 Xavi Tordera. All rights reserved.
//

import CoreLocation
import Combine
import GoogleMaps

class MapViewModel: NSObject, ObservableObject {
    @Published var dataSource: ResourcesModel = []
    
    private var cancellable: AnyCancellable?
    
    // TODO: - Make it scalable for other cities (with maybe Google Places?)
    /// Requests points for a certain area based on a location in a certain zone
    /// - Parameters:
    ///   - visibleRegionNear: Coordinate of the bottom left corner of the visible region
    ///   - visibleRegionFar: Coordinate of the upper right corner of the visible region
    ///   - zone: City or area of the location
    func requestPoints(for visibleRegionNear: CLLocationCoordinate2D? = nil,
                       for visibleRegionFar: CLLocationCoordinate2D? = nil, in zone: String = "lisboa") {
        let xs : AnyPublisher<ResourcesModel, Error>? = (visibleRegionNear == nil || visibleRegionFar == nil) ?
            APIClient.shared.requestObject(for: APIRouter.resources(zone: zone,
                                                                    lat1: 38.711046,
                                                                    long1: -9.160096,
                                                                    lat2: 38.739429,
                                                                    long2: -9.137115))
            :
            APIClient.shared.requestObject(for: APIRouter.resources(
                                            zone: zone,
                                            lat1: visibleRegionNear!.latitude,
                                            long1: visibleRegionNear!.longitude,
                                            lat2: visibleRegionFar!.latitude,
                                            long2: visibleRegionFar!.longitude)
            )
        
        cancellable = xs?.receive(on: RunLoop.main)
            .sink(receiveCompletion: { (completion) in
                switch completion {
                case .failure(let error):
                    debugPrint(error.localizedDescription)
                case .finished:
                    debugPrint("Done fetching")
                }
            }, receiveValue: {dataSource in
                self.dataSource = dataSource
            })
    }
}

extension MapViewModel: GMSMapViewDelegate {
    // TODO: - Prevent somehow to redraw and request points for every single user interaction...
    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
        cancellable?.cancel()
        let bottomLeft = mapView.projection.visibleRegion().nearLeft
        let upperRight = mapView.projection.visibleRegion().farRight
        requestPoints(for: bottomLeft, for: upperRight)
    }
}
