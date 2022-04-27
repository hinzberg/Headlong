//  CoreDataManager.swift
//  Created by Holger Hinzberg on 27.04.22.
//  Copyright © 2022 Holger Hinzberg. All rights reserved.

import Foundation
import CoreData

class CoreDataManager {
    
    let persistentContainer : NSPersistentContainer
    static let shared = CoreDataManager()
    
    private init() {
        persistentContainer = NSPersistentContainer(name: "HeadlongDataModel")
        persistentContainer.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Unable to initialize Coredata \(error)")
            }
        }
    }
}
