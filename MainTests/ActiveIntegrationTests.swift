//
//  ActiveIntegrationTests.swift
//  MainTests
//
//  Created by Wagner Coleta on 23/02/22.
//

import XCTest
import Main

class ActiveIntegrationTests: XCTestCase {

    func test_ui_presentation_integration_memoryleak() {
        let sut = ActiveComposer.composeControllerWith(readActive: ReadActiveSpy())
        checkMemoryLeak(for: sut)
    }
}
