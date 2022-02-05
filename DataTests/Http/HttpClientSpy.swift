//
//  HttpClientSpy.swift
//  DataTests
//
//  Created by Wagner Coleta on 05/02/22.
//

import Foundation
import Data

class HttpClientSpy: HttpClientGet {
    var urls = [URL]()
    var data: Data?
    var completion: ((Result<Data, HttpError>) -> Void)?
    
    func get(to url: URL, with data: Data?, completion: @escaping (Result<Data, HttpError>) -> Void) {
        self.urls.append(url)
        self.data = data
        self.completion = completion
    }
    
    func completeWithError(_ error: HttpError){
        completion?(.failure(error))
    }
    
    func completeWithData(_ data: Data){
        completion?(.success(data))
    }
}
