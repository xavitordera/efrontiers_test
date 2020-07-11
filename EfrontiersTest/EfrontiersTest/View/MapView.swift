//
//  MapView.swift
//  EfrontiersTest
//
//  Created by Xavi Tordera on 08/07/2020.
//  Copyright © 2020 Xavi Tordera. All rights reserved.
//

import SwiftUI
import GoogleMaps

struct MapView: UIViewRepresentable {
    @ObservedObject var viewModel: MapViewModel
    var locationManager = CLLocationManager()
    
    func setupManager() {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
    }
    
    func makeUIView(context: Context) -> GMSMapView {
        setupManager()
        let camera = GMSCameraPosition.camera(withLatitude: 38.711046,
                                              longitude: -9.160096,
                                              zoom: 15) // lisboa
        let mapView = GMSMapView.map(withFrame: UIScreen.main.bounds, camera: camera)
        mapView.setMinZoom(15, maxZoom: 20)
        
        viewModel.requestPoints(for: mapView.projection.visibleRegion().nearLeft, for: mapView.projection.visibleRegion().farRight)
        mapView.delegate = viewModel
        return mapView
    }
    
    func updateUIView(_ mapView: GMSMapView, context: Context) {
        if !viewModel.dataSource.isEmpty { mapView.clear() }
        DispatchQueue.global(qos: .userInitiated).async {
            for source in viewModel.dataSource {
                DispatchQueue.main.async {
                    guard let y = source.y, let x = source.x else {return}
                    let marker = GMSMarker(position: .init(latitude: y, longitude: x))
                    marker.title = source.name
                    marker.appearAnimation = .pop
                    marker.infoWindowAnchor = CGPoint(x: 0.5, y: 0.5)
                    marker.iconView = UIImageView(image: source.image()?.withRenderingMode(.alwaysTemplate))
                    marker.iconView?.tintColor = source.color()
                    marker.map = mapView
                }
            }
        }
    }
}
