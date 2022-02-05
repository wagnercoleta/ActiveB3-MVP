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
    
    public func read(readActiveModels: [ReadActiveModel], completion: @escaping (Result<[ActiveModel], DomainError>) -> Void) {
        
        let data = try? JSONEncoder().encode(readActiveModels)
        httpClient.get(to: self.url, with: data) { error in
            completion(.failure(.unexpected))
        }
    }
}
