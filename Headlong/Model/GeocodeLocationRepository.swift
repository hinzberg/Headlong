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
    }
    
    public func add(locationVM : GeocodeLocationViewModel) {
        
        self.geoCodeLocationViewModels.append(locationVM)
        
        do {
            let cdLocation = CDGeocodeLocation(context: self.context)
            cdLocation.id = locationVM.id
            cdLocation.name = locationVM.name
            cdLocation.address1 = locationVM.address1
            cdLocation.address2 = locationVM.address2
            cdLocation.neighbourhood = locationVM.neighborhood
            cdLocation.city = locationVM.city
            cdLocation.state = locationVM.state
            cdLocation.subAdministrativeArea = locationVM.subAdministrativeArea
            cdLocation.zipCode = locationVM.zipCode
            cdLocation.country = locationVM.country
            cdLocation.isoCountryCode = locationVM.isoCountryCode
            cdLocation.regionIdentifier = locationVM.regionIdentifier
            cdLocation.timezone = locationVM.timezone
            cdLocation.date = locationVM.date
            try cdLocation.save()
        } catch {
            print(error)
        }
    }
    
    public func delete(locationVM : GeocodeLocationViewModel)
    {
        self.geoCodeLocationViewModels.removeAll( where: {$0.id == locationVM.id} )
        self.deleteCoreData(locationVM: locationVM)
    }
    
    private func deleteCoreData(locationVM : GeocodeLocationViewModel)
    {
        // Create a fetch request with a string filter for an entity’s name
        let fetchRequest: NSFetchRequest<CDGeocodeLocation>
        fetchRequest = CDGeocodeLocation.fetchRequest()
        fetchRequest.predicate = NSPredicate( format: "id == %@", locationVM.id as CVarArg)
        do {
            let dataModels = try context.fetch(fetchRequest)
            for dataModel in dataModels {
                self.context.delete(dataModel)
            }
        }
        catch {
            print(error)
        }
    }
    
}
