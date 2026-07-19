//  StoredLocationMapViewController.swift
//  Headlong
//  Created by Holger Hinzberg on 25.05.22.
//  Copyright © 2022 Holger Hinzberg. All rights reserved.

import Foundation
import MapKit

public class StoredLocationMapViewController: ObservableObject {
    
    @Published var geolocationVM : GeolocationViewModel
    @Published var region : MKCoordinateRegion
    @Published var pointsOfInterest : [MapAnnotatedItem]
        
    init(geolocationVM : GeolocationViewModel)
    {
        self.geolocationVM = geolocationVM
        
        let longitude : CLLocationDegrees = geolocationVM.location!.coordinate.longitude
        let latitude : CLLocationDegrees = geolocationVM.location!.coordinate.latitude
        let span = MKCoordinateSpan(latitudeDelta: 0.008, longitudeDelta: 0.008)
        
        region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: span)
        pointsOfInterest = [ MapAnnotatedItem(name: "", coordinate: geolocationVM.location!.coordinate )]
    }
    
    public func NavigateTo()
    {
    }
    
    public func share()
    {
    }
}
