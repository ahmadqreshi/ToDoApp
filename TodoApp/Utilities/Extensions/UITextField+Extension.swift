//
//  UITextField+Extension.swift
//  TodoApp
//
//  Created by Ahmad Qureshi on 08/07/22.
//

import Foundation
import UIKit
extension UITextField {
    func createpicker(view : UIView) {
        let datepicker = UIDatePicker()
        datepicker.datePickerMode = .date
        self.inputView = datepicker
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 44))
        let cancel = UIBarButtonItem(title: StringConstant.CommonStrings.cancel.rawValue, style: .plain, target: self, action: #selector(self.cancelclick))
        let done = UIBarButtonItem(title: StringConstant.CommonStrings.done.rawValue, style: .done, target: self, action: #selector(doneclick))
        let flexible  = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.setItems([cancel , flexible ,done], animated: false)
        self.inputAccessoryView = toolbar
        datepicker.preferredDatePickerStyle  = .wheels
        datepicker.minimumDate = Date()
    }
    @objc func cancelclick() {
        self.resignFirstResponder()
    }
    @objc private func doneclick() {
        if let datepicker = self.inputView as? UIDatePicker{
            let dateformat = DateFormatter()
            dateformat.dateStyle = .short
            dateformat.dateFormat = StringConstant.CommonStrings.dateFormat.rawValue
            self.text = dateformat.string(from: datepicker.date)
        }
        self.resignFirstResponder()
    }
}
