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
    
    static func makeRemoteReadActive() -> ReadActive {
        let url = URL(string: "https://bvmf.bmfbovespa.com.br/cotacoes2000/FormConsultaCotacoes.asp?strListaCodigos=")!
        let remoteReadActive = RemoteReadActive(url: url, httpClient: httpClient)
        return remoteReadActive
    }
}

