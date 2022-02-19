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
        let (sut, alertViewSpy, _ ,_, _) = makeSut()
        let readActiveViewModel = ReadActiveViewModel(codes: [])
        let exp = expectation(description: "waiting")
        alertViewSpy.observe { [weak self] viewModel in
            XCTAssertEqual(viewModel, self?.makeAlertViewModel(ActivePresenterConstans.titleAlert,
                                                               ActivePresenterConstans.messageActiveRequired))
            exp.fulfill()
        }
        sut.listActive(viewModel: readActiveViewModel)
        wait(for: [exp], timeout: 1)
        
    }
    
    func test_should_call_activeValidator_with_correct_active() {
        let (sut, _, activeValidatorSpy, _, _) = makeSut()
        let readActiveViewModel = ReadActiveViewModel(codes: ["PETR4", "MGLU3"])
        sut.listActive(viewModel: readActiveViewModel)
        XCTAssertEqual(activeValidatorSpy.codes, readActiveViewModel.codes)
    }
    
    func test_should_show_error_message_if_activeValidator_is_not_provided() {
        let (sut, alertViewSpy, activeValidatorSpy, _, _) = makeSut()
        let readActiveViewModel = ReadActiveViewModel(codes: ["XPTO01", "XPTO02"])
        activeValidatorSpy.isValid = false
        let exp = expectation(description: "waiting")
        alertViewSpy.observe { [weak self] viewModel in
            XCTAssertEqual(viewModel, self?.makeAlertViewModel(ActivePresenterConstans.titleAlert,
                                                               ActivePresenterConstans.messageActiveInvalid))
            exp.fulfill()
        }
        sut.listActive(viewModel: readActiveViewModel)
        wait(for: [exp], timeout: 1)
    }
    
    func test_active_should_call_readActive_with_correct_values() {
        let (sut, _, _, readActiveSpy, _) = makeSut()
        let readActiveViewModel = ReadActiveViewModel(codes: ["PETR4", "MGLU3"])
        sut.listActive(viewModel: readActiveViewModel)
        XCTAssertEqual(readActiveSpy.readActiveModels, makeReadActiveModels())
    }
    
    func test_should_show_error_message_if_readActive_fails() {
        let (sut, alertViewSpy, _, readActiveSpy, _) = makeSut()
        let readActiveViewModel = ReadActiveViewModel(codes: ["PETR4", "MGLU3"])
        let exp = expectation(description: "waiting")
        alertViewSpy.observe { [weak self] viewModel in
            XCTAssertEqual(viewModel, self?.makeAlertViewModel(ActivePresenterConstans.titleError,
                                                               ActivePresenterConstans.messageErrorInesperado))
            exp.fulfill()
        }
        sut.listActive(viewModel: readActiveViewModel)
        readActiveSpy.completeWithError(.unexpected)
        wait(for: [exp], timeout: 1)
    }
    
    func test_should_show_loading_if_before_call_readActive() {
        let (sut, _, _, _, loadingViewSpy) = makeSut()
        let readActiveViewModel = ReadActiveViewModel(codes: ["PETR4", "MGLU3"])
        sut.listActive(viewModel: readActiveViewModel)
        XCTAssertEqual(loadingViewSpy.viewModel, LoadingViewModel(isLoading: true))
    }
}

extension ActivePresenterTests {
    
    func makeSut(file: StaticString = #filePath, line: UInt = #line) -> (sut: ActivePresenter, alertViewSpy: AlertViewSpy, activeValidatorSpy: ActiveValidatorSpy, readActiveSpy: ReadActiveSpy, loadingViewSpy: LoadingViewSpy){
        let alertViewSpy = AlertViewSpy()
        let activeValidatorSpy = ActiveValidatorSpy()
        let readActiveSpy = ReadActiveSpy()
        let loadingViewSpy = LoadingViewSpy()
        let sut = ActivePresenter(alertView: alertViewSpy, activeValidator: activeValidatorSpy, readActive: readActiveSpy, loadingView: loadingViewSpy)
        checkMemoryLeak(for: sut, file: file, line: line)
        return (sut, alertViewSpy, activeValidatorSpy, readActiveSpy, loadingViewSpy)
    }
    
    func makeAlertViewModel(_ title: String, _ message: String) -> AlertViewModel {
        return AlertViewModel(title: title, message: message)
    }
    
    class AlertViewSpy: AlertView {
        var emit: ((AlertViewModel) -> Void)?
        
        func observe(completion: @escaping (AlertViewModel) -> Void) {
            self.emit = completion
        }
        
        func showMessage(viewModel: AlertViewModel) {
            self.emit?(viewModel)
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
    
    class LoadingViewSpy: LoadingView {
        var viewModel: LoadingViewModel?
        
        func display(viewModel: LoadingViewModel) {
            self.viewModel = viewModel
        }
    }
}

extension XCTestCase {
    func checkMemoryLeak(for instance: AnyObject, file: StaticString = #filePath, line: UInt = #line) {
        //INI - TU para verificar memory leak (vazamento de memória - referência ciclica)
        addTeardownBlock { [weak instance] in
            XCTAssertNil(instance, file: file, line: line)
        }
        //FIM - TU
    }
}
