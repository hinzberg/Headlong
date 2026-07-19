//  GeolocationTableCellView.swift
//  Headlong
//  Created by Holger Hinzberg on 19.07.26.

import SwiftUI
import Hinzberg_SwiftUI

struct GeolocationTableCellView: View {
    
    private var locationVM : GeolocationViewModel
    
    public init(geolocation: Geolocation) {
        self.locationVM = GeolocationViewModel(geolocation: geolocation)
    }
    
    var body: some View {
        HStack {
            VStack {
                HStack {
                    Text(locationVM.dateFormatted)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    Spacer()
                }
                HStack {
                    Text(locationVM.name)
                        .font(.subheadline)
                        .foregroundColor(.primary)
                    Spacer()
                }
                HStack {
                    Text(locationVM.zipCodeWithCityAndCountry)
                        .font(.subheadline)
                        .foregroundColor(.primary)
                    Spacer()
                }
            }
            Image(systemName: "chevron.right")
                .foregroundColor(.secondary)
        }
        .padding()
        .ShadowPanel()
    }
}

struct GeolocationTableCellView_Previews: PreviewProvider {
    static var previews: some View {
        GeolocationTableCellView(geolocation: Geolocation.GetSample())
    }
}
