//
//  MapAppApp.swift
//  MapApp
//
//  Created by SDS.Mac.012 on 01/11/23.
//

import SwiftUI

@main
struct MapAppApp: App {
    
    @StateObject private var vm = LocationsViewModel()
    
    var body: some Scene {
        WindowGroup {
            LocationsView()
                .environmentObject(vm)
        }
    }
}
 
