//
//  ReadActive.swift
//  Domain
//
//  Created by Wagner Coleta on 05/02/22.
//

import Foundation

public protocol ReadActive {
    typealias Result = Swift.Result<[ActiveModel]?, DomainError>
    func read(readActiveModels: [ReadActiveModel], completion: @escaping (Result) -> Void)
}

public struct ReadActiveModel: Model {
    public let code: String
    
    public init(code: String) {
        self.code = code
    }
}
