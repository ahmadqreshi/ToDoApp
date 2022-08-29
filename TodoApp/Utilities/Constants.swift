//
//  StringConstant.swift
//  TodoApp
//
//  Created by Ahmad Qureshi on 08/07/22.
//

import Foundation
enum StringConstant {
    enum TableViewIdentifier : String {
        case tasksListTableViewCell = "TasksListTableViewCell"
    }
    enum CreateTaskErrors : String {
        case allFieldsEmpty = "Please Provide all fields"
        case titleEmpty = "Please Enter Task title"
        case descriptionEmpty = "Please write description"
        case dateEmpty = "Please select end date"
    }
    enum TextViewPlaceholder : String {
        case writeDescription = "Write short Description here"
    }
    enum AlertMessages : String {
        case taskAdded = "Task Added Successfully!"
        case taskUpdated = "Task Updated Successfully!"
    }
    enum CommonStrings : String {
        case edit = "Edit"
        case taskDetailTitle = "Task Details"
        case createTaskTitle = "Create Task"
        case today = "Today"
        case success = "Success"
        case warning = "Warning!"
        case updated = "Updated"
        case cancel = "Cancel"
        case done = "Done"
        case dateFormat = "dd MMM yyyy"
        case ok = "OK"
        case space = " "
    }
    static let monthDict = ["Jan" : 1,"Feb" : 2,"Mar":3,"Apr" : 4,"May":5,"Jun":6,"Jul" : 7,"Aug":8,"Sep" : 9,"Oct" :10,"Nov" :11,"Dec" : 12]
}
