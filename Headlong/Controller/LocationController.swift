// LocationController.swift
//  Headlong
//  Created by Holger Hinzberg on 29.10.21.

import UIKit
import CoreLocation
import MapKit

public class LocationController : NSObject, CLLocationManagerDelegate, ObservableObject {
    
    @Published private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
    
    // @Published var userLocation: CLLocation!
    @Published var geocodeLocation = GeocodeLocationViewModel.GetSample()
    
    var locationManager: CLLocationManager?
    
    public override init() {
        super.init()
        
        locationManager = CLLocationManager()
        locationManager!.delegate = self
        locationManager!.requestWhenInUseAuthorization()
        locationManager!.allowsBackgroundLocationUpdates = true
        geocodeLocation = GeocodeLocationViewModel.GetSample()
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
    
    // Called automaticly
    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        //fatalError(error.localizedDescription)
    }
    
    // Called automaticly
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        if  let location = locations.last
        {
            self.reverseGeoCoding(location: location)
        }
    }
    
    private func reverseGeoCoding(location : CLLocation)
    {
        let loca = CLLocation(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        
        loca.geocode { placemark, error in
            if let error = error as? CLError
            {
                print("CLError:", error)
                return
            }
            else if let placemark = placemark?.first
            {
                let geoLocation = GeocodeLocationViewModel(placemark: placemark, location: loca )
                DispatchQueue.main.async
                {
                    geoLocation.debugProperties()
                    self.geocodeLocation = geoLocation
                }
            }
        }
    }
}
