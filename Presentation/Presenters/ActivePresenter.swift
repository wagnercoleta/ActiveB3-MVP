//
//  ActivePresenter.swift
//  Presentation
//
//  Created by Wagner Coleta on 16/02/22.
//

import Foundation

public final class ActivePresenter {
    private let alertView: AlertView
    private let activeValidator: ActiveValidator
    
    public init(alertView: AlertView, activeValidator: ActiveValidator) {
        self.alertView = alertView
        self.activeValidator = activeValidator
    }
    
    public func listActive(viewModel: ReadActiveViewModel){
        if let message = validate(viewModel: viewModel) {
            alertView.showMessage(viewModel: AlertViewModel(title: "Falha na leitura dos ativos", message: message))
        }
        
        if let codes = viewModel.codes {
            codes.forEach { code in
                _ = activeValidator.isValid(active: code)
            }
        }
    }
    
    private func validate(viewModel: ReadActiveViewModel) -> String? {
        if viewModel.codes == nil || viewModel.codes!.count <= 0 {
            return "A lista de códigos dos ativos a serem retornados é obrigatório."
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
