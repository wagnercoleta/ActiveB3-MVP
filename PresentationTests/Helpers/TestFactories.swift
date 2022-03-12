//
//  TestFactories.swift
//  PresentationTests
//
//  Created by Wagner Coleta on 26/02/22.
//

import Foundation
import Presentation

func makeReadActiveViewModel() -> ReadActiveRequest {
    let readActiveViewModel = ReadActiveRequest(codes: ["PETR4", "MGLU3"])
    return readActiveViewModel
}
