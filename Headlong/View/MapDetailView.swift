//
//  MapDetailView.swift
//  Headlong
//
//  Created by Holger Hinzberg on 14.10.21.
//

import SwiftUI
import MapKit

struct MapDetailView: View {
    
    var locationController = LocationController()
        
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))

    var body: some View {
        VStack {
            Map(coordinateRegion: $region, showsUserLocation: true, userTrackingMode: .constant(.follow))
            .frame(width: 400, height: 300)
            Spacer()
        }
    }
}


struct MapDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MapDetailView()
    }
}
