//
//  ActiveValidatorAdapter.swift
//  Validation
//
//  Created by Wagner Coleta on 21/02/22.
//

import Foundation
import Validation

public final class ActiveValidatorAdapter: ActiveValidator {
    
    private let pattern = "([A-Z]{4}[1-9]{1})"
    
    public init() {}
    
    public func isValid(active: String) -> Bool {
        if (active.count == 5) {
            let range = NSRange(location: 0, length: active.utf16.count)
            let regex = try! NSRegularExpression(pattern: pattern)
            return regex.firstMatch(in: active, options: [], range: range) != nil
        }
        return false
    }
}
