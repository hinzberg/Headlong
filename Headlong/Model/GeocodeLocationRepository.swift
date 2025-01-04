//  GeocodeLocationRepository.swift
//  Headlong
//  Created by Holger Hinzberg on 03.11.21.

import Foundation
import CoreData

public class GeocodeLocationRepository : NSObject, ObservableObject, NSFetchedResultsControllerDelegate
{
    // Public Property of all the Locations
    @Published var geoCodeLocationViewModels = [GeocodeLocationViewModel]()
   
    // Grouping per date, will be used for TableView Section Headers
    private var dateGroups = [DateGroup]()
    @Published var filledDateGroups = [DateGroup]()
        
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
        
        /*
        self.executeFetch()
        
        self.createDateGroups()
        self.fillDateGroups()
        self.setFilledDateGroups()
        */
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
    
    private func fillViewModelsAfterFetch()
    {
        self.geoCodeLocationViewModels.removeAll()
        guard let results = fetchedResultController.fetchedObjects else { return }
        for result in results {
            let vm = GeocodeLocationViewModel(cdLocation: result)
            self.geoCodeLocationViewModels.append(vm)
        }
    }
        
    // Will be called automaticly after fetch
    public func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.fillViewModelsAfterFetch()
    }
    
    private func createDateGroups()
    {
        dateGroups.removeAll()
        
        // Today
        let aDay:TimeInterval = 60*60*23 + 60*59 + 59
        let todayStart = Calendar.current.startOfDay(for: Date())
        let todayEnd = todayStart.addingTimeInterval(aDay)
        var dateVM = DateGroup(start: todayStart, end: todayEnd, description: "Today")
        dateGroups.append(dateVM)
                
        // This week
        let startOfThisWeek = Date().startOfWeek
        var endOfThisWeek =  Calendar.current.date(byAdding: .day, value: 7, to: startOfThisWeek!)
        endOfThisWeek =  Calendar.current.date(byAdding: .second, value: -1, to: endOfThisWeek!)
        dateVM = DateGroup(start: startOfThisWeek!, end: endOfThisWeek!, description: "This Week")
        dateGroups.append(dateVM)
        
        // Last Week
        let startOfLastWeek = Calendar.current.date(byAdding: .weekOfYear, value: -1, to: startOfThisWeek!)
        var endOfLastWeek = Calendar.current.date(byAdding: .day, value: -1, to: startOfThisWeek!)
        endOfLastWeek = Calendar.current.date(byAdding: .second, value: -1, to: endOfLastWeek!)
        dateVM = DateGroup(start: startOfLastWeek!, end: endOfLastWeek!, description: "Last Week")
        dateGroups.append(dateVM)
        
        // This month, excluding the weeks
        let startOfThisMonth = Date().startOfMonth
        var endOfThisMonth = Calendar.current.date(byAdding: .day, value: -1, to: startOfLastWeek!)
        endOfThisMonth = Calendar.current.date(byAdding: .second, value: -1, to: endOfThisMonth!)
        dateVM = DateGroup(start: startOfThisMonth!, end: endOfThisMonth!, description: "This Month")
        dateGroups.append(dateVM)
        
        // Last month
        let startOfLastMonth = Calendar.current.date(byAdding: .month, value: -1, to: startOfThisMonth!)
        var endOfLastMonth = startOfLastMonth?.endOfMonth
        endOfLastMonth = endOfLastMonth?.addingTimeInterval(aDay)
        dateVM = DateGroup(start: startOfLastMonth!, end: endOfLastMonth!, description: "Last Month")
        dateGroups.append(dateVM)
        
        // This year, excluding the month
        let startOfThisYear = startOfLastMonth!.startOfYear
        var endOfThisYear = Calendar.current.date(byAdding: .day, value: -1, to: startOfLastMonth!)
        endOfThisYear = endOfThisYear?.addingTimeInterval(aDay)
        dateVM = DateGroup(start: startOfThisYear!, end: endOfThisYear!, description: "This Year")
        dateGroups.append(dateVM)

        // Last year
        let startOfLastYear = Calendar.current.date(byAdding: .year, value: -1, to: Date().startOfYear!)
        var endOfLastYear = Calendar.current.date(byAdding: .year, value: -1, to: Date().endOfYear!)
        endOfLastYear = endOfLastYear?.addingTimeInterval(aDay)
        dateVM = DateGroup(start: startOfLastYear!, end: endOfLastYear!, description: "Last Year")
        dateGroups.append(dateVM)
        
        // Everything before this year
        let startOfOlder = Date().zero
        var endOfOlder =  Calendar.current.date(byAdding: .day, value: -1, to: startOfLastYear!)
        endOfOlder = endOfOlder?.addingTimeInterval(aDay)
        dateVM = DateGroup(start: startOfOlder!, end: endOfOlder!, description: "Older")
        dateGroups.append(dateVM)

        for d in dateGroups {
            print("\(d.startDateTimeFormated) to \(d.endDateTimeFormated) \(d.dateDescription)")
        }
    }
    
    private func fillDateGroups()
    {
        for dateGroup in dateGroups {
            dateGroup.geoCodeLocationViewModels.removeAll()
            for model in geoCodeLocationViewModels {
                print(dateGroup.dateDescription)
                if model.date >= dateGroup.startDate && model.date <= dateGroup.endDate {
                    print(model.getShortDescription())
                    dateGroup.geoCodeLocationViewModels.append(model)
                }
            }
        }
    }
    
    private func setFilledDateGroups()
    {
        self.filledDateGroups.removeAll()
        for dateGroup in dateGroups {
            if !dateGroup.geoCodeLocationViewModels.isEmpty {
                self.filledDateGroups.append(dateGroup)
            }
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
