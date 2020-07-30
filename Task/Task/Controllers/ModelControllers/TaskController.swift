//
//  TaskController.swift
//  Task
//
//  Created by Todd Crandall on 7/29/20.
//  Copyright © 2020 Karl Pfister. All rights reserved.
//

import Foundation
import CoreData

class TaskController {
    
    //MARK: - Shared Instance
    static let sharedInstance = TaskController()
    
    //MARK: - Properties
    //SOT
    var fetchedResultController: NSFetchedResultsController<Task>

    init() {
        let request:NSFetchRequest<Task> = Task.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]

        let resultsController: NSFetchedResultsController<Task> = NSFetchedResultsController(fetchRequest: request, managedObjectContext:CoreDataStack.context, sectionNameKeyPath: nil, cacheName: nil)

        fetchedResultController = resultsController

        do {
            try fetchedResultController.performFetch()
        } catch {
            print("There was an error in performing the fetch.")
        }

    }
    
//    private init() {
//        self.tasks = fetchTasks()
//    }
    
//    var tasks: [Task] {
//
//        let moc = CoreDataStack.context
//        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
//        let fetchResults = try? moc.fetch(fetchRequest)
//
//        return fetchResults ?? []
//    }
    
    func toggleIsComplete(for task: Task) {
        task.isComplete.toggle()
        saveToPersistence()
    }
    
    //MARK: - CRUD
    //create
    func createTaskWith(name: String, notes: String, due: Date?) {
        _ = Task(name: name, notes: notes, due: Date())
        saveToPersistence()
    }
    //update
    func updateTaskWIth(task: Task, name: String, notes: String, due: Date?) {
        task.name = name
        task.notes = notes
        task.due = due
        saveToPersistence()
    }
    
    //delete
    func delete(taskToDelete: Task) {
        if let moc = taskToDelete.managedObjectContext {
            moc.delete(taskToDelete)
            saveToPersistence()
        }
    }
    
    func saveToPersistence() {
        let moc = CoreDataStack.context
        do {
            try moc.save()
        } catch let saveError {
            print("There was an issue saving \(saveError)")
        }
    }
}//End of Class
