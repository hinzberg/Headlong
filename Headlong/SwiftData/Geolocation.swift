//  SDGeolocation.swift
//  Headlong
//  Created by Holger Hinzberg on 04.01.25.
//  Copyright © 2025 Holger Hinzberg. All rights reserved.

// This is the Datamodel class for storing the locations with SwiftData

import Foundation
import SwiftData
import CoreLocation

@Model
public class Geolocation {
    
    @Attribute(.unique) public var id: UUID
    public var name: String?
    public var address1: String?
    public var address2: String?
    public var neighbourhood: String?
    public var city: String?
    public var state: String?
    public var subAdministrativeArea: String?
    public var zipCode: String?
    public var country: String?
    public var isoCountryCode: String?
    public var regionIdentifier: String?
    public var timezone: String?
    public var date: Date?
    public var latitude: Double = 0
    public var longitude: Double = 0
    public var note: String = ""
    public var rating:Int?
    
    var  zipCodeWithCity : String {
        let city : String = self.city ?? ""
        let zip : String = self.zipCode ?? ""
        let value = zip + " " + city
        return value.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    init() {
        self.id = UUID()
    }
    
    init(clPlacemark : CLPlacemark, clLocation : CLLocation)
    {
        self.id = UUID()
        self.longitude = clLocation.coordinate.longitude
        self.latitude = clLocation.coordinate.latitude
        self.name = clPlacemark.name ?? ""
        self.address1 = clPlacemark.thoroughfare ?? ""
        self.address2 = clPlacemark.subThoroughfare ?? ""
        self.neighbourhood = clPlacemark.subLocality ?? ""
        self.city = clPlacemark.locality ?? ""
        self.state = clPlacemark.administrativeArea ?? ""
        self.subAdministrativeArea = clPlacemark.subAdministrativeArea ?? ""
        self.zipCode = clPlacemark.postalCode ?? ""
        self.country = clPlacemark.country ?? ""
        self.isoCountryCode  = clPlacemark.isoCountryCode ?? ""
        self.regionIdentifier = clPlacemark.region?.identifier ?? ""
        self.timezone = clPlacemark.timeZone?.identifier ?? ""
        self.date = Date()
    }
    
    public static func GetSample() -> Geolocation
    {
        let geoLocation = Geolocation()
        geoLocation.latitude = 37.33233141
        geoLocation.longitude = -122.0312186
        geoLocation.name = "Apple Campus"
        geoLocation.address1 = "Infinite Loop"
        geoLocation.address2 = "1"
        geoLocation.neighbourhood = "Cupertino"
        geoLocation.city = "Cupertino"
        geoLocation.state = "CA"
        geoLocation.subAdministrativeArea = "Santa Clara"
        geoLocation.zipCode = "95014"
        geoLocation.country = "United States"
        geoLocation.isoCountryCode  = "US"
        geoLocation.regionIdentifier = "<+37.33213110,-122.02990105> radius 279.38"
        geoLocation.timezone = "America/Los_Angeles"
        return geoLocation
    }
    
}
