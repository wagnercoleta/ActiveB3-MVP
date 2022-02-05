//
//  AddActive.swift
//  Domain
//
//  Created by Wagner Coleta on 05/02/22.
//

import Foundation

protocol AddActive {
    func add(addActiveModel: AddActiveModel, completion: @escaping (Result<ActiveModel, Error>) -> Void)
}

struct AddActiveModel {
    let code: String
    let name: String
    let price: Double
    let priceAlert: Double
    let variation: Double
    let operationLarger: Bool
}


