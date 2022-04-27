//  BaseModel.swift
//  Created by Holger Hinzberg on 27.04.22.
//  Copyright © 2022 Holger Hinzberg. All rights reserved.

import Foundation
import CoreData

protocol BaseModel {
    static var viewContext : NSManagedObjectContext  {get }
    func save() throws
}

extension BaseModel where Self:NSManagedObject {
    static var viewContext : NSManagedObjectContext {
        CoreDataManager.shared.persistentContainer.viewContext
    }
    
    func save() throws {
        try Self.viewContext.save()
    }
}
