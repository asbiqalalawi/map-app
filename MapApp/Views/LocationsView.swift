//
//  LocationsView.swift
//  MapApp
//
//  Created by SDS.Mac.012 on 01/11/23.
//

import SwiftUI
import MapKit

struct LocationsView: View {
    
    @EnvironmentObject private var vm: LocationsViewModel
    
    var body: some View {
        ZStack {
            mapLayer
            VStack() {
                header
                    .padding()
                Spacer()
                locationPreviewStack
            }
        }
    }
}

#Preview {
    LocationsView()
        .environmentObject(LocationsViewModel())
}

extension LocationsView {
    
    private var header: some View {
        VStack {
            Button(action: vm.toogleLocationsList) {
                Text(vm.location.name + ", " + vm.location.cityName)
                    .font(.title2)
                    .fontWeight(.black)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .animation(.none, value: vm.location)
                    .overlay(alignment: .leading) {
                        Image(systemName: "arrow.down")
                            .font(.headline)
                            .padding()
                            .rotationEffect(Angle(degrees: vm.showLocationsList ? 180 : 0))
                    }
                    .foregroundStyle(.black)
            }
            
            if vm.showLocationsList {
                LocationsListView()
            }
        }
        .background(.thickMaterial)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.3), radius: 20, x: 0, y: 15)
    }
    
    private var mapLayer: some View {
        Map(position: $vm.mapRegion) {
            ForEach(vm.locations) { location in
                Annotation(location.cityName, coordinate: location.coordinates) {
                    LocationMapAnotationView()
                        .scaleEffect(vm.location == location ? 1 : 0.7)
                        .shadow(radius: 10)
                        .onTapGesture {
                            vm.changeFocusLocation(location: location)
                        }
                }
            }
        }
    }
    
    private var locationPreviewStack: some View {
        ZStack {
            ForEach(vm.locations) { location in
                if (vm.location == location) {
                    LocationPreviewView(location: location)
                        .shadow(color: /*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/.opacity(0.3), radius: 20)
                        .padding()
                        .transition(.asymmetric(
                            insertion: .move(edge: .trailing),
                            removal: .move(edge: .leading)
                        ))
                }
            }
        }
    }
}
