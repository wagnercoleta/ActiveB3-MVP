//
//  RequiredFieldValidation.swift
//  ValidationTests
//
//  Created by Wagner Coleta on 02/03/22.
//

import XCTest
import Presentation
import Validation

class RequiredFieldValidationTests: XCTestCase {
    func test_validate_should_return_error_if_field_is_not_provided() {
        let sut = makeSut()
        let errorMessage = sut.validate(data: ["description" : "Descrição"])
        XCTAssertEqual(errorMessage, "O campo Lista de ativos é obrigatório")
    }
    
    func test_validate_should_return_error_if_field_is_nil() {
        let sut = makeSut()
        let errorMessage = sut.validate(data: ["code" : []])
        XCTAssertEqual(errorMessage, "O campo Lista de ativos é obrigatório")
    }
    
    func test_validate_should_return_nil_if_field_is_provided() {
        let sut = makeSut()
        let errorMessage = sut.validate(data: ["code" : ["PETR4", "USIM5"]])
        XCTAssertNil(errorMessage)
    }
    
    func test_validate_should_return_nil_if_no_data_is_provided() {
        let sut = makeSut()
        let errorMessage = sut.validate(data: nil)
        XCTAssertEqual(errorMessage, "O campo Lista de ativos é obrigatório")
    }
}

extension RequiredFieldValidationTests {
    func makeSut(fieldName: String = "code", fieldLabel: String = "Lista de ativos", file: StaticString = #filePath, line: UInt = #line) -> Validation {
        let sut = RequiredFieldValidation(fieldName: fieldName, fieldLabel: fieldLabel)
        checkMemoryLeak(for: sut, file: file, line: line)
        return sut
    }
}
