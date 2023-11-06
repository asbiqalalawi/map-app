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
    
    // Regio map detail
    @Published var mapRegionDetail = MapCameraPosition.region(MKCoordinateRegion()) {
        didSet {
            
        }
    }
    let mapSpanDetail = MKCoordinateSpan(
        latitudeDelta: 0.01,
        longitudeDelta: 0.01
    )
    
    // Show list of location
    @Published var showLocationsList: Bool = false
    
    // Show location detail via sheet
    @Published var sheetLocation: Location? = nil
    
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
            mapRegionDetail = MapCameraPosition.region(
                MKCoordinateRegion(
                    center: location.coordinates,
                    span: mapSpanDetail
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
    
    func nextButtonPressed() {
        
        // Get current index
        guard let currentIndex = locations.firstIndex(where: { $0 == location }) else {
            print("Could not find current index in locations array! Should never happen.")
            return
        }
        
        // Check if the nextIndex is valid
        let nextIndex = currentIndex + 1
        guard locations.indices.contains(nextIndex) else {
            // nextIndex is Not valid
            // Restart from 0
            guard let firstLocation = locations.first else { return }
            changeFocusLocation(location: firstLocation)
            return
        }
        
        // nextIndex is valid
        let nextLocation = locations[nextIndex]
        changeFocusLocation(location: nextLocation)
    }
}
