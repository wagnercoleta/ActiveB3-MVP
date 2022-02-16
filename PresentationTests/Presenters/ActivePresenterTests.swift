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
        let (sut, alertViewSpy) = makeSut()
        let readActiveViewModel = ReadActiveViewModel(codes: [])
        sut.listActive(viewModel: readActiveViewModel)
        XCTAssertEqual(alertViewSpy.viewModel, AlertViewModel(title: "Falha na leitura dos ativos", message: "A lista de códigos dos ativos a serem retornados é obrigatório."))
    }
}

extension ActivePresenterTests {
    
    func makeSut() -> (sut: ActivePresenter, alertViewSpy: AlertViewSpy){
        let alertViewSpy = AlertViewSpy()
        let sut = ActivePresenter(alertView: alertViewSpy)
        return (sut, alertViewSpy)
    }
    
    class AlertViewSpy: AlertView {
        var viewModel: AlertViewModel?
        
        func showMessage(viewModel: AlertViewModel) {
            self.viewModel = viewModel
        }
    }
}
