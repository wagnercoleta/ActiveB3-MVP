//
//  ActiveValidatorSpy.swift
//  PresentationTests
//
//  Created by Wagner Coleta on 19/02/22.
//

import Foundation
import Presentation

class ActiveValidatorSpy: ActiveValidator {
    var isValid = true
    var codes: [String]?
    
    func isValid(active: String) -> Bool {
        
        if (codes == nil) {
            codes = []
        }
        
        if (!codes!.contains(active)) {
            codes?.append(active)
        }
        
        return isValid
    }
}
