//
//  PresentationTests.swift
//  PresentationTests
//
//  Created by Wagner Coleta on 15/02/22.
//

import XCTest
import Presentation
import Domain

class ActivePresenterTests: XCTestCase {

    func test_should_show_error_message_if_array_active_is_not_provided() {
        let (sut, alertViewSpy, _ ,_) = makeSut()
        let readActiveViewModel = ReadActiveViewModel(codes: [])
        sut.listActive(viewModel: readActiveViewModel)
        XCTAssertEqual(alertViewSpy.viewModel, AlertViewModel(title: ActivePresenterConstans.titleAlert, message: ActivePresenterConstans.messageActiveRequired))
    }
    
    func test_should_call_activeValidator_with_correct_active() {
        let (sut, _, activeValidatorSpy, _) = makeSut()
        let readActiveViewModel = ReadActiveViewModel(codes: ["PETR4", "MGLU3"])
        sut.listActive(viewModel: readActiveViewModel)
        XCTAssertEqual(activeValidatorSpy.codes, readActiveViewModel.codes)
    }
    
    func test_should_show_error_message_if_activeValidator_is_not_provided() {
        let (sut, alertViewSpy, activeValidatorSpy, _) = makeSut()
        let readActiveViewModel = ReadActiveViewModel(codes: ["XPTO01", "XPTO02"])
        activeValidatorSpy.isValid = false
        sut.listActive(viewModel: readActiveViewModel)
        XCTAssertEqual(alertViewSpy.viewModel, AlertViewModel(title: ActivePresenterConstans.titleAlert, message: ActivePresenterConstans.messageActiveInvalid))
    }
    
    func test_active_should_call_readActive_with_correct_values() {
        let (sut, _, _, readActiveSpy) = makeSut()
        let readActiveViewModel = ReadActiveViewModel(codes: ["PETR4", "MGLU3"])
        sut.listActive(viewModel: readActiveViewModel)
        XCTAssertEqual(readActiveSpy.readActiveModels, makeReadActiveModels())
    }
    
    func test_should_show_error_message_if_readActive_fails() {
        let (sut, alertViewSpy, _, readActiveSpy) = makeSut()
        let readActiveViewModel = ReadActiveViewModel(codes: ["PETR4", "MGLU3"])
        sut.listActive(viewModel: readActiveViewModel)
        readActiveSpy.completeWithError(.unexpected)
        XCTAssertEqual(alertViewSpy.viewModel, AlertViewModel(title: ActivePresenterConstans.titleError, message: ActivePresenterConstans.messageErrorInesperado))
    }
}

extension ActivePresenterTests {
    
    func makeSut() -> (sut: ActivePresenter, alertViewSpy: AlertViewSpy, activeValidatorSpy: ActiveValidatorSpy, readActiveSpy: ReadActiveSpy){
        let alertViewSpy = AlertViewSpy()
        let activeValidatorSpy = ActiveValidatorSpy()
        let readActiveSpy = ReadActiveSpy()
        let sut = ActivePresenter(alertView: alertViewSpy, activeValidator: activeValidatorSpy, readActive: readActiveSpy)
        return (sut, alertViewSpy, activeValidatorSpy, readActiveSpy)
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
    
    class ReadActiveSpy: ReadActive {
        var readActiveModels: [ReadActiveModel]?
        var completion: ((Result<[ActiveModel]?, DomainError>) -> Void)?
        
        func read(readActiveModels: [ReadActiveModel], completion: @escaping (Result<[ActiveModel]?, DomainError>) -> Void) {
            self.readActiveModels = readActiveModels
            self.completion = completion
        }
        
        func completeWithError(_ error: DomainError) {
            completion?(.failure(error))
        }
    }
}
