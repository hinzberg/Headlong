//  GeocodeLocationRepository.swift
//  Headlong
//  Created by Holger Hinzberg on 03.11.21.

import Foundation
import CoreData

public class GeocodeLocationRepository : NSObject, ObservableObject, NSFetchedResultsControllerDelegate
{
    // Public Property of all the Locations
    @Published var geoCodeLocationViewModels = [GeocodeLocationViewModel]()
    // Grouping per date, can be used for tableView Section Headers
    @Published var dateGroups = [DateViewModel]()
    
    private var allDateGroups = [DateViewModel]()
    
    private var context : NSManagedObjectContext
    private var fetchedResultController : NSFetchedResultsController<CDGeocodeLocation>
    
    init(context:NSManagedObjectContext)
    {
        // Setup FetchedResultsController
        self.context = context
        self.fetchedResultController = NSFetchedResultsController(fetchRequest: CDGeocodeLocation.all, managedObjectContext:
                                                            context, sectionNameKeyPath: nil, cacheName: nil)
       
        // Add a SortDescription
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: false)
        self.fetchedResultController.fetchRequest.sortDescriptors = [sortDescriptor]
        
        super.init()
        self.fetchedResultController.delegate = self
        
        self.createAllDateGroups()
                
        self.executeFetch()
    }
    
    public func executeFetch()
    {
        do  {
            try fetchedResultController.performFetch()
            self.fillViewModelsAfterFetch()
        } catch {
            let fetchError = error as NSError
            print("\(fetchError), \(fetchError.localizedDescription)")
        }
    }
    
    private func fillViewModelsAfterFetch() {
        self.geoCodeLocationViewModels.removeAll()
        guard let results = fetchedResultController.fetchedObjects else { return }
        for result in results {
            self.geoCodeLocationViewModels.append(GeocodeLocationViewModel(cdLocation: result))
        }
    }
        
    // Will be called automaticly after fetch
    public func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.fillViewModelsAfterFetch()
    }
    
    private func createAllDateGroups()
    {
        allDateGroups.removeAll()
        
        // Today
        let today = Date()
        var dateVM = DateViewModel(start: today, end: today, description: "Today")
        allDateGroups.append(dateVM)
                
        // This week
        let startOfThisWeek = Date().startOfWeek
        let endOfThisWeek =  Calendar.current.date(byAdding: .day, value: -1, to: today)
        dateVM = DateViewModel(start: startOfThisWeek!, end: endOfThisWeek!, description: "This Week")
        allDateGroups.append(dateVM)
        
        // Last Week
        let startOfLastWeek = Calendar.current.date(byAdding: .weekOfYear, value: -1, to: startOfThisWeek!)
        let endOfLastWeek = Calendar.current.date(byAdding: .day, value: -1, to: startOfThisWeek!)
        dateVM = DateViewModel(start: startOfLastWeek!, end: endOfLastWeek!, description: "Last Week")
        allDateGroups.append(dateVM)
        
        // This month, excluding the weeks
        let startOfThisMonth = Date().startOfMonth
        let endOfThisMonth = Calendar.current.date(byAdding: .day, value: -1, to: startOfLastWeek!)
        dateVM = DateViewModel(start: startOfThisMonth!, end: endOfThisMonth!, description: "This Month")
        allDateGroups.append(dateVM)
        
        // Last month
        let startOfLastMonth = Calendar.current.date(byAdding: .month, value: -1, to: startOfThisMonth!)
        let endOfLastMonth = startOfLastMonth?.endOfMonth
        dateVM = DateViewModel(start: startOfLastMonth!, end: endOfLastMonth!, description: "Last Month")
        allDateGroups.append(dateVM)
        
        // This year, excluding the month
        let startOfThisYear = startOfLastMonth!.startOfYear
        let endOfThisYear = Calendar.current.date(byAdding: .day, value: -1, to: startOfLastMonth!)
        dateVM = DateViewModel(start: startOfThisYear!, end: endOfThisYear!, description: "This Year")
        allDateGroups.append(dateVM)

        // Last year
        let startOfLastYear = Calendar.current.date(byAdding: .year, value: -1, to: Date().startOfYear!)
        let endOfLastYear = Calendar.current.date(byAdding: .year, value: -1, to: Date().endOfYear!)
        dateVM = DateViewModel(start: startOfLastYear!, end: endOfLastYear!, description: "Last Year")
        allDateGroups.append(dateVM)
        
        // Everything before this year
        let startOfOlder = Date().zero
        let endOfOlder =  Calendar.current.date(byAdding: .day, value: -1, to: startOfLastYear!)
        dateVM = DateViewModel(start: startOfOlder!, end: endOfOlder!, description: "Older")
        allDateGroups.append(dateVM)

        for d in allDateGroups {
            print("\(d.startDateFormated) \(d.endDateFormated) \(d.dateDescription)")
        }
    }
    
    private func getViewModelsInTimespan( startDate : Date, endDate : Date) -> [GeocodeLocationViewModel] {
        
        let vms = geoCodeLocationViewModels.filter { vm in
            vm.date >= startDate && vm.date < endDate
        }
        return vms
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
