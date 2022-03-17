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
        "Minimo=\"16,58\" Maximo=\"13,58\" Medio=\"16,75\" Ultimo=\"10,18\" Oscilacao=\"1,57\"/>" +
    "<Papel Codigo=\"GGBR4\" Nome=\"GERDAU PN ED N1\" Ibovespa=\"#\" Data=\"08/02/2022 21:52:41\" Abertura=\"16,86\" " +
        "Minimo=\"16,58\" Maximo=\"27,98\" Medio=\"16,75\" Ultimo=\"26,21\" Oscilacao=\"1,52\"/>" +
    "<Papel Codigo=\"FESA4\" Nome=\"FERBASA PN N1\" Ibovespa=\"#\" Data=\"08/02/2022 21:52:41\" Abertura=\"16,86\" " +
        "Minimo=\"16,58\" Maximo=\"32,90\" Medio=\"16,75\" Ultimo=\"43,00\" Oscilacao=\"-0,05\"/>" +
    "<Papel Codigo=\"GOLL4\" Nome=\"GOL PN N2\" Ibovespa=\"#\" Data=\"08/02/2022 21:52:41\" Abertura=\"16,86\" " +
        "Minimo=\"16,58\" Maximo=\"14,21\" Medio=\"16,75\" Ultimo=\"12,30\" Oscilacao=\"5,65\"/>" +
    "<Papel Codigo=\"VALE3\" Nome=\"VALE ON ED NM\" Ibovespa=\"#\" Data=\"08/02/2022 21:52:41\" Abertura=\"16,86\" " +
        "Minimo=\"16,58\" Maximo=\"14,21\" Medio=\"16,75\" Ultimo=\"90,49\" Oscilacao=\"1,71\"/>" +
    "<Papel Codigo=\"AZUL4\" Nome=\"AZUL PN N2\" Ibovespa=\"#\" Data=\"08/02/2022 21:52:41\" Abertura=\"16,86\" " +
        "Minimo=\"16,58\" Maximo=\"14,21\" Medio=\"16,75\" Ultimo=\"21,22\" Oscilacao=\"5,57\"/>" +
    "</ComportamentoPapeis>"
    
    return Data(xml.utf8)
}
