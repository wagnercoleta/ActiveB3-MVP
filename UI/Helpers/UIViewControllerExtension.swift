//
//  UIViewControllerExtension.swift
//  UI
//
//  Created by Wagner Coleta on 20/02/22.
//

import Foundation
import UIKit

extension UIViewController {
    func hideKeyboardOnTap() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        gesture.cancelsTouchesInView = false
        view.addGestureRecognizer(gesture)
    }
    
    @objc private func hideKeyboard() {
        view.endEditing(true)
    }
}
