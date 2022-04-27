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
public class CDGeocodeLocation: NSManagedObject , BaseModel {
    
    public override var description: String {
        return "CDGeocodeLocation"
    }

}
