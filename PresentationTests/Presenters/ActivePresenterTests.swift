//
//  PresentationTests.swift
//  PresentationTests
//
//  Created by Wagner Coleta on 15/02/22.
//

import XCTest
import Presentation

class ActivePresenterTests: XCTestCase {

    func test_should_show_error_message_if_array_active_is_not_provided() {
        let (sut, alertViewSpy, _) = makeSut()
        let readActiveViewModel = ReadActiveViewModel(codes: [])
        sut.listActive(viewModel: readActiveViewModel)
        XCTAssertEqual(alertViewSpy.viewModel, AlertViewModel(title: ActivePresenterConstans.titleAlert, message: ActivePresenterConstans.messageActiveRequired))
    }
    
    func test_should_call_activeValidator_with_correct_active() {
        let (sut, _, activeValidatorSpy) = makeSut()
        let readActiveViewModel = ReadActiveViewModel(codes: ["PETR4", "MGLU3"])
        sut.listActive(viewModel: readActiveViewModel)
        XCTAssertEqual(activeValidatorSpy.codes, readActiveViewModel.codes)
    }
    
    func test_should_show_error_message_if_activeValidator_is_not_provided() {
        let (sut, alertViewSpy, activeValidatorSpy) = makeSut()
        let readActiveViewModel = ReadActiveViewModel(codes: ["XPTO01", "XPTO02"])
        activeValidatorSpy.isValid = false
        sut.listActive(viewModel: readActiveViewModel)
        XCTAssertEqual(alertViewSpy.viewModel, AlertViewModel(title: ActivePresenterConstans.titleAlert, message: ActivePresenterConstans.messageActiveInvalid))
    }
}

extension ActivePresenterTests {
    
    func makeSut() -> (sut: ActivePresenter, alertViewSpy: AlertViewSpy, activeValidatorSpy: ActiveValidatorSpy){
        let alertViewSpy = AlertViewSpy()
        let activeValidatorSpy = ActiveValidatorSpy()
        let sut = ActivePresenter(alertView: alertViewSpy, activeValidator: activeValidatorSpy)
        return (sut, alertViewSpy, activeValidatorSpy)
    }
    
    class AlertViewSpy: AlertView {
        var viewModel: AlertViewModel?
        
        func showMessage(viewModel: AlertViewModel) {
            self.viewModel = viewModel
        }
    }
    
    class ActiveValidatorSpy: ActiveValidator {
        var isValid = true
        var codes: [String]?
        
        func isValid(active: String) -> Bool {
            
            if (codes == nil) {
                codes = []
            }
            
            if (!codes!.contains(active)) {
                codes?.append(active)
            }
            
            return isValid
        }
    }
}
