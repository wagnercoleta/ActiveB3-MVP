//
//  ActiveComposer.swift
//  Main
//
//  Created by Wagner Coleta on 23/02/22.
//

import Foundation
import UI
import Presentation
import Validation
import Data
import Infra
import Domain

public final class ActiveComposer {
    public static func composeControllerWith(readActive: ReadActive) -> ActiveViewController {
        let controller = ActiveViewController.instantiate()
        let activeValidatorAdapter = ActiveValidatorAdapter()
        let presenter = ActivePresenter(alertView: WeakVarProxy(controller), activeValidator: activeValidatorAdapter, readActive: readActive, loadingView: WeakVarProxy(controller))
        controller.activeMethod = presenter.listActive
        return controller
    }
}
