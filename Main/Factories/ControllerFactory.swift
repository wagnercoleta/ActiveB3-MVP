//
//  ActiveFactory.swift
//  Main
//
//  Created by Wagner Coleta on 21/02/22.
//

import Foundation
import UI
import Presentation
import Validation
import Data
import Infra
import Domain

class ControllerFactory {
    static func makeActiveController(readActive: ReadActive) -> ActiveViewController {
        let controller = ActiveViewController.instantiate()
        let activeValidatorAdapter = ActiveValidatorAdapter()
        let presenter = ActivePresenter(alertView: WeakVarProxy(controller), activeValidator: activeValidatorAdapter, readActive: readActive, loadingView: WeakVarProxy(controller))
        controller.activeMethod = presenter.listActive
        return controller
    }
}

class WeakVarProxy<T: AnyObject> {
    private weak var instance: T?
    
    init(_ instance: T){
        self.instance = instance
    }
}

extension WeakVarProxy: AlertView where T: AlertView {
    func showMessage(viewModel: AlertViewModel) {
        instance?.showMessage(viewModel: viewModel)
    }
}

extension WeakVarProxy: LoadingView where T: LoadingView {
    func display(viewModel: LoadingViewModel) {
        instance?.display(viewModel: viewModel)
    }
}
