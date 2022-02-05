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

public struct ReadActiveModel {
    public let code: String
}

