//
//  TaskDetailsViewModel.swift
//  TodoApp
//
//  Created by Ahmad Qureshi on 08/07/22.
//

import Foundation
class TaskDetailsViewModel {
    var tasksData : [Tasks] = []
    func loadTasks() {
        tasksData = CoreDataManager.shared.getAllTasks()
    }
    var taskID = String()
    var taskTitle = String()
    var taskDescription = String()
    var taskEndDate = String()
    var errorMessage = String()
    // combine data with viewModel
    func setData(title : String, description : String,endDate : String) {
        self.taskTitle = title
        self.taskDescription = description
        self.taskEndDate = endDate
    }
    // check Authentication of input fields
    func taskInput() -> InputStatus {
        if taskTitle.isEmpty && taskDescription.isEmpty && taskEndDate.isEmpty {
            errorMessage = StringConstant.CreateTaskErrors.allFieldsEmpty.rawValue
            return .incorrect
        } else if taskTitle.isEmpty {
            errorMessage = StringConstant.CreateTaskErrors.titleEmpty.rawValue
            return .incorrect
        } else if taskDescription.isEmpty {
            errorMessage = StringConstant.CreateTaskErrors.descriptionEmpty.rawValue
            return .incorrect
        } else if taskEndDate.isEmpty {
            errorMessage = StringConstant.CreateTaskErrors.dateEmpty.rawValue
            return .incorrect
        } else {
            updateTask()
            return .correct
        }
    }
    // save items to core data
    func updateTask() {
        tasksData.forEach { task in
            if task.taskId == taskID {
                task.taskTitle = self.taskTitle
                task.taskDescription = self.taskDescription
                task.taskDate = self.taskEndDate
                CoreDataManager.shared.save()
            }
        }
    }
}
