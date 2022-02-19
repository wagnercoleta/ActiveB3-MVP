//
//  UITests.swift
//  UITests
//
//  Created by Wagner Coleta on 19/02/22.
//

import XCTest
import UIKit
import Presentation
@testable import UI

class ActiveViewControllerTests: XCTestCase {

    func test_loading_is_hidden_on_start() {
        let sut = makeSut()
        XCTAssertEqual(sut.loadingIncator?.isAnimating, false)
    }
    
    func test_sut_implements_loadingView() {
        let sut = makeSut()
        let sutImplementsLoadingView = (sut as LoadingView)
        XCTAssertNotNil(sutImplementsLoadingView)
    }
    
    func test_sut_implements_alertView() {
        let sut = makeSut()
        let sutImplementsAlertView = (sut as AlertView)
        XCTAssertNotNil(sutImplementsAlertView)
    }
}

extension ActiveViewControllerTests {
    func makeSut() -> ActiveViewController {
        let sb = UIStoryboard(name: "Active", bundle: Bundle(for: ActiveViewController.self))
        let sut = sb.instantiateViewController(identifier: "ActiveViewController") as! ActiveViewController
        sut.loadViewIfNeeded()
        return sut
    }
}
