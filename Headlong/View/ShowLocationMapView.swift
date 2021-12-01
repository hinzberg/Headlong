//
//  ShowLocationMapView.swift
//  Headlong
//
//  Created by Holger Hinzberg on 01.12.21.
//  Copyright © 2021 Holger Hinzberg. All rights reserved.
//

import SwiftUI
import MapKit

struct ShowLocationMapView: View {

    @State private var geocodeLocation : GeocodeLocation
    @State private var region : MKCoordinateRegion
    @State private var pointsOfInterest : [MapAnnotatedItem]
    
    init(geocodeLocation : GeocodeLocation)
    {
        self.geocodeLocation = geocodeLocation
        let longitude : CLLocationDegrees = geocodeLocation.location!.coordinate.longitude
        let latitude : CLLocationDegrees = geocodeLocation.location!.coordinate.latitude
        let span = MKCoordinateSpan(latitudeDelta: 0.008, longitudeDelta: 0.008)
        self.region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: span)
        self.pointsOfInterest = [ MapAnnotatedItem(name: "Times Square", coordinate: geocodeLocation.location!.coordinate )]
    }
    
    var body: some View {
        VStack {
         Map(coordinateRegion: $region, showsUserLocation: true, annotationItems: pointsOfInterest ){ item in
             MapAnnotation(coordinate: item.coordinate) { MapAnnotationView() }
         }
         GeocodeLocationView(geoData: $geocodeLocation)
        }
    }
}

struct ShowLocationMapView_Previews: PreviewProvider {
    static var previews: some View {
        ShowLocationMapView(geocodeLocation:  GeocodeLocation.GetSample())
    }
}
