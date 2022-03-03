//
//  ValidationComposite.swift
//  Validation
//
//  Created by Wagner Coleta on 02/03/22.
//

import Foundation
import Presentation

public final class ValidationComposite: Validation {
    private let validations: [Validation]
    
    public init(validations: [Validation]) {
        self.validations = validations
    }
    
    public func validate(data: [String : Any]?) -> String? {
        for validation in validations {
            if let errorMessage = validation.validate(data: data) {
                return errorMessage
            }
        }
        return nil
    }
}
