//
//  PresenterViewSpy.swift
//  PresentationTests
//
//  Created by Wagner Coleta on 03/03/22.
//

import Foundation
import Domain
import Presentation

class PresenterViewSpy: PresenterView {
    var emit: (([ActiveModel]) -> Void)?
    
    func observe(completion: @escaping ([ActiveModel]) -> Void) {
        self.emit = completion
    }
    
    func loadItens(activeModels: [ActiveModel]) {
        self.emit?(activeModels)
    }
}
