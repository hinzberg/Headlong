//
//  CDGeocodeLocation+CoreDataProperties.swift
//  Headlong
//
//  Created by Holger Hinzberg on 27.04.22.
//  Copyright © 2022 Holger Hinzberg. All rights reserved.
//
//

import Foundation
import CoreData


extension CDGeocodeLocation {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDGeocodeLocation> {
        return NSFetchRequest<CDGeocodeLocation>(entityName: "CDGeocodeLocation")
    }

    @NSManaged public var name: String?
    @NSManaged public var address1: String?
    @NSManaged public var address2: String?
    @NSManaged public var neighbourhood: String?
    @NSManaged public var city: String?
    @NSManaged public var state: String?
    @NSManaged public var subAdministrativeArea: String?
    @NSManaged public var zipCode: String?
    @NSManaged public var country: String?
    @NSManaged public var isoCountryCode: String?
    @NSManaged public var regionIdentifier: String?
    @NSManaged public var timezone: String?
    @NSManaged public var date: Date?
    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double
    @NSManaged public var id: UUID?

}

extension CDGeocodeLocation : Identifiable {

}
