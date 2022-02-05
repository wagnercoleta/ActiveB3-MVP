//
//  ReadActive.swift
//  Domain
//
//  Created by Wagner Coleta on 05/02/22.
//

import Foundation

protocol ReadActive {
    func read(readActiveModel: [ReadActiveModel], completion: @escaping (Result<[ActiveModel], Error>) -> Void)
}

struct ReadActiveModel {
    let code: String
}

