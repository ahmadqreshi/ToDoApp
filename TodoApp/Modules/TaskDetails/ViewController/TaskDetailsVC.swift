//
//  TaskDetailsVC.swift
//  TodoApp
//
//  Created by Ahmad Qureshi on 07/07/22.
//

import UIKit

class TaskDetailsVC: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var taskTitle: UILabel!
    @IBOutlet weak var taskDate: UILabel!
    @IBOutlet weak var taskDescription: UILabel!
    @IBOutlet weak var editView: UIView!
    @IBOutlet weak var taskTitleTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var taskDescriptionTextView: UITextView!
    // MARK: - Internal Properties
    var id : String?
    var isUpdate = false
    var taskDetailsViewModel = TaskDetailsViewModel()
    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavBar()
        dateTextField.createpicker(view: self.view)
        taskDescriptionTextView.createBorder()
    }
    override func viewWillAppear(_ animated: Bool) {
        taskDetailsViewModel.loadTasks()
        setUpData()
    }
}
// MARK: - Custom methods
private extension TaskDetailsVC {
    func setUpData() {
        taskDetailsViewModel.tasksData.forEach { item in
            if item.taskId == id {
                self.taskTitle.text = item.taskTitle
                self.taskDate.text = item.taskDate
                self.taskDescription.text = item.taskDescription
                self.taskTitleTextField.text = item.taskTitle
                self.dateTextField.text = item.taskDate
                self.taskDescriptionTextView.text = item.taskDescription
            }
        }
    }
    func setUpNavBar() {
        let button = UIButton(type: UIButton.ButtonType.system)
        let barButton = UIBarButtonItem(customView: button)
        button.setTitle(StringConstant.CommonStrings.edit.rawValue, for: .normal)
        button.addTarget(self, action: #selector(editTapped), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = barButton
        self.navigationItem.title = StringConstant.CommonStrings.taskDetailTitle.rawValue
    }
    @objc func editTapped() {
        isUpdate.toggle()
        isUpdate ? (self.editView.isHidden = false) : (self.editView.isHidden = true)
    }
}
// MARK: - IBAction of update button
private extension TaskDetailsVC {
    @IBAction func updateButtonPressed(_ sender: UIButton) {
        guard let title = taskTitleTextField.text, let description = taskDescriptionTextView.text, let endDate = dateTextField.text else { return }
        taskDetailsViewModel.setData(title: title, description: description, endDate: endDate)
        taskDetailsViewModel.taskID = id ?? String()
        switch taskDetailsViewModel.taskInput() {
        case .correct :
            Alert.showAlert(on: self, title: StringConstant.CommonStrings.updated.rawValue, message: StringConstant.AlertMessages.taskUpdated.rawValue)
            taskTitleTextField.endEditing(true)
            taskDescriptionTextView.endEditing(true)
            taskDescriptionTextView.endEditing(true)
            dateTextField.endEditing(true)
        case .incorrect :
            Alert.showAlert(on: self, title:  StringConstant.CommonStrings.warning.rawValue, message: taskDetailsViewModel.errorMessage)
        }
    }
}
