//
//  RequiredFieldValidation.swift
//  Validation
//
//  Created by Wagner Coleta on 02/03/22.
//

import Foundation
import Presentation

public final class RequiredFieldValidation: Validation, Equatable {
    
    private let fieldName: String
    private let fieldLabel: String
    
    public init(fieldName: String, fieldLabel: String) {
        self.fieldName = fieldName
        self.fieldLabel = fieldLabel
    }
    
    public func validate(data: [String : Any]?) -> String? {
        guard let filedName = data?[fieldName] as? [String], filedName.count > 0 else {
            return "O campo \(fieldLabel) é obrigatório"
        }
        return nil
    }
    
    public static func == (lhs: RequiredFieldValidation, rhs: RequiredFieldValidation) -> Bool {
        return lhs.fieldName == rhs.fieldName && lhs.fieldLabel == rhs.fieldLabel
    }
}
