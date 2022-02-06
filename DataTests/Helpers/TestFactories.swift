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

func makeHttpResponse(statusCode: Int = 200) -> HTTPURLResponse {
    return HTTPURLResponse(url: makeUrl(), statusCode: statusCode, httpVersion: nil, headerFields: nil)!
}
