//
//  MapView.swift
//  EfrontiersTest
//
//  Created by Xavi Tordera on 08/07/2020.
//  Copyright © 2020 Xavi Tordera. All rights reserved.
//

import SwiftUI
import GoogleMaps

struct MapView
: UIViewRepresentable {
    
        // 1
    @Binding var locationManager: LocationManager
    @Binding var viewModel: MapViewModel
    
        private let zoom: Float = 15.0
        
    func makeUIView(context: MapView.Context) -> GMSMapView {
            let camera = GMSCameraPosition.camera(withLatitude: locationManager.currentLocation?.coordinate.latitude ?? 0.0, longitude: locationManager.currentLocation?.coordinate.longitude ?? 0.0, zoom: zoom)
            let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
            return mapView
        }
        
        // 3
        func updateUIView(_ mapView: GMSMapView, context: Context) {
            //        let camera = GMSCameraPosition.camera(withLatitude: locationManager.latitude, longitude: locationManager.longitude, zoom: zoom)
            //        mapView.camera = camera
            mapView.animate(toLocation: CLLocationCoordinate2D(latitude: locationManager.latitude, longitude: locationManager.longitude))
        }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
