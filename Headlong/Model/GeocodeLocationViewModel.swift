//  GeocodeLocationViewModel.swift
//  Headlong
//  Created by Holger Hinzberg on 30.10.21.

import CoreLocation

public class GeocodeLocationViewModel
{
    public var id = UUID()
    public var location : CLLocation?
    public var name : String
    public var address1 : String
    public var address2 : String
    public var neighborhood : String
    public var city : String
    public var state : String
    public var subAdministrativeArea : String
    public var zipCode : String
    public var country : String
    public var isoCountryCode : String
    public var regionIdentifier : String
    public var timezone : String
    public var date : Date
    
    init()
    {
        self.name = ""
        self.address1 = ""
        self.address2 = ""
        self.neighborhood = ""
        self.city = ""
        self.state = ""
        self.subAdministrativeArea = ""
        self.zipCode = ""
        self.country = ""
        self.isoCountryCode  = ""
        self.regionIdentifier = ""
        self.timezone = ""
        self.date = Date()
    }
    
    public static func GetSample() -> GeocodeLocationViewModel
    {
        let geoLocation = GeocodeLocationViewModel()
        geoLocation.location = CLLocation(latitude: 37.33233141, longitude: -122.0312186)
        geoLocation.name = "Apple Campus"
        geoLocation.address1 = "Infinite Loop"
        geoLocation.address2 = "1"
        geoLocation.neighborhood = "Cupertino"
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
 
    init( cdLocation : CDGeocodeLocation)
    {
        self.id = cdLocation.id ?? UUID.init()
        self.location = CLLocation(latitude: cdLocation.latitude, longitude: cdLocation.longitude)
        self.name = cdLocation.name ?? ""
        self.address1 = cdLocation.address1 ?? ""
        self.address2 = cdLocation.address2 ?? ""
        self.neighborhood = cdLocation.neighbourhood ?? ""
        self.city = cdLocation.city ?? ""
        self.state = cdLocation.state ?? ""
        self.subAdministrativeArea = cdLocation.subAdministrativeArea ?? ""
        self.zipCode = cdLocation.zipCode ?? ""
        self.country = cdLocation.country ?? ""
        self.isoCountryCode  = cdLocation.isoCountryCode ?? ""
        self.regionIdentifier = cdLocation.regionIdentifier ?? ""
        self.timezone = cdLocation.timezone ?? ""
        self.date = cdLocation.date ?? Date()
    }
    
    init( placemark : CLPlacemark, location : CLLocation)
    {
        self.location = location
        self.name = placemark.name ?? ""
        self.address1 = placemark.thoroughfare ?? ""
        self.address2 = placemark.subThoroughfare ?? ""
        self.neighborhood = placemark.subLocality ?? ""
        self.city = placemark.locality ?? ""
        self.state = placemark.administrativeArea ?? ""
        self.subAdministrativeArea = placemark.subAdministrativeArea ?? ""
        self.zipCode = placemark.postalCode ?? ""
        self.country = placemark.country ?? ""
        self.isoCountryCode  = placemark.isoCountryCode ?? ""
        self.regionIdentifier = placemark.region?.identifier ?? ""
        self.timezone = placemark.timeZone?.identifier ?? ""
        self.date = Date()
    }
    
    var  latitude : String {
        if let value = location?.coordinate.latitude
        {
            return String(value)
        }
        return ""
    }
    
    var  longitude : String {
        if let value = location?.coordinate.longitude
        {
            return String(value)
        }
        return ""
    }
    
    var  zipCodeWithCity : String {
        let value = self.zipCode + " " + self.city
        return value.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    var  zipCodeWithCityAndCountry : String {
        var value = self.zipCode + " " + self.city
        if self.country != "" {
            value += ", " + self.country
        }
        return value.trimmingCharacters(in: .whitespacesAndNewlines)
    }
        
    var  address : String {
        let value = self.address1 + " " + self.address2
        return value.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    var dateFormatted : String {
        let formatter = DateFormatter()
        formatter.setLocalizedDateFormatFromTemplate("dd MMM y HH:mm")
        return formatter.string(from: self.date)
    }
    
    public func getLocationForShare() -> String
    {
        var locationText = "I am here:\n\n"
        if  name != "" { locationText += name + "\n" }
        // if  address1 != "" { locationText += address1 + "\n" }
        // if  address2 != "" { locationText += address2 + "\n" }
        // if  neighborhood != "" { locationText += neighborhood + "\n" }
        // if  subAdministrativeArea != "" { locationText += subAdministrativeArea + "\n" }
        if  zipCode != "" && city == "" { locationText += zipCode + "\n" }
        if  zipCode == "" && city != "" { locationText += city + "\n" }
        if  zipCode != "" && city != "" { locationText += zipCode + " " + city + "\n" }
        if  state != "" { locationText += state + "\n" }
        if  country != "" { locationText += country + "\n" }
        locationText += "\n"
        if  latitude != "" { locationText += "Latitude: " + latitude + "\n" }
        if  longitude != "" { locationText += "Longitude: " + longitude + "\n" }
        return locationText
    }
        
    public func debugProperties ()
    {
        print("latitude:", location?.coordinate.latitude ?? "")
        print("longitude:", location?.coordinate.longitude ?? "")
        print("name:", name )
        print("address1:", address1)
        print("address2:", address2)
        print("neighborhood:", neighborhood)
        print("city:", city)
        print("state:", state)
        print("subAdministrativeArea:", subAdministrativeArea)
        print("zip code:", zipCode)
        print("country:", country)
        print("isoCountryCode:", isoCountryCode)
        print("region identifier:", regionIdentifier)
        print("timezone:", timezone , terminator: "\n\n")
    }
}
