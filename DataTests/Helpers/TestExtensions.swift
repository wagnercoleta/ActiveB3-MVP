//
//  TestExtensions.swift
//  DataTests
//
//  Created by Wagner Coleta on 05/02/22.
//

import Foundation
import XCTest

extension XCTestCase {
    func checkMemoryLeak(for instance: AnyObject, file: StaticString = #filePath, line: UInt = #line) {
        //INI - TU para verificar memory leak (vazamento de memória - referência ciclica)
        addTeardownBlock { [weak instance] in
            XCTAssertNil(instance, file: file, line: line)
        }
        //FIM - TU
    }
}
