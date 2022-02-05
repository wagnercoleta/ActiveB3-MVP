//
//  ActiveModelFactory.swift
//  DataTests
//
//  Created by Wagner Coleta on 05/02/22.
//

import Foundation
import Domain

func makeActiveModels() -> [ActiveModel]{
    let result:[ActiveModel] = [
        ActiveModel(id: "1", code: "PETR4", name: "PETROBRAS", price: 26.20, priceAlert: 27.00, variation: 2.00, operationLarger: false),
        ActiveModel(id: "2", code: "MGLU3", name: "MAGALU", price: 7.00, priceAlert: 10.50, variation: 5.00, operationLarger: false)
    ]
    return result
}
