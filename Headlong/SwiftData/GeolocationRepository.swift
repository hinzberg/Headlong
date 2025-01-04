//  GeolocationRepository.swift
//  Headlong
//  Created by Holger Hinzberg on 04.01.25.
//  Copyright © 2025 Holger Hinzberg. All rights reserved.

import SwiftData
import SwiftUI

// https://dev.to/jameson/swiftui-with-swiftdata-through-repository-36d1

final class GeolocationRepository : GeolocationRepositoryProtocol, Observable, ObservableObject{
        
        private let modelContainer: ModelContainer!
        private let modelContext: ModelContext!

        @MainActor
        static let shared = GeolocationRepository()

        @MainActor
        private init() {
            self.modelContainer =  GeolocationRepository.createModelContainer()
            self.modelContext = modelContainer.mainContext
        }
    
    @MainActor
    static func createModelContainer() -> ModelContainer {
        
        let schema = Schema([ Geolocation.self ])
        
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        do {
            let container = try ModelContainer(for: schema, configurations: [modelConfiguration])
            // checkForDefaults(container: container)
            return container
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }
    
    @MainActor
    private static func checkForDefaults(container : ModelContainer) {
           
        // This function can be used to create default entries in the datastore
        // But we don't need that here
        
        /*
        let locationCount = (try? container.mainContext.fetchCount(FetchDescriptor<Geolocation>())) ?? 0
        if  locationCount == 0 {
            print("No Settings found. Creating default")
            container.mainContext.insert( Geolocation ())
        }
        */
    }
       
    
    
     func fetchLocations()  -> [Geolocation] {
        
        let request = FetchDescriptor<Geolocation>()
        var locations = [Geolocation]()
        
        do {
            locations = try self.modelContext.fetch(request)
        }
        catch {
                print("Error fetching locations")
        }
        
        return locations
    }
    
    func addLocation(location: Geolocation)  throws {
        self.modelContext.insert(location)
        print("Location added to ModelContext")
    }
    
    func updateLocation(location: Geolocation)  throws {
        
    }
    
    func deleteLocation(location: Geolocation)  throws {
        self.modelContext.delete(location)
        print("Location deleted from ModelContext")
    }
}
