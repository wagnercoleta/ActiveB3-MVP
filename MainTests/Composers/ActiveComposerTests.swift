//
//  ActiveIntegrationTests.swift
//  MainTests
//
//  Created by Wagner Coleta on 23/02/22.
//

import XCTest
import Main
import UI

class ActiveComposerTests: XCTestCase {

    func test_background_request_should_complete_on_main_thread() {
        let (sut, _) = makeSut()
        sut.loadViewIfNeeded()
    }
}

extension ActiveComposerTests {
    func makeSut(file: StaticString = #filePath, line: UInt = #line) -> (sut: ActiveViewController, readActiveSpy: ReadActiveSpy) {
        let readActiveSpy = ReadActiveSpy()
        let sut = ActiveComposer.composeControllerWith(readActive: readActiveSpy)
        checkMemoryLeak(for: sut, file: file, line: line)
        checkMemoryLeak(for: readActiveSpy, file: file, line: line)
        return (sut, readActiveSpy)
    }
}
