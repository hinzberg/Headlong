//  GeocodeLocationRepository.swift
//  Headlong
//  Created by Holger Hinzberg on 03.11.21.

import Foundation
import CoreData

public class GeocodeLocationRepository : NSObject, ObservableObject, NSFetchedResultsControllerDelegate{
    
    @Published var geoCodeLocationViewModels = [GeocodeLocationViewModel]()
    
    private var context : NSManagedObjectContext
    private var fetchedResultController : NSFetchedResultsController<CDGeocodeLocation>
    
    init(context:NSManagedObjectContext)
    {
        // Setup FetchedResultsController and execute Fetch
        self.context = context
        self.fetchedResultController = NSFetchedResultsController(fetchRequest: CDGeocodeLocation.all, managedObjectContext:
                                                            context, sectionNameKeyPath: nil, cacheName: nil)
        super.init()
        self.fetchedResultController.delegate = self
        self.executeFetch()
    }
    
    public func executeFetch()
    {
        do  {
            self.geoCodeLocationViewModels.removeAll()
            try fetchedResultController.performFetch()
                        
            guard let results = fetchedResultController.fetchedObjects else { return }
            for result in results {
                self.geoCodeLocationViewModels.append(GeocodeLocationViewModel(cdLocation: result))
            }
            
        } catch {
            let fetchError = error as NSError
            print("\(fetchError), \(fetchError.localizedDescription)")
        }
    }
    
    public func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>)
    {
        geoCodeLocationViewModels.removeAll()
        guard let results = controller.fetchedObjects as? [CDGeocodeLocation] else {  return }
        for result in results {
            geoCodeLocationViewModels.append(GeocodeLocationViewModel(cdLocation: result))
        }
    }
    
    // Add Location to Array and CoreData
    public func add(locationVM : GeocodeLocationViewModel) {
        
        self.geoCodeLocationViewModels.append(locationVM)
        
        do {
            let cdLocation = CDGeocodeLocation(context: self.context)
            cdLocation.longitude = locationVM.location?.coordinate.longitude ?? 0
            cdLocation.latitude = locationVM.location?.coordinate.latitude ?? 0
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
    
    // Delete Location from Array and CoreData
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
            try? self.context.save()
        }
        catch {
            print(error)
        }
    }
}
