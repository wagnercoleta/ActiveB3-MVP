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
    
    func test_loadButton_calls_active_on_tap() {
        var readActiveViewModel: ReadActiveRequest?
        let sut = makeSut(activeMethodSpy: { readActiveViewModel = $0 })
        sut.loadButton?.simulateTap()
        let code = sut.codeActiveTextField?.text
        XCTAssertEqual(readActiveViewModel, ReadActiveRequest(codes: [code!]))
    }
}

extension ActiveViewControllerTests {
    func makeSut(activeMethodSpy: ((ReadActiveRequest) -> Void)? = nil) -> ActiveViewController {
        let sut = ActiveViewController.instantiate()
        sut.activeMethod = activeMethodSpy
        sut.loadViewIfNeeded()
        return sut
    }
}
