//
//  ActiveModel.swift
//  Domain
//
//  Created by Wagner Coleta on 05/02/22.
//

import Foundation

public struct ActiveModel: Model {
    public let id: String
    public let code: String
    public let name: String
    public let price: Double
    public let priceAlert: Double
    public let variation: Double
    public let operationLarger: Bool
    
    public init(id: String, code: String, name: String, price: Double, priceAlert: Double, variation: Double, operationLarger: Bool) {
        self.id = id
        self.code = code
        self.name = name
        self.price = price
        self.priceAlert = price
        self.variation = variation
        self.operationLarger = operationLarger
    }
}
