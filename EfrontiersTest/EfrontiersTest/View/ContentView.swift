//
//  ContentView.swift
//  EfrontiersTest
//
//  Created by Xavi Tordera on 08/07/2020.
//  Copyright © 2020 Xavi Tordera. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewModel: MapViewModel
    var body: some View {
        MapView(viewModel: viewModel)
        
            .edgesIgnoringSafeArea(.all)
    }
}
