//
//  InfraTests.swift
//  InfraTests
//
//  Created by Wagner Coleta on 05/02/22.
//

import XCTest
import Alamofire
import Domain

class AlamofireAdapter {
    private let session: Session
    
    init(session: Session = .default){
        self.session = session
    }
    
    func get(to url: URL) {
        session.request(url, method: .get).resume()
    }
}

class AlamofireAdapterTests: XCTestCase {

    func test_get_should_make_request_with_valid_url_and_method() {
        let url = makeUrl()
        let sut = makeSut()
        sut.get(to: url)
        let exp = expectation(description: "waiting")
        UrlProtocolStub.observeRequest { request in
            XCTAssertEqual(url, request.url)
            XCTAssertEqual("GET", request.httpMethod)
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1)
    }
}

extension AlamofireAdapterTests {
    func makeSut() -> AlamofireAdapter {
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [UrlProtocolStub.self]
        let session = Session(configuration: configuration)
        return AlamofireAdapter(session: session)
    }
}

//Classe para interceptar qualquer request
class UrlProtocolStub: URLProtocol {
    
    static var emit: ((URLRequest) -> Void)?
    
    static func observeRequest(completion: @escaping (URLRequest) -> Void){
        UrlProtocolStub.emit = completion
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
    }
    
    override func stopLoading() {
        
    }
}
