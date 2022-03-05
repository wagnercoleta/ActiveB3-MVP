//
//  ApiUrlFactory.swift
//  Main
//
//  Created by Wagner Coleta on 05/03/22.
//

import Foundation

func makeApiUrl() -> URL {
    let baseURL = Environment.variable(.apiBaseUrl)
    let urlComplete = "\(baseURL)/FormConsultaCotacoes.asp?strListaCodigos="
    let url = URL(string: urlComplete)!
    return url
}
