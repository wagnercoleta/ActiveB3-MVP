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
        let presenter = ActivePresenter(alertView: controller, activeValidator: activeValidatorAdapter, readActive: readActive, loadingView: controller)
        controller.activeMethod = presenter.listActive
        return controller
    }
}
