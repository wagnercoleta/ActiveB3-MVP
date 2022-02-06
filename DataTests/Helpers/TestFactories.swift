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
