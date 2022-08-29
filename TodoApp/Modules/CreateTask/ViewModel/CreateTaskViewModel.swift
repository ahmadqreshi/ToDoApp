//
//  CreateTaskViewModel.swift
//  TodoApp
//
//  Created by Ahmad Qureshi on 07/07/22.
//

import UIKit
class CreateTaskViewModel {
    var taskTitle = String()
    var taskDescription = String()
    var taskEndDate = String()
    var errorMessage = String()
    // combine data into view model from view Controller
    func setData(title : String, description : String,endDate : String) {
        self.taskTitle = title
        self.taskDescription = description
        self.taskEndDate = endDate
    }
    // check authenticaton of input fields
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
            saveTask()
            return .correct
        }
    }
    // save task into core data
    func saveTask() {
        let newTask = Tasks(context: CoreDataManager.shared.viewContext)
        newTask.taskTitle = self.taskTitle
        newTask.taskDescription = self.taskDescription
        newTask.taskDate = self.taskEndDate
        newTask.taskId = UUID().uuidString
        CoreDataManager.shared.save()
    }
}
