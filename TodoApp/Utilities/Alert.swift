//
//  Alert.swift
//  TodoApp
//
//  Created by Ahmad Qureshi on 07/07/22.
//
import UIKit
struct Alert {
    private static func showBasicAlert(on vc: UIViewController, title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: StringConstant.CommonStrings.ok.rawValue, style: .default, handler: nil))
        DispatchQueue.main.async { vc.present(alert, animated: true, completion: nil) }
    }
    static func showAlert(on vc: UIViewController,title : String, message: String) {
        showBasicAlert(on: vc, title: title, message: message)
    }
}
