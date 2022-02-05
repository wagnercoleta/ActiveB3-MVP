//
//  ReadActive.swift
//  Domain
//
//  Created by Wagner Coleta on 05/02/22.
//

import Foundation

public protocol ReadActive {
    func read(readActiveModel: [ReadActiveModel], completion: @escaping (Result<[ActiveModel], Error>) -> Void)
}

public struct ReadActiveModel: Encodable {
    public let code: String
    
    public init(code: String) {
        self.code = code
    }
}

