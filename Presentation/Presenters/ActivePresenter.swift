//
//  ActivePresenter.swift
//  Presentation
//
//  Created by Wagner Coleta on 16/02/22.
//

import Foundation
import Domain

public struct ActivePresenterConstans {
    public static let titleAlert = NSLocalizedString("Falha na leitura dos ativos", comment: "")
    public static let titleError = NSLocalizedString("Error", comment: "")
    
    public static let messageActiveRequired = NSLocalizedString("A lista de códigos dos ativos a serem retornados é obrigatório.", comment: "")
    public static let messageActiveInvalid = NSLocalizedString("A lista de códigos dos ativos a serem retornados é inválida.", comment: "")
    public static let messageErrorInesperado = NSLocalizedString("Algo inesperado aconteceu, tente novamente mais tarde.", comment: "")
}

public final class ActivePresenter {
    private let alertView: AlertView
    private let activeValidator: ActiveValidator
    private let readActive: ReadActive
    private let loadingView: LoadingView
    
    public init(alertView: AlertView, activeValidator: ActiveValidator, readActive: ReadActive,
                loadingView: LoadingView) {
        self.alertView = alertView
        self.activeValidator = activeValidator
        self.readActive = readActive
        self.loadingView = loadingView
    }
    
    public func listActive(viewModel: ReadActiveViewModel){
        if let message = validate(viewModel: viewModel) {
            alertView.showMessage(viewModel: AlertViewModel(title: ActivePresenterConstans.titleAlert, message: message))
        } else {
            var readActiveModels = [ReadActiveModel]()
            viewModel.codes?.forEach({ code in
                readActiveModels.append(ReadActiveModel(code: code))
            })
            
            loadingView.display(viewModel: LoadingViewModel(isLoading: true))
            
            readActive.read(readActiveModels: readActiveModels) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .failure: self.alertView.showMessage(viewModel: AlertViewModel(title: ActivePresenterConstans.titleError, message: ActivePresenterConstans.messageErrorInesperado))
                case .success: break
                }
            }
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
