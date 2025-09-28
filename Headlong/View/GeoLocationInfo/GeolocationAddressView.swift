//  GeolocationIAddressView.swift
//  Headlong
//  Created by Holger Hinzberg on 30.10.21.

import SwiftUI

struct GeolocationIAddressView: View {
    
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @Binding var geolocation : Geolocation
    
    var body: some View {
        VStack {
            HStack {
                Text("Latitude")
                    .font(.body)
                Spacer()
                Text("\(geolocation.latitude)").font(.body) }
            .padding(EdgeInsets(top: 1, leading: 0, bottom: 0, trailing: 0))
            
            HStack {
                Text("Longitude")
                    .font(.body)
                Spacer()
                Text("\(geolocation.longitude)").font(.body) }
            .padding(EdgeInsets(top: 1, leading: 0, bottom: 0, trailing: 0))
            
            HStack {
                Text("Address")
                    .font(.body)
                Spacer()
                Text("\(geolocation.addressLine1)").font(.body) }
            .padding(EdgeInsets(top: 1, leading: 0, bottom: 0, trailing: 0))
            
            HStack {
                Spacer()
                Text("\(geolocation.addressLine2)")
                .font(.body) }
            .padding(EdgeInsets(top: 1, leading: 0, bottom: 0, trailing: 0))
            
            if !geolocation.addressLine3.isEmpty {
                HStack {
                    Spacer()
                    Text("\(geolocation.addressLine3)")
                        .font(.body)
                }
                .padding(EdgeInsets(top: 1, leading: 0, bottom: 0, trailing: 0))
            }
        }.padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
    }
}

struct GeocodeLocationView_Previews: PreviewProvider {
    static var previews: some View {
        GeolocationIAddressView(geolocation: .constant(Geolocation.GetSample()))
            //.preferredColorScheme(.dark)
    }
}
