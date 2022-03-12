//
//  AlamofireAdapterMock.swift
//  Infra
//
//  Created by Wagner Coleta on 12/03/22.
//

import Foundation
import Data

public final class AlamofireAdapterMock: HttpClientGet {
    
    public init(){
        
    }
    
    public func get(to url: URL, completion: @escaping (Result<Data?, HttpError>) -> Void) {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            
            let activePETR4 = url.absoluteString.contains("PETR4")
            
            if activePETR4 {
                completion(.success(makeActiveModelXML()))
            } else {
                let statusCode = Int.random(in: 204..<600)
                switch statusCode {
                    case 204:
                        completion(.success(nil))
                    case 200...299:
                        completion(.success(makeActiveModelXML()))
                    case 401:
                        completion(.failure(.unauthorized))
                    case 403:
                        completion(.failure(.forbidden))
                    case 400...499:
                        completion(.failure(.badRequest))
                    case 500...599:
                        completion(.failure(.serverError))
                    default:
                        completion(.failure(.noConnectivity))
                }
            }
            
        }
    }
}
