//
//  GeocodeLocationRepository.swift
//  Headlong
//
//  Created by Holger Hinzberg on 03.11.21.
//

import Foundation

public class GeocodeLocationRepository : ObservableObject {
    
    @Published var geoCodeLocations = [GeocodeLocation]()
    
    init() {
        self.geoCodeLocations.append(GeocodeLocation.GetSample())
        self.geoCodeLocations.append(GeocodeLocation.GetSample())
        self.geoCodeLocations.append(GeocodeLocation.GetSample())
    }
        
    public func add( location : GeocodeLocation) {
        self.geoCodeLocations.append(location)
    }
    
    public func delete(location : GeocodeLocation) {
        self.geoCodeLocations.removeAll( where: {$0.id == location.id} )
    }
}
