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
        var readActiveViewModel: ReadActiveViewModel?
        let sut = makeSut(listActiveSpy: { readActiveViewModel = $0 })
        sut.loadButton?.simulateTap()
        let code = sut.codeActiveTextField?.text
        XCTAssertEqual(readActiveViewModel, ReadActiveViewModel(codes: [code!]))
    }
}

extension ActiveViewControllerTests {
    func makeSut(listActiveSpy: ((ReadActiveViewModel) -> Void)? = nil) -> ActiveViewController {
        let sb = UIStoryboard(name: "Active", bundle: Bundle(for: ActiveViewController.self))
        let sut = sb.instantiateViewController(identifier: "ActiveViewController") as! ActiveViewController
        sut.listActive = listActiveSpy
        sut.loadViewIfNeeded()
        return sut
    }
}

extension UIControl {
    func simulate(event: UIControl.Event) {
        allTargets.forEach { target in
            actions(forTarget: target, forControlEvent: event)?.forEach({ action in
                (target as NSObject).perform(Selector(action))
            })
        }
    }
    
    func simulateTap() {
        simulate(event: .touchUpInside)
    }
}
