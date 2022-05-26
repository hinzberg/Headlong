//  ShowStoredLocationMapViewController.swift
//  Headlong
//  Created by Holger Hinzberg on 25.05.22.
//  Copyright © 2022 Holger Hinzberg. All rights reserved.

import Foundation
import MapKit

public class ShowStoredLocationMapViewController: ObservableObject {
    
    @Published var geocodeLocationVM : GeocodeLocationViewModel
    @Published var region : MKCoordinateRegion
    @Published var pointsOfInterest : [MapAnnotatedItem]
    
    init(geocodeLocationVM : GeocodeLocationViewModel)
    {
        self.geocodeLocationVM = geocodeLocationVM
        
        let longitude : CLLocationDegrees = geocodeLocationVM.location!.coordinate.longitude
        let latitude : CLLocationDegrees = geocodeLocationVM.location!.coordinate.latitude
        let span = MKCoordinateSpan(latitudeDelta: 0.008, longitudeDelta: 0.008)
        
        region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: span)
        pointsOfInterest = [ MapAnnotatedItem(name: "", coordinate: geocodeLocationVM.location!.coordinate )]
    }
    
    public func NavigateTo()
    {
    }
    
    public func share()
    {
    }
}
