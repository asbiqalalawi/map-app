//
//  LocationMapAnotationView.swift
//  MapApp
//
//  Created by SDS.Mac.012 on 05/11/23.
//

import SwiftUI

struct LocationMapAnotationView: View {
    
    let accentColor = Color("AccentColor")
    
    var body: some View {
        VStack(spacing: 0.0) {
            Image(systemName: "map.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
                .font(.headline)
                .foregroundStyle(.white)
                .padding(6)
                .background(accentColor)
            .cornerRadius(36)
            
            Image(systemName: "triangle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 10, height: 10)
                .foregroundStyle(accentColor)
                .rotationEffect(Angle(degrees: 180))
                .offset(y: -4)
                .padding(.bottom, 40)
        }
    }
}

#Preview {
    ZStack {
        Color.gray.ignoresSafeArea()
        LocationMapAnotationView()
    }
}
