//  GeocodeLocationView.swift
//  Headlong
//  Created by Holger Hinzberg on 30.10.21.

import SwiftUI

struct GeocodeLocationView: View {
    
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @Binding var geoData : GeocodeLocation
    
    var body: some View {
        
        VStack {
            HStack {
                Text("Latitude")
                    .font(.body)
                Spacer()
                Text(geoData.latitude).font(.body) }
            .padding(EdgeInsets(top: 5, leading: 5, bottom: 1, trailing: 5))
            
            HStack {
                Text("Longitude")
                    .font(.body)
                Spacer()
                Text(geoData.longitude).font(.body) }
            .padding(EdgeInsets(top: 0, leading: 5, bottom: 1, trailing: 5))
            
            HStack {
                Text("Address")
                    .font(.body)
                Spacer()
                Text(geoData.address).font(.body) }
            .padding(EdgeInsets(top: 0, leading: 5, bottom: 1, trailing: 5))
            
            HStack {
                Spacer()
                Text(geoData.zipCodeWithCity)
                .font(.body) }
            .padding(EdgeInsets(top: 0, leading: 5, bottom: 1, trailing: 5))
            
            HStack {
                Spacer()
                Text(geoData.country)
                .font(.body) }
            .padding(EdgeInsets(top: 0, leading: 5, bottom: 5, trailing: 5))
        }//.background(colorScheme == .dark ? Color.yellow : Color.red)
    }
}

struct GeocodeLocationView_Previews: PreviewProvider {
    static var previews: some View {
        GeocodeLocationView(geoData: .constant(GeocodeLocation.GetSample()))
            //.preferredColorScheme(.dark)
    }
}
