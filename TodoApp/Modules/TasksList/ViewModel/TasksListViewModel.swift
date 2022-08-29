//
//  TasksListViewModel.swift
//  TodoApp
//
//  Created by Ahmad Qureshi on 07/07/22.
//

import UIKit
import CoreData
class TaskaListViewModel {
    var tasksData : [Tasks] = []
    // to load data from the core data
    func loadTasks() {
        tasksData = CoreDataManager.shared.getAllTasks()
    }
    func delete(_ task: Tasks) {
        CoreDataManager.shared.deleteTask(task: task)
    }
}
