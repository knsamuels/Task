//
//  TaskController.swift
//  Task
//
//  Created by Kristin Samuels  on 6/11/20.
//  Copyright © 2020 Karl Pfister. All rights reserved.
//

import Foundation
import CoreData

class TaskController {
    
    static let shared = TaskController()

    var fetchedResultsControler: NSFetchedResultsController<Task>
    
    init () {

        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "isComplete", ascending: true), NSSortDescriptor(key: "due", ascending: true)]
        let resultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataStack.context, sectionNameKeyPath: "isComplete", cacheName: nil)
        
        self.fetchedResultsControler = resultsController
       
        do {
         try fetchedResultsControler.performFetch()
        } catch {
            print(error.localizedDescription)
        }
    }
    func add(taskWithName name: String, notes: String?, due: Date?){
        Task(name: name, notes: notes, due: due, isComplete: false)
        saveToPersistentStore()
    }
    
    func update(task: Task, name: String, notes: String?, due: Date?) {
        task.name = name
        task.notes = notes
        task.due = due
        saveToPersistentStore()
    }

    func remove(task: Task){
        task.managedObjectContext?.delete(task)
        saveToPersistentStore()
    }
    
    func saveToPersistentStore() {
        do {
            try CoreDataStack.context.save()
        } catch {
            print( "There was an error in \(#function) : \(error) \(error.localizedDescription)")
        }
    }

    func toggleIsCompleteFor(task: Task) {
        task.isComplete = !task.isComplete
        saveToPersistentStore()
    }
}
