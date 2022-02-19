//
//  UITests.swift
//  UITests
//
//  Created by Wagner Coleta on 19/02/22.
//

import XCTest
import UIKit
@testable import UI

class ActiveViewControllerTests: XCTestCase {

    func test_loading_is_hidden_on_start() {
        let sb = UIStoryboard(name: "Active", bundle: Bundle(for: ActiveViewController.self))
        let sut = sb.instantiateViewController(identifier: "ActiveViewController") as! ActiveViewController
        sut.loadViewIfNeeded()
        XCTAssertEqual(sut.loadingIncator?.isAnimating, false)
    }
}