//
//  TestFactories.swift
//  DataTests
//
//  Created by Wagner Coleta on 05/02/22.
//

import Foundation

func makeUrl() -> URL {
    return URL(string: "http://any-url.com")!
}

func makeInvalidData() -> Data {
    return Data("invalid_data_json".utf8)
}

func makeError() -> Error {
    return NSError(domain: "any_error", code: 0)
}

func makeValidData() -> Data {
    return Data("{[{\"code\":\"\"PETR4\"\"}]}".utf8)
}

func makeEmptyData() -> Data {
    return Data()
}

func makeHttpResponse(statusCode: Int = 200) -> HTTPURLResponse {
    return HTTPURLResponse(url: makeUrl(), statusCode: statusCode, httpVersion: nil, headerFields: nil)!
}

func makeActiveModelXML() -> Data? {
    let xml: String = "<ComportamentoPapeis>" +
    "<Papel Codigo=\"PETR4\" Nome=\"PETROBRAS PN N2\" Ibovespa=\"#\" Data=\"08/02/2022 21:52:41\" Abertura=\"31,90\" " +
        "Minimo=\"31,26\" Maximo=\"31,95\" Medio=\"31,62\" Ultimo=\"31,83\" Oscilacao=\"-1,00\"/> " +
    "<Papel Codigo=\"MGLU3\" Nome=\"MAGAZ LUIZA ON NM\" Ibovespa=\"#\" Data=\"08/02/2022 21:52:41\" Abertura=\"6,31\" " +
        "Minimo=\"6,24\" Maximo=\"6,54\" Medio=\"6,41\" Ultimo=\"6,54\" Oscilacao=\"3,65\"/>" +
    "<Papel Codigo=\"USIM5\" Nome=\"USIMINAS PNA N1\" Ibovespa=\"#\" Data=\"08/02/2022 21:52:41\" Abertura=\"16,86\" " +
        "Minimo=\"16,58\" Maximo=\"16,93\" Medio=\"16,75\" Ultimo=\"16,81\" Oscilacao=\"-0,24\"/>" +
    "</ComportamentoPapeis>"
    
    return Data(xml.utf8)
}
