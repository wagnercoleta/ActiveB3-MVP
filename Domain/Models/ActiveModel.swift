//
//  ActiveModel.swift
//  Domain
//
//  Created by Wagner Coleta on 05/02/22.
//

import Foundation

public struct ActiveModel {
    public let id: String
    public let code: String
    public let name: String
    public let price: Double
    public let priceAlert: Double
    public let variation: Double
    public let operationLarger: Bool
}
