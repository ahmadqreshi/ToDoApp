//
//  CoreDataManager.swift
//  TodoApp
//
//  Created by Ahmad Qureshi on 08/07/22.
//

import Foundation
import CoreData

class CoreDataManager {
    let persistentContainer: NSPersistentContainer
    static let shared = CoreDataManager()
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    func getAllTasks() -> [Tasks] {
        let request: NSFetchRequest<Tasks> = Tasks.fetchRequest()
        do {
            return try viewContext.fetch(request)
        } catch {
            return []
        }
    }
    func getTaskById(id: NSManagedObjectID) -> Tasks? {
        
        do {
            return try viewContext.existingObject(with: id) as? Tasks
        } catch {
            return nil
        }
        
    }
    
    func deleteTask(task: Tasks) {
        viewContext.delete(task)
        save()
    }
    func save() {
        do {
            try viewContext.save()
        } catch {
            viewContext.rollback()
            print(error.localizedDescription)
        }
    }
    private init() {
        persistentContainer = NSPersistentContainer(name: "TaskDataModel")
        persistentContainer.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Unable to initialize Core Data Stack \(error)")
            }
        }
    }
}
