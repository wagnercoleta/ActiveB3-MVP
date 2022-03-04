//
//  WeakVarProxy.swift
//  Main
//
//  Created by Wagner Coleta on 23/02/22.
//

import Foundation
import Presentation
import Domain

//Designer Pather Proxy - Insere uma camada para remover referência ciclica e evitar memory leak
final class WeakVarProxy<T: AnyObject> {
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

extension WeakVarProxy: PresenterView where T: PresenterView {
    func loadItens(activeModels: [ActiveModel]) {
        instance?.loadItens(activeModels: activeModels)
    }
}

