//
//  CoreDataStack.swift
//  Task
//
//  Created by Kristin Samuels  on 4/22/20.
//  Copyright © 2020 Karl Pfister. All rights reserved.
//

import Foundation
import CoreData


import CoreData


class CoreDataStack {
    
    static let container: NSPersistentContainer = {
        
        //remeber to chang name of container
        let container = NSPersistentContainer(name: "Task")
        // Load From Persistence
        container.loadPersistentStores() { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    static var context: NSManagedObjectContext { return container.viewContext }
}


