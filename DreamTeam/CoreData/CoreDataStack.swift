//
//  CoreDataStack.swift
//  DreamTeam
//
//  Created by Student on 12/15/18.
//  Copyright © 2018 Student. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack {
    // addining a few properties that will be the entry point into us saving todos into core data
    
    // first thing we'll need to do is a NS persistent container
    // gonna interact with our todos data model that we created
    
    var container: NSPersistentContainer {
        let container = NSPersistentContainer(name: "Todos")
        container.loadPersistentStores{ (description, error) in
            guard error == nil else {
                print("Error: \(error!)")
                return
            }
        }
        
        return container
    }
    
    var manageContext: NSManagedObjectContext {
        return container.viewContext
    }
}
