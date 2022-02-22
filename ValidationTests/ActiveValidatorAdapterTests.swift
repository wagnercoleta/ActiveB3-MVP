//
//  ValidationTests.swift
//  ValidationTests
//
//  Created by Wagner Coleta on 20/02/22.
//

import XCTest
import Validation

class ActiveValidatorAdapterTests: XCTestCase {

    func test_invalid_active() {
        let sut = makeSut()
        XCTAssertFalse(sut.isValid(active: ""))
        XCTAssertFalse(sut.isValid(active: "123"))
        XCTAssertFalse(sut.isValid(active: " xpt"))
        XCTAssertFalse(sut.isValid(active: "P1234"))
        XCTAssertFalse(sut.isValid(active: "PET32"))
        XCTAssertFalse(sut.isValid(active: "XX22"))
        XCTAssertFalse(sut.isValid(active: "PETR0"))
        XCTAssertFalse(sut.isValid(active: "petr4"))
        XCTAssertFalse(sut.isValid(active: "Petr4"))
    }
    
    func test_valid_active() {
        let sut = makeSut()
        XCTAssertTrue(sut.isValid(active: "PETR4"))
        XCTAssertTrue(sut.isValid(active: "PETR3"))
        XCTAssertTrue(sut.isValid(active: "MGLU3"))
        XCTAssertTrue(sut.isValid(active: "USIM5"))
        XCTAssertTrue(sut.isValid(active: "GGBR4"))
        XCTAssertTrue(sut.isValid(active: "GOLL4"))
    }
}

extension ActiveValidatorAdapterTests {
    func makeSut() -> ActiveValidatorAdapter {
        let sut = ActiveValidatorAdapter()
        return sut
    }
}
