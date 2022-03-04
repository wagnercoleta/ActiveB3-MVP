//
//  PresenterView.swift
//  Presentation
//
//  Created by Wagner Coleta on 03/03/22.
//

import Foundation
import Domain

public protocol PresenterView {
    func loadItens(activeModels: [ActiveModel])
}
