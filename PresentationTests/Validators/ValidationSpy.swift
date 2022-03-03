//
//  ValidationSpy.swift
//  PresentationTests
//
//  Created by Wagner Coleta on 02/03/22.
//

import Foundation
import Presentation

class ValidationSpy: Validation {
    var data: [String: Any]?
    var errorMessage: String?
    
    func validate(data: [String : Any]?) -> String? {
        self.data = data
        return errorMessage
    }
    
    func simulateError(_ errorMessage: String = "Error") {
        self.errorMessage = errorMessage
    }
}
