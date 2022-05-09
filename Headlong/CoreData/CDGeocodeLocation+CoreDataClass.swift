//
//  CDGeocodeLocation+CoreDataClass.swift
//  Headlong
//
//  Created by Holger Hinzberg on 27.04.22.
//  Copyright © 2022 Holger Hinzberg. All rights reserved.
//
//

import Foundation
import CoreData

@objc(CDGeocodeLocation)
public class CDGeocodeLocation: NSManagedObject , BaseModel
{
    static var all : NSFetchRequest<CDGeocodeLocation> {
        let request : NSFetchRequest<CDGeocodeLocation> = CDGeocodeLocation.fetchRequest()
        request.sortDescriptors = []
        return request
    }
    
    public override var description: String {
        return "CDGeocodeLocation"
    }
}
