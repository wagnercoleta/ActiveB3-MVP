//
//  UrlProtocolStub.swift
//  InfraTests
//
//  Created by Wagner Coleta on 06/02/22.
//

import Foundation

//Classe para interceptar qualquer request
class UrlProtocolStub: URLProtocol {
    
    static var emit: ((URLRequest) -> Void)?
    static var data: Data?
    static var response: HTTPURLResponse?
    static var error: Error?
    
    static func observeRequest(completion: @escaping (URLRequest) -> Void){
        UrlProtocolStub.emit = completion
    }
    
    static func simulate(data: Data?, response: HTTPURLResponse?, error: Error?){
        UrlProtocolStub.data = data
        UrlProtocolStub.response = response
        UrlProtocolStub.error = error
    }
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true //Configura para interceptar qualquer request do Adapter
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request //Retorna a request
    }
    
    //Lógica de tratamento da requisição
    override func startLoading() {
        UrlProtocolStub.emit?(request)
        if let data = UrlProtocolStub.data {
            client?.urlProtocol(self, didLoad: data)
        }
        if let response = UrlProtocolStub.response {
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
        }
        if let error = UrlProtocolStub.error {
            client?.urlProtocol(self, didFailWithError: error)
        }
        client?.urlProtocolDidFinishLoading(self)//sinaliza que o request já pode ser disparado
    }
    
    override func stopLoading() {
        
    }
}
