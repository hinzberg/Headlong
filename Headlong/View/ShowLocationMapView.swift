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

    @State private var geocodeLocationVM : GeocodeLocationViewModel
    @State private var region : MKCoordinateRegion
    @State private var pointsOfInterest : [MapAnnotatedItem]
    
    init(geocodeLocationVM : GeocodeLocationViewModel)
    {
        self.geocodeLocationVM = geocodeLocationVM
        let longitude : CLLocationDegrees = geocodeLocationVM.location!.coordinate.longitude
        let latitude : CLLocationDegrees = geocodeLocationVM.location!.coordinate.latitude
        let span = MKCoordinateSpan(latitudeDelta: 0.008, longitudeDelta: 0.008)
        self.region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: span)
        self.pointsOfInterest = [ MapAnnotatedItem(name: "Times Square", coordinate: geocodeLocationVM.location!.coordinate )]
    }
    
    var body: some View {
        VStack {
         Map(coordinateRegion: $region, showsUserLocation: true, annotationItems: pointsOfInterest ){ item in
             MapAnnotation(coordinate: item.coordinate) { MapAnnotationView() }
         }
         GeocodeLocationView(locationVM: $geocodeLocationVM)
        }
    }
}

struct ShowLocationMapView_Previews: PreviewProvider {
    static var previews: some View {
        ShowLocationMapView(geocodeLocationVM:  GeocodeLocationViewModel.GetSample())
    }
}
