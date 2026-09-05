//  Geolocation.swift
//  Headlong
//  Created by Holger Hinzberg on 04.01.25.
//  Copyright © 2025 Holger Hinzberg. All rights reserved.
// This is the Datamodel class for storing the locations with SwiftData

import Foundation
import SwiftData
import MapKit

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
    public var isFavorite: Bool = false
    
    // These properties do not need to be saved
    // These are for display only
    
    @Transient
    public var addressLine1 : String = ""
    @Transient
    public var addressLine2 : String = ""
    @Transient
    public var addressLine3 : String = ""
    @Transient
    public var zipCodeWithCity : String = ""
    
    init() {
        self.id = UUID()
    }
    
    init(mapItem : MKMapItem)
    {
        self.id = UUID()
        self.longitude = mapItem.location.coordinate.longitude
        self.latitude = mapItem.location.coordinate.latitude
        self.name = mapItem.name ?? ""
        self.address1 = mapItem.address?.fullAddress ?? ""
        self.address2 = mapItem.address?.shortAddress ?? ""
        self.date = Date()
        self.SetAddressLines()
    }
    
    private func SetAddressLines()
    {
        var lines = [String]()
        
        if ( !isNilOrEmpty(self.address1) ){
            lines.append(self.address1!)
        }
        
        if (!isNilOrEmpty(self.city))
        {
            let city : String = self.city ?? ""
            let zip : String = self.zipCode ?? ""
            var value = zip + " " + city
            value =  value.trimmingCharacters(in: .whitespacesAndNewlines)
            lines.append(value)
            self.zipCodeWithCity = value
        }
        
        if (!isNilOrEmpty(self.country)){
            lines.append(self.country!)
        }
        
        if (lines.count > 0) {
            self.addressLine1 = lines[0]
        }
        
        if (lines.count > 1) {
            self.addressLine2 = lines[1]
        }
        
        if (lines.count > 2) {
            self.addressLine3 = lines[2]
        }
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
        geoLocation.SetAddressLines()
        return geoLocation
    }
}