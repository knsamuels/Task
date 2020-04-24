//
//  TaskController.swift
//  Task
//
//  Created by Kristin Samuels  on 4/22/20.
//  Copyright © 2020 Karl Pfister. All rights reserved.
//

import Foundation
import CoreData

class TaskController {
    
    static let shared = TaskController()
   
    let fetchedResultsController: NSFetchedResultsController<Task>
    
    init() {
        let request: NSFetchRequest<Task> = Task.fetchRequest()
        
        request.sortDescriptors = [NSSortDescriptor(key: "isComplete", ascending: true)]
        
        let resultsController: NSFetchedResultsController<Task> = NSFetchedResultsController(fetchRequest: request, managedObjectContext: CoreDataStack.context, sectionNameKeyPath: "Complete", cacheName: nil)
        
        fetchedResultsController = resultsController
        
        do {
            try fetchedResultsController.performFetch()
        } catch {
            print("There was an error performing the fetch. \(error.localizedDescription)")
        }
    }
    
    func toggleIsComplete(for task: Task) {
        task.isComplete = !task.isComplete
        saveToPersistentStore()
    }
    // CRUD
    func add(taskWithName name: String, notes: String?, due: Date?){
        let task = Task(name: name, notes: notes ?? "", due: due ?? Date())
//        tasks.append(task)
        saveToPersistentStore()
    }
    
    
    func update(task: Task, name: String, notes: String?, due: Date?) {
        task.name = name
        task.notes = notes
        task.due = due
        saveToPersistentStore()
        
    }
    
    func remove(task: Task) {
        if let moc = task.managedObjectContext {
            moc.delete(task)
            saveToPersistentStore()
            
        }
    }
    
    func saveToPersistentStore() {
        let moc = CoreDataStack.context
        do {
            try moc.save()
        } catch let saveError {
            print("there was a problem saving: \(saveError)")
        }
    }
}
