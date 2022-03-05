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
    
    func test_active_should_call_validation_with_correct_values() {
        let (sut, _, _, _, validationSpy) = makeSut()
        let readActiveViewModel = ReadActiveViewModel(codes: ["PETR4", "MGLU3"])
        sut.listActive(viewModel: readActiveViewModel)
        XCTAssertTrue(NSDictionary(dictionary: validationSpy.data!).isEqual(to: readActiveViewModel.toJson()!))
    }
    
    func test_active_should_show_error_message_if_validation_fails() {
        let (sut, alertViewSpy, _, _, validationSpy) = makeSut()
        let exp = expectation(description: "waiting")
        let errorMessage = ActivePresenterConstans.messageActiveRequired
        alertViewSpy.observe { [weak self] viewModel in
            XCTAssertEqual(viewModel, self?.makeAlertViewModel(ActivePresenterConstans.titleAlert,
                                                               errorMessage))
            exp.fulfill()
        }
        validationSpy.simulateError(errorMessage)
        sut.listActive(viewModel: ReadActiveViewModel(codes: []))
        wait(for: [exp], timeout: 1)
    }
    
    func test_should_show_error_message_if_array_active_is_not_provided() {
        let (sut, alertViewSpy, _, _, validationSpy) = makeSut()
        let readActiveViewModel = ReadActiveViewModel(codes: [])
        let exp = expectation(description: "waiting")
        alertViewSpy.observe { [weak self] viewModel in
            XCTAssertEqual(viewModel, self?.makeAlertViewModel(ActivePresenterConstans.titleAlert,
                                                               ActivePresenterConstans.messageActiveRequired))
            exp.fulfill()
        }
        validationSpy.simulateError(ActivePresenterConstans.messageActiveRequired)
        sut.listActive(viewModel: readActiveViewModel)
        wait(for: [exp], timeout: 1)
    }
    
    func test_should_show_generic_error_message_if_readActive_fails() {
        let (sut, alertViewSpy, readActiveSpy, _, _) = makeSut()
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
    
    func test_should_show_active_in_use_error_message_if_readActive_returns_active_in_use_error() {
        let (sut, alertViewSpy, readActiveSpy, _, _) = makeSut()
        let readActiveViewModel = ReadActiveViewModel(codes: ["PETR4", "MGLU3"])
        let exp = expectation(description: "waiting")
        alertViewSpy.observe { [weak self] viewModel in
            XCTAssertEqual(viewModel, self?.makeAlertViewModel(ActivePresenterConstans.titleError,
                                                               ActivePresenterConstans.messageErrorActiveInUse))
            exp.fulfill()
        }
        sut.listActive(viewModel: readActiveViewModel)
        readActiveSpy.completeWithError(.activeInUse)
        wait(for: [exp], timeout: 1)
    }
    
    func test_should_show_success_message_if_readActive_succeeds() {
        let (sut, alertViewSpy, readActiveSpy, _, _) = makeSut()
        let readActiveViewModel = ReadActiveViewModel(codes: ["PETR4", "MGLU3"])
        let exp = expectation(description: "waiting")
        alertViewSpy.observe { [weak self] viewModel in
            XCTAssertEqual(viewModel, self?.makeAlertViewModel(ActivePresenterConstans.titleSuccess,
                                                               ActivePresenterConstans.messageSuccess))
            exp.fulfill()
        }
        sut.listActive(viewModel: readActiveViewModel)
        readActiveSpy.completeWithActives(makeActiveModels())
        wait(for: [exp], timeout: 1)
    }
    
    func test_should_show_loading_before_and_after_readActive() {
        let (sut, _, readActiveSpy, loadingViewSpy, _) = makeSut()
        let readActiveViewModel = ReadActiveViewModel(codes: ["PETR4", "MGLU3"])
        
        let exp = expectation(description: "waiting")
        loadingViewSpy.observe { viewModel in
            XCTAssertEqual(viewModel, LoadingViewModel(isLoading: true))
            exp.fulfill()
        }
        sut.listActive(viewModel: readActiveViewModel)
        wait(for: [exp], timeout: 1)
        
        let exp2 = expectation(description: "waiting")
        loadingViewSpy.observe { viewModel in
            XCTAssertEqual(viewModel, LoadingViewModel(isLoading: false))
            exp2.fulfill()
        }
        readActiveSpy.completeWithError(.unexpected)
        wait(for: [exp2], timeout: 1)
    }
}

extension ActivePresenterTests {
    
    func makeSut(file: StaticString = #filePath, line: UInt = #line) -> (sut: ActivePresenter, alertViewSpy: AlertViewSpy, readActiveSpy: ReadActiveSpy, loadingViewSpy: LoadingViewSpy, validation: ValidationSpy){
        let alertViewSpy = AlertViewSpy()
        let readActiveSpy = ReadActiveSpy()
        let loadingViewSpy = LoadingViewSpy()
        let validationSpy = ValidationSpy()
        let presenterViewSpy = PresenterViewSpy()
        let sut = ActivePresenter(alertView: alertViewSpy, readActive: readActiveSpy,
                                  loadingView: loadingViewSpy, validation: validationSpy,
                                  presenterView: presenterViewSpy)
        checkMemoryLeak(for: sut, file: file, line: line)
        return (sut, alertViewSpy, readActiveSpy, loadingViewSpy, validationSpy)
    }
    
    func makeAlertViewModel(_ title: String, _ message: String) -> AlertViewModel {
        return AlertViewModel(title: title, message: message)
    }
}
