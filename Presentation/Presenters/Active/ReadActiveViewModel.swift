//
//  ReadActiveViewModel.swift
//  Presentation
//
//  Created by Wagner Coleta on 19/02/22.
//

import Foundation
import Domain

public struct ReadActiveViewModel: Model {
    public var codes: [String]?
    
    public init(codes: [String]?){
        self.codes = codes
    }
}
