//  GeocodeLocationRepository.swift
//  Headlong
//  Created by Holger Hinzberg on 03.11.21.

import Foundation
import CoreData

public class GeocodeLocationRepository : ObservableObject {
    
    @Published var geoCodeLocationViewModels = [GeocodeLocationViewModel]()
    
    var context : NSManagedObjectContext
        
    init(context:NSManagedObjectContext) {
        
        self.context = context
        
        self.geoCodeLocationViewModels.append(GeocodeLocationViewModel.GetSample())
        self.geoCodeLocationViewModels.append(GeocodeLocationViewModel.GetSample())
        self.geoCodeLocationViewModels.append(GeocodeLocationViewModel.GetSample())
    }
        
    public func add( locationVM : GeocodeLocationViewModel) {
        
        self.geoCodeLocationViewModels.append(locationVM)
        
        do {
            let loc = CDGeocodeLocation(context: self.context)
            loc.id = locationVM.id
            loc.name = locationVM.name
            loc.address1 = locationVM.address1
            loc.address2 = locationVM.address2
            loc.neighbourhood = locationVM.neighborhood
            loc.city = locationVM.city
            loc.state = locationVM.state
            loc.subAdministrativeArea = locationVM.subAdministrativeArea
            loc.zipCode = locationVM.zipCode
            loc.country = locationVM.country
            loc.isoCountryCode = locationVM.isoCountryCode
            loc.regionIdentifier = locationVM.regionIdentifier
            loc.timezone = locationVM.timezone
            loc.date = locationVM.date
            try loc.save()
        } catch {
            print(error)
        }
    }
    
    public func delete(location : GeocodeLocationViewModel) {
        self.geoCodeLocationViewModels.removeAll( where: {$0.id == location.id} )
    }
}
