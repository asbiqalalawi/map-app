//
//  LocationsViewModel.swift
//  MapApp
//
//  Created by SDS.Mac.012 on 01/11/23.
//

import Foundation
import _MapKit_SwiftUI

class LocationsViewModel: ObservableObject {
    
    // All Locations
    @Published var locations: [Location]
    
    // Current Location on map
    @Published var location: Location {
        didSet {
            updateMapRegion(location: location)
        }
    }
    
    @Published var mapRegion = MapCameraPosition.region(MKCoordinateRegion())
    let mapSpan = MKCoordinateSpan(
        latitudeDelta: 0.1,
        longitudeDelta: 0.1
    )
    
    init() {
        let locations = LocationsDataService.locations
        self.locations = locations
        self.location = locations.first!
        
        self.updateMapRegion(location: location)
    }
    
    private func updateMapRegion(location: Location) {
        mapRegion = MapCameraPosition.region(
            MKCoordinateRegion(
                center: location.coordinates,
                span: mapSpan
            )
        )
    }
}
