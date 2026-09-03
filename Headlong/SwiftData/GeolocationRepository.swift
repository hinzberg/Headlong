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
        let allLocations = self.fetchAll()
        guard !allLocations.contains(where: { $0.id == location.id }) else {
            print("Location with id \(location.id) already exists. Skipping.")
            return
        }
        self.modelContext.insert(location)
        try self.modelContext.save()
        self.objectWillChange.send()
        print("Location added to ModelContext")
        print(location.name ?? "")
        print(location.city ?? "")
    }
    
    func update(location: Geolocation)  throws {
        try self.modelContext.save()
        self.objectWillChange.send()
        print("Location updated in ModelContext")
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
    
    func exportAsJson() throws -> String {
        let locations = self.fetchAll()
        let exports = locations.map { location in
            GeolocationExport(id: location.id,
                              name: location.name,
                              address1: location.address1,
                              address2: location.address2,
                              neighbourhood: location.neighbourhood,
                              city: location.city,
                              state: location.state,
                              subAdministrativeArea: location.subAdministrativeArea,
                              zipCode: location.zipCode,
                              country: location.country,
                              isoCountryCode: location.isoCountryCode,
                              regionIdentifier: location.regionIdentifier,
                              timezone: location.timezone,
                              date: location.date,
                              latitude: location.latitude,
                              longitude: location.longitude,
                              note: location.note,
                              rating: location.rating,
                              isFavorite: location.isFavorite)
        }
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
        encoder.dateEncodingStrategy = .iso8601
        let data = try encoder.encode(exports)
        print("\(exports.count) locations exported as JSON.")
        return String(data: data, encoding: .utf8) ?? "[]"
    }

    func importFromJson(json: String, replaceExisting: Bool = false) throws -> Int {
        guard let data = json.data(using: .utf8) else {
            throw GeolocationImportError.invalidJson
        }
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let exports = try decoder.decode([GeolocationExport].self, from: data)

        if replaceExisting {
            try self.deleteAll()
        }

        let existingIds = Set(self.fetchAll().map { $0.id })
        var importedCount = 0
        for export in exports where !existingIds.contains(export.id) {
            let location = Geolocation()
            location.id = export.id
            location.name = export.name
            location.address1 = export.address1
            location.address2 = export.address2
            location.neighbourhood = export.neighbourhood
            location.city = export.city
            location.state = export.state
            location.subAdministrativeArea = export.subAdministrativeArea
            location.zipCode = export.zipCode
            location.country = export.country
            location.isoCountryCode = export.isoCountryCode
            location.regionIdentifier = export.regionIdentifier
            location.timezone = export.timezone
            location.date = export.date
            location.latitude = export.latitude
            location.longitude = export.longitude
            location.note = export.note
            location.rating = export.rating
            location.isFavorite = export.isFavorite
            try self.add(location: location)
            importedCount += 1
        }
        print("\(importedCount) of \(exports.count) locations imported from JSON.")
        return importedCount
    }

    func addSampleLandmarks()  throws {
        let landmarks: [(UUID, String, Double, Double, Bool)] = [
            (UUID(uuidString: "A1B2C3D4-1111-2222-3333-000000000001")!, "Eiffel Tower", 48.8584, 2.2945, true),
            (UUID(uuidString: "A1B2C3D4-1111-2222-3333-000000000002")!, "Statue of Liberty", 40.6892, -74.0445, false),
            (UUID(uuidString: "A1B2C3D4-1111-2222-3333-000000000003")!, "Sydney Opera House", -33.8568, 151.2153, true),
            (UUID(uuidString: "A1B2C3D4-1111-2222-3333-000000000004")!, "Colosseum", 41.8902, 12.4922, false),
            (UUID(uuidString: "A1B2C3D4-1111-2222-3333-000000000005")!, "Golden Gate Bridge", 37.8199, -122.4783, true),
            (UUID(uuidString: "A1B2C3D4-1111-2222-3333-000000000006")!, "Taj Mahal", 27.1751, 78.0421, false),
            (UUID(uuidString: "A1B2C3D4-1111-2222-3333-000000000007")!, "Christ the Redeemer", -22.9519, -43.2105, false),
            (UUID(uuidString: "A1B2C3D4-1111-2222-3333-000000000008")!, "Pyramids of Giza", 29.9792, 31.1342, true),
            (UUID(uuidString: "A1B2C3D4-1111-2222-3333-000000000009")!, "Great Wall of China", 40.4319, 116.5704, false),
            (UUID(uuidString: "A1B2C3D4-1111-2222-3333-000000000010")!, "Machu Picchu", -13.1631, -72.5450, true),
            (UUID(uuidString: "A1B2C3D4-1111-2222-3333-000000000011")!, "Stonehenge", 51.1789, -1.8262, false),
            (UUID(uuidString: "A1B2C3D4-1111-2222-3333-000000000012")!, "Petra", 30.3285, 35.4444, false)
        ]
        
        let sharedDate = GeolocationRepository.randomDate()
        let sharedDate2 = GeolocationRepository.randomDate()
        
        for (index, landmark) in landmarks.enumerated() {
            let location = Geolocation()
            location.id = landmark.0
            location.name = landmark.1
            location.latitude = landmark.2
            location.longitude = landmark.3
            location.isFavorite = landmark.4
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
        formatter.locale = Locale.current
        formatter.setLocalizedDateFormatFromTemplate("EEE, d MMM yyyy")
        return formatter.string(from: date)
    }
}

struct GeolocationExport: Codable {
    var id: UUID
    var name: String?
    var address1: String?
    var address2: String?
    var neighbourhood: String?
    var city: String?
    var state: String?
    var subAdministrativeArea: String?
    var zipCode: String?
    var country: String?
    var isoCountryCode: String?
    var regionIdentifier: String?
    var timezone: String?
    var date: Date?
    var latitude: Double
    var longitude: Double
    var note: String
    var rating: Int?
    var isFavorite: Bool
}

enum GeolocationImportError: Error {
    case invalidJson
}
