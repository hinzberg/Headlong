// LocationController.swift
//  Headlong
//  Created by Holger Hinzberg on 29.10.21.

import UIKit
import CoreLocation
import MapKit

public class LocationController : NSObject, CLLocationManagerDelegate, ObservableObject {
    
    @Published private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
    
    @Published var userLocation: CLLocation!
    
    var locationManager: CLLocationManager?
    
    public override init() {
        super.init()
        
        locationManager = CLLocationManager()
        locationManager!.delegate = self
        locationManager!.requestWhenInUseAuthorization()
        locationManager!.allowsBackgroundLocationUpdates = true
    }
    
    public func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus)
    {
        if status == .authorizedAlways || status == .authorizedWhenInUse
        {
            print("You have authorisation to get locations")
            self.locationManager!.requestLocation()
            self.locationManager!.startUpdatingLocation()
        }
        else
        {
            print("You have no authorisation to get locations")
        }
    }
    
    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
            fatalError(error.localizedDescription)
        }
    
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // print(locations.last?.coordinate.latitude ?? "None")
        // print(locations.last?.coordinate.longitude ?? "None")
        self.userLocation = locations.last
    }
}
