//
//  UITextView+Extension.swift
//  TodoApp
//
//  Created by Ahmad Qureshi on 08/07/22.
//

import Foundation
import UIKit
extension UITextView {
    func createBorder() {
        let borderColor : UIColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1.0)
        self.layer.borderWidth = 0.5
        self.layer.borderColor = borderColor.cgColor
        self.layer.cornerRadius = 5.0
    }
}
