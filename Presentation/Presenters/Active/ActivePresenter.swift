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
    public static let titleSuccess = NSLocalizedString("Sucesso", comment: "")
    
    public static let messageActiveRequired = NSLocalizedString("A lista de códigos dos ativos a serem retornados é obrigatório.", comment: "")
    public static let messageActiveInvalid = NSLocalizedString("A lista de códigos dos ativos a serem retornados é inválida.", comment: "")
    public static let messageErrorInesperado = NSLocalizedString("Algo inesperado aconteceu, tente novamente mais tarde.", comment: "")
    public static let messageSuccess = NSLocalizedString("Dados processados com sucesso.", comment: "")
    public static let messageErrorActiveInUse = NSLocalizedString("Esse ativo já está em uso.", comment: "")
}

public final class ActivePresenter {
    private let alertView: AlertView
    private let readActive: ReadActive
    private let loadingView: LoadingView
    private let validation: Validation
    private let presenterView: PresenterView
    
    public init(alertView: AlertView, readActive: ReadActive,
                loadingView: LoadingView, validation: Validation,
                presenterView: PresenterView) {
        self.alertView = alertView
        self.readActive = readActive
        self.loadingView = loadingView
        self.validation = validation
        self.presenterView = presenterView
    }
    
    public func listActive(viewModel: ReadActiveRequest){
        if let message = validation.validate(data: viewModel.toJson()) {
            alertView.showMessage(viewModel: AlertViewModel(title: ActivePresenterConstans.titleAlert, message: message))
        } else {
            loadingView.display(viewModel: LoadingViewModel(isLoading: true))
            
            var readActiveModels = [ReadActiveModel]()
            viewModel.codes?.forEach({ code in
                readActiveModels.append(ReadActiveModel(code: code))
            })
            
            readActive.read(readActiveModels: readActiveModels) { [weak self] result in
                guard let self = self else { return }
                self.loadingView.display(viewModel: LoadingViewModel(isLoading: false))
                switch result {
                case .failure(let error):
                    var errorMessage: String!
                    switch error {
                    case .activeInUse:
                        errorMessage = ActivePresenterConstans.messageErrorActiveInUse
                    default:
                        errorMessage = ActivePresenterConstans.messageErrorInesperado
                    }
                    self.alertView.showMessage(viewModel: AlertViewModel(title: ActivePresenterConstans.titleError, message: errorMessage))
                case .success(let activeModels):
                    self.presenterView.loadItens(activeModels: activeModels!)
                    self.alertView.showMessage(viewModel: AlertViewModel(title: ActivePresenterConstans.titleSuccess, message: ActivePresenterConstans.messageSuccess))
                }
            }
        }
    }
}
