//
//  ValidationBuilder.swift
//  Main
//
//  Created by Wagner Coleta on 12/03/22.
//

import Foundation
import Presentation
import Validation

//Designer Pattern "Builder" para facilitar a validação (Validation) utilizando da
//concatenação dos métodos retornando a instância da classe.  
public final class ValidationBuilder {
    
    private static var instance: ValidationBuilder?
    private var fieldName: String!
    private var fieldLabel: String!
    private var validations = [Validation]()
    
    private init() {}
    
    public static func field(_ name: String) -> ValidationBuilder {
        instance = ValidationBuilder()
        instance!.fieldName = name
        instance!.fieldLabel = name
        return instance!
    }
    
    public func label(_ label: String) -> ValidationBuilder {
        fieldLabel = label
        return self
    }
    
    public func required() -> ValidationBuilder {
        validations.append(RequiredFieldValidation(fieldName: fieldName, fieldLabel: fieldLabel))
        return self
    }
    
    public func active() -> ValidationBuilder {
        validations.append(ActiveValidation(fieldName: fieldName, fieldLabel: fieldLabel, activeValidator: makeActiveValidatorAdapter()))
        return self
    }
    
    public func build() -> [Validation] {
        return validations
    }
}
