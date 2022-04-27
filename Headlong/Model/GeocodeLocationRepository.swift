//  GeocodeLocationRepository.swift
//  Headlong
//  Created by Holger Hinzberg on 03.11.21.

import Foundation
import CoreData

public class GeocodeLocationRepository : ObservableObject {
    
    @Published var geoCodeLocations = [GeocodeLocation]()
    
    var context : NSManagedObjectContext
        
    init(context:NSManagedObjectContext) {
        
        self.context = context
        
        self.geoCodeLocations.append(GeocodeLocation.GetSample())
        self.geoCodeLocations.append(GeocodeLocation.GetSample())
        self.geoCodeLocations.append(GeocodeLocation.GetSample())
    }
        
    public func add( location : GeocodeLocation) {
        
        self.geoCodeLocations.append(location)
        
        do {
            let loc = CDGeocodeLocation(context: self.context)
            loc.id = location.id
            loc.name = location.name
            loc.address1 = location.address1
            loc.address2 = location.address2
            loc.neighbourhood = location.neighborhood
            loc.city = location.city
            loc.state = location.state
            loc.subAdministrativeArea = location.subAdministrativeArea
            loc.zipCode = location.zipCode
            loc.country = location.country
            loc.isoCountryCode = location.isoCountryCode
            loc.regionIdentifier = location.regionIdentifier
            loc.timezone = location.timezone
            loc.date = location.date
            try loc.save()
        } catch {
            print(error)
        }
    }
    
    public func delete(location : GeocodeLocation) {
        self.geoCodeLocations.removeAll( where: {$0.id == location.id} )
    }
}
