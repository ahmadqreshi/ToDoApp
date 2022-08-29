//
//  CreateTaskVC.swift
//  TodoApp
//
//  Created by Ahmad Qureshi on 07/07/22.
//

import UIKit

class CreateTaskVC: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var taskTitleTextField: UITextField!
    @IBOutlet weak var taskDescriptionTextView: UITextView!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var createButton: UIButton!
    // MARK: - Internal Properties
    let createTaskViewModel = CreateTaskViewModel()
    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        taskTitleTextField.delegate = self
        taskDescriptionTextView.delegate = self
        dateTextField.delegate = self
        taskDescriptionTextView.createBorder()
        self.title = StringConstant.CommonStrings.createTaskTitle.rawValue
    }
}

// MARK: - IBActions of buttons
private extension CreateTaskVC {
    @IBAction func createTaskButtonPressed(_ sender: UIButton) {
        guard let title = taskTitleTextField.text, let description = taskDescriptionTextView.text, let endDate = dateTextField.text else { return }
        createTaskViewModel.setData(title: title, description: description, endDate: endDate)
        switch createTaskViewModel.taskInput() {
        case .correct :
            Alert.showAlert(on: self, title: StringConstant.CommonStrings.success.rawValue, message: StringConstant.AlertMessages.taskAdded.rawValue)
            taskTitleTextField.text = nil
            taskDescriptionTextView.text = StringConstant.TextViewPlaceholder.writeDescription.rawValue
            taskDescriptionTextView.textColor = .placeholderText
            dateTextField.text = nil
        case .incorrect :
            Alert.showAlert(on: self, title: StringConstant.CommonStrings.warning.rawValue, message: createTaskViewModel.errorMessage)
        }
    }
}
// MARK: - TextField and TextView Delegate
extension CreateTaskVC: UITextFieldDelegate, UITextViewDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == taskTitleTextField {
            textField.resignFirstResponder()
            return true
        }
        return false
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField {
        case dateTextField :
            dateTextField.createpicker(view: self.view)
        default :
            return
        }
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .placeholderText {
            textView.text = nil
            textView.textColor = .black
        }
    }
}
