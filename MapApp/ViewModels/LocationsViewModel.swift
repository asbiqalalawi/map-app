//
//  LocationsViewModel.swift
//  MapApp
//
//  Created by SDS.Mac.012 on 01/11/23.
//

import Foundation

class LocationsViewModel: ObservableObject {
    
    @Published var locations: [Location]
    
    init() {
        let locations = LocationsDataService.locations
        self.locations = locations
    }
}
