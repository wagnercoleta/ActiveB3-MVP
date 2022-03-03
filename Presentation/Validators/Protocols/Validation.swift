//
//  Validation.swift
//  Presentation
//
//  Created by Wagner Coleta on 02/03/22.
//

import Foundation

public protocol Validation {
    func validate(data: [String: Any]?) -> String?
}
