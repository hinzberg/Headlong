//  GeocodeLocationView.swift
//  Headlong
//  Created by Holger Hinzberg on 30.10.21.

import SwiftUI

struct GeocodeLocationView: View {
    
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @Binding var locationVM : GeocodeLocationViewModel
    
    var body: some View {
        
        VStack {
            HStack {
                Text("Latitude")
                    .font(.body)
                Spacer()
                Text(locationVM.latitude).font(.body) }
            .padding(EdgeInsets(top: 5, leading: 5, bottom: 1, trailing: 5))
            
            HStack {
                Text("Longitude")
                    .font(.body)
                Spacer()
                Text(locationVM.longitude).font(.body) }
            .padding(EdgeInsets(top: 0, leading: 5, bottom: 1, trailing: 5))
            
            HStack {
                Text("Address")
                    .font(.body)
                Spacer()
                Text(locationVM.address).font(.body) }
            .padding(EdgeInsets(top: 0, leading: 5, bottom: 1, trailing: 5))
            
            HStack {
                Spacer()
                Text(locationVM.zipCodeWithCity)
                .font(.body) }
            .padding(EdgeInsets(top: 0, leading: 5, bottom: 1, trailing: 5))
            
            HStack {
                Spacer()
                Text(locationVM.country)
                .font(.body) }
            .padding(EdgeInsets(top: 0, leading: 5, bottom: 5, trailing: 5))
        }//.background(colorScheme == .dark ? Color.yellow : Color.red)
    }
}

struct GeocodeLocationView_Previews: PreviewProvider {
    static var previews: some View {
        GeocodeLocationView(locationVM: .constant(GeocodeLocationViewModel.GetSample()))
            //.preferredColorScheme(.dark)
    }
}
