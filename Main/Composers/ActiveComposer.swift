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
        let validationComposite = ValidationComposite(validations: makeValidations())
        let presenter = ActivePresenter(alertView: WeakVarProxy(controller), readActive: readActive, loadingView: WeakVarProxy(controller),
                                        validation: validationComposite, presenterView: WeakVarProxy(controller))
        controller.activeMethod = presenter.listActive
        return controller
    }
    
    public static func makeValidations() -> [Validation] {
        return [
            RequiredFieldValidation(fieldName: "codes", fieldLabel: "ativos"),
            ActiveValidation(fieldName: "codes", fieldLabel: "ativos", activeValidator: ActiveValidatorAdapter())
        ]
    }
}
