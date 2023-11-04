//
//  LocationsViewModel.swift
//  MapApp
//
//  Created by SDS.Mac.012 on 01/11/23.
//

import Foundation
import _MapKit_SwiftUI
import SwiftUI

class LocationsViewModel: ObservableObject {
    
    // All Locations
    @Published var locations: [Location]
    
    // Current Location on map
    @Published var location: Location {
        didSet {
            updateMapRegion(location: location)
        }
    }
    
    // Current region map
    @Published var mapRegion = MapCameraPosition.region(MKCoordinateRegion())
    let mapSpan = MKCoordinateSpan(
        latitudeDelta: 0.1,
        longitudeDelta: 0.1
    )
    
    // Show list of location
    @Published var showLocationsList: Bool = false
    
    init() {
        let locations = LocationsDataService.locations
        self.locations = locations
        self.location = locations.first!
        
        self.updateMapRegion(location: location)
    }
    
    private func updateMapRegion(location: Location) {
        withAnimation(.easeInOut, {
            mapRegion = MapCameraPosition.region(
                MKCoordinateRegion(
                    center: location.coordinates,
                    span: mapSpan
                )
            )
        })
    }
    
    func toogleLocationsList() {
        withAnimation(.easeInOut, {
            showLocationsList.toggle()
        })
        
    }
    
    func changeFocusLocation(location: Location) {
        withAnimation(.easeInOut, {
            self.location = location
            showLocationsList = false
        })
    }
}
