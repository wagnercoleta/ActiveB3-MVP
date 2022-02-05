//
//  ExtensionHelpers.swift
//  Data
//
//  Created by Wagner Coleta on 05/02/22.
//

import Foundation

public extension Data {
    func toModel<T: Decodable>() -> T? {
        return try? JSONDecoder().decode(T.self, from: self)
    }
}
