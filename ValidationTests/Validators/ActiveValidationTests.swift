//
//  RequiredFieldValidation.swift
//  ValidationTests
//
//  Created by Wagner Coleta on 02/03/22.
//

import XCTest
import Presentation
import Validation

class ActiveValidationTests: XCTestCase {
    func test_validate_should_return_error_if_invalid_active_is_provided() {
        let activeValidatorSpy = ActiveValidatorSpy()
        activeValidatorSpy.isValid = false
        let sut = makeSut(activeValidator: activeValidatorSpy)
        let errorMessage = sut.validate(data: ["code" : ["xpto"]])
        XCTAssertEqual(errorMessage, "O campo Lista de códigos é inválido")
    }
    
    func test_validate_should_return_nil_if_valid_active_is_provided() {
        let activeValidatorSpy = ActiveValidatorSpy()
        activeValidatorSpy.isValid = true
        let sut = makeSut(activeValidator: activeValidatorSpy)
        let errorMessage = sut.validate(data: ["code" : ["PETR4"]])
        XCTAssertNil(errorMessage)
    }
    
    func test_validate_should_return_nil_if_no_data_is_provided() {
        let sut = makeSut()
        let errorMessage = sut.validate(data: nil)
        XCTAssertEqual(errorMessage, "O campo Lista de códigos é inválido")
    }
}

extension ActiveValidationTests {
    func makeSut(fieldName: String = "code", fieldLabel: String = "Lista de códigos", activeValidator: ActiveValidatorSpy = ActiveValidatorSpy(), file: StaticString = #filePath, line: UInt = #line) -> Validation {
        let sut = ActiveValidation(fieldName: fieldName, fieldLabel: fieldLabel, activeValidator: activeValidator)
        checkMemoryLeak(for: sut, file: file, line: line)
        return sut
    }
}
