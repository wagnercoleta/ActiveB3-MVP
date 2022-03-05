//
//  ReadActiveSpy.swift
//  PresentationTests
//
//  Created by Wagner Coleta on 19/02/22.
//

import Foundation
import Domain

class ReadActiveSpy: ReadActive {
    var readActiveModels: [ReadActiveModel]?
    var completion: ((ReadActive.Result) -> Void)?
    
    func read(readActiveModels: [ReadActiveModel], completion: @escaping (ReadActive.Result) -> Void) {
        self.readActiveModels = readActiveModels
        self.completion = completion
    }
    
    func completeWithError(_ error: DomainError) {
        completion?(.failure(error))
    }
    
    func completeWithActives(_ actives: [ActiveModel]) {
        completion?(.success(actives))
    }
}
