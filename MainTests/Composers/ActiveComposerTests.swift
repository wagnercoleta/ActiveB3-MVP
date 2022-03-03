//
//  ActiveIntegrationTests.swift
//  MainTests
//
//  Created by Wagner Coleta on 23/02/22.
//

import XCTest
import Main
import UI
import Domain
import Validation

class ActiveComposerTests: XCTestCase {

    func test_background_request_should_complete_on_main_thread() {
        let (sut, readActiveSpy) = makeSut()
        sut.loadViewIfNeeded()
        sut.activeMethod?(makeReadActiveViewModel())
        let exp = expectation(description: "waiting")
        DispatchQueue.global().async {
            readActiveSpy.completeWithError(.unexpected)
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1)
    }
    
    func test_active_compose_with_correct_validations() {
        let validations = ActiveComposer.makeValidations()
        XCTAssertEqual(validations[0] as! RequiredFieldValidation, RequiredFieldValidation(fieldName: "codes", fieldLabel: "ativos"))
        XCTAssertEqual(validations[1] as! ActiveValidation, ActiveValidation(fieldName: "codes", fieldLabel: "ativos", activeValidator: ActiveValidatorSpy()))
    }
}

extension ActiveComposerTests {
    func makeSut(file: StaticString = #filePath, line: UInt = #line) -> (sut: ActiveViewController, readActiveSpy: ReadActiveSpy) {
        let readActiveSpy = ReadActiveSpy()
        let remoteReadActiveDecorator = MainQueueDispatchDecorator(readActiveSpy)
        let sut = ActiveComposer.composeControllerWith(readActive: remoteReadActiveDecorator)
        checkMemoryLeak(for: sut, file: file, line: line)
        checkMemoryLeak(for: readActiveSpy, file: file, line: line)
        return (sut, readActiveSpy)
    }
}
