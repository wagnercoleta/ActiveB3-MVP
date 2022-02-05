//
//  Model.swift
//  Domain
//
//  Created by Wagner Coleta on 05/02/22.
//

import Foundation

public protocol Model: Codable, Equatable {
    
}

public extension Model {
    func toData() -> Data? {
        return try? JSONEncoder().encode(self)
    }
}

