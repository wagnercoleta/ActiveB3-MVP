//
//  ActiveValidation.swift
//  Validation
//
//  Created by Wagner Coleta on 02/03/22.
//

import Foundation
import Presentation

public final class ActiveValidation: Validation, Equatable {
    
    private let fieldName: String
    private let fieldLabel: String
    private let activeValidator: ActiveValidator
    
    public init(fieldName: String, fieldLabel: String, activeValidator: ActiveValidator) {
        self.fieldName = fieldName
        self.fieldLabel = fieldLabel
        self.activeValidator = activeValidator
    }
    
    public func validate(data: [String : Any]?) -> String? {
        guard let fieldValues = data?[fieldName] as? [String] else {
            return "O campo \(fieldLabel) é inválido"
        }
        var isValid = true
        fieldValues.forEach { code in
            if (isValid) {
                isValid = activeValidator.isValid(active: code)
            }
        }
        if (isValid) {
            return nil
        }
        else {
            return "O campo \(fieldLabel) é inválido"
        }
    }
    
    public static func == (lhs: ActiveValidation, rhs: ActiveValidation) -> Bool {
        return lhs.fieldName == rhs.fieldName && lhs.fieldLabel == rhs.fieldLabel
    }
}
