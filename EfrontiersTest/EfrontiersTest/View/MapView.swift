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
    @EnvironmentObject var viewModel: MapViewModel
    var locationManager = CLLocationManager()
    
    func setupManager() {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
        
        locationManager.delegate = viewModel
    }
    
    func makeUIView(context: Context) -> GMSMapView {
        setupManager()
        let mapView = GMSMapView(frame: UIScreen.main.bounds)
        mapView.animate(to: .init(latitude: viewModel.latitude, longitude: viewModel.longitude, zoom: 15))

        viewModel.requestPoints()
        return mapView
    }
    
    func updateUIView(_ mapView: GMSMapView, context: Context) {
        mapView.animate(to: .init(latitude: viewModel.latitude, longitude: viewModel.longitude, zoom: 15))

    }
}
