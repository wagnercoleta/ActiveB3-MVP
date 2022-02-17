//
//  ActivePresenter.swift
//  Presentation
//
//  Created by Wagner Coleta on 16/02/22.
//

import Foundation

public struct ActivePresenterConstans {
    public static let titleAlert = NSLocalizedString("Falha na leitura dos ativos", comment: "")
    public static let messageActiveRequired = NSLocalizedString("A lista de códigos dos ativos a serem retornados é obrigatório.", comment: "")
    public static let messageActiveInvalid = NSLocalizedString("A lista de códigos dos ativos a serem retornados é inválida.", comment: "")
}

public final class ActivePresenter {
    private let alertView: AlertView
    private let activeValidator: ActiveValidator
    
    public init(alertView: AlertView, activeValidator: ActiveValidator) {
        self.alertView = alertView
        self.activeValidator = activeValidator
    }
    
    public func listActive(viewModel: ReadActiveViewModel){
        if let message = validate(viewModel: viewModel) {
            alertView.showMessage(viewModel: AlertViewModel(title: ActivePresenterConstans.titleAlert, message: message))
        }
    }
    
    private func validate(viewModel: ReadActiveViewModel) -> String? {
        if viewModel.codes == nil || viewModel.codes!.count <= 0 {
            return ActivePresenterConstans.messageActiveRequired
        }
        
        var isValid = true
        if let codes = viewModel.codes {
            codes.forEach { code in
                if (isValid) {
                    isValid = activeValidator.isValid(active: code)
                }
            }
        }
        if (!isValid) {
            return ActivePresenterConstans.messageActiveInvalid
        }
        
        return nil
    }
}

public struct ReadActiveViewModel {
    public var codes: [String]?
    
    public init(codes: [String]?){
        self.codes = codes
    }
}
