//
//  ActiveValidator.swift
//  Presentation
//
//  Created by Wagner Coleta on 16/02/22.
//

import Foundation

public protocol ActiveValidator {
    func isValid(active: String) -> Bool
}
