//
//  RemoteReadActive.swift
//  Data
//
//  Created by Wagner Coleta on 05/02/22.
//

import Foundation
import Domain

public final class RemoteReadActive: ReadActive {
    private let url: URL
    private let httpClient: HttpClientGet
    
    public init(url: URL, httpClient: HttpClientGet){
        self.url = url
        self.httpClient = httpClient
    }
    
    public func read(readActiveModels: [ReadActiveModel], completion: @escaping (Result<[ActiveModel]?, DomainError>) -> Void) {
        
        httpClient.get(to: self.url) { [weak self] result in
            guard self != nil else { return }
            switch result {
                case .success(let data):
                    if let activeModels = try? JSONDecoder().decode([ActiveModel].self, from: data!) {
                        completion(.success(activeModels))
                    } else {
                        completion(.failure(.unexpected))
                    }
                case .failure: completion(.failure(.unexpected))
            }
        }
    }
}

