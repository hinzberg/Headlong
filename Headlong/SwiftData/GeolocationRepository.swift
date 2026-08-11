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
            let locationCount = (try? self.modelContext.fetchCount(FetchDescriptor<Geolocation>())) ?? 0
            if locationCount == 0 {
                try? self.addSampleLandmarks()
            }
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
     
     func fetchAll()  -> [Geolocation] {
        
        let request = FetchDescriptor<Geolocation>()
        var locations = [Geolocation]()
        
        do {
            locations = try self.modelContext.fetch(request)
        }
        catch {
                print("Error fetching locations")
        }
        
        print("\(locations.count) locations fetched.")
        return locations
    }
        
    func add(location: Geolocation)  throws {
        self.modelContext.insert(location)
        try self.modelContext.save()
        self.objectWillChange.send()
        print("Location added to ModelContext")
        print(location.name ?? "")
        print(location.city ?? "")
    }
    
    func update(location: Geolocation)  throws {
        
    }
    
    func delete(location: Geolocation)  throws {
        self.modelContext.delete(location)
        try self.modelContext.save()
        self.objectWillChange.send()
        print("Location deleted from ModelContext")
    }
    
    func deleteAll()  throws {
        let request = FetchDescriptor<Geolocation>()
        let locations = try self.modelContext.fetch(request)
        for location in locations {
            self.modelContext.delete(location)
        }
        try self.modelContext.save()
        self.objectWillChange.send()
        print("All \(locations.count) locations deleted from ModelContext")
    }
    
    func addSampleLandmarks()  throws {
        let landmarks = [
            ("Eiffel Tower", 48.8584, 2.2945),
            ("Statue of Liberty", 40.6892, -74.0445),
            ("Sydney Opera House", -33.8568, 151.2153),
            ("Colosseum", 41.8902, 12.4922),
            ("Golden Gate Bridge", 37.8199, -122.4783),
            ("Taj Mahal", 27.1751, 78.0421),
            ("Christ the Redeemer", -22.9519, -43.2105),
            ("Pyramids of Giza", 29.9792, 31.1342),
            ("Great Wall of China", 40.4319, 116.5704),
            ("Machu Picchu", -13.1631, -72.5450),
            ("Stonehenge", 51.1789, -1.8262),
            ("Petra", 30.3285, 35.4444)
        ]
        
        let sharedDate = GeolocationRepository.randomDate()
        let sharedDate2 = GeolocationRepository.randomDate()
        
        for (index, landmark) in landmarks.enumerated() {
            let location = Geolocation()
            location.name = landmark.0
            location.latitude = landmark.1
            location.longitude = landmark.2
            location.date = index >= 6 && index <= 8 ? sharedDate : (index >= 10 ? sharedDate2 : GeolocationRepository.randomDate())
            try self.add(location: location)
        }
    }
    
    private static func randomDate() -> Date {
        let days = Int.random(in: 1...3650)
        return Calendar.current.date(byAdding: .day, value: -days, to: Date()) ?? Date()
    }
    
    func fetchAllGroupedByDate() -> [DateGroup] {
        var groups = [Date: DateGroup]()
        var unknownGroup: DateGroup?
        
        for location in self.fetchAll() {
            if let date = location.date {
                let day = Calendar.current.startOfDay(for: date)
                if groups[day] == nil {
                    groups[day] = DateGroup(description: GeolocationRepository.formatDate(day))
                }
                groups[day]?.geoLocations.append(location)
            } else {
                if unknownGroup == nil {
                    unknownGroup = DateGroup(description: "Unknown")
                }
                unknownGroup?.geoLocations.append(location)
            }
        }
        
        for (_, group) in groups {
            group.geoLocations.sort { ($0.date ?? .distantPast) > ($1.date ?? .distantPast) }
        }
        
        var result = groups.keys.sorted(by: >).map { groups[$0]! }
        if let unknownGroup = unknownGroup {
            unknownGroup.geoLocations.sort { ($0.date ?? .distantPast) > ($1.date ?? .distantPast) }
            result.append(unknownGroup)
        }
        return result
    }
    
    private static func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.setLocalizedDateFormatFromTemplate("EEE, dd MMM yyyy")
        return formatter.string(from: date)
    }
}
