//
//  UseCaseFactory.swift
//  Main
//
//  Created by Wagner Coleta on 23/02/22.
//

import Foundation
import Data
import Infra
import Domain

final class UseCaseFactory {
    
    private static let httpClient = AlamofireAdapter()
    private static let baseURL = Environment.variable(.apiBaseUrl)
    
    static func makeRemoteReadActive() -> ReadActive {
        let urlComplete = "\(baseURL)/FormConsultaCotacoes.asp?strListaCodigos="
        let url = URL(string: urlComplete)!
        let remoteReadActive = RemoteReadActive(url: url, httpClient: httpClient)
        return remoteReadActive
    }
}

