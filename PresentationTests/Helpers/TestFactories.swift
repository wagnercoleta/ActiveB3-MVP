//
//  TestFactories.swift
//  PresentationTests
//
//  Created by Wagner Coleta on 26/02/22.
//

import Foundation
import Presentation

func makeReadActiveViewModel() -> ReadActiveViewModel {
    let readActiveViewModel = ReadActiveViewModel(codes: ["PETR4", "MGLU3"])
    return readActiveViewModel
}
