//
//  InfraTests.swift
//  InfraTests
//
//  Created by Wagner Coleta on 05/02/22.
//

import XCTest
import Alamofire
import Domain
import Data

class AlamofireAdapter {
    private let session: Session
    
    init(session: Session = .default){
        self.session = session
    }
    
    func get(to url: URL, completion: @escaping (Result<Data, HttpError>) -> Void) {
        session.request(url, method: .get).responseData { dataResponse in
            switch dataResponse.result {
                case .failure: completion(.failure(.noConnectivity))
                case .success: break
            }
        }
    }
}

class AlamofireAdapterTests: XCTestCase {

    func test_get_should_make_request_with_valid_url_and_method() {
        let url = makeUrl()
        testRequestFor(url: url) { request in
            XCTAssertEqual(url, request.url)
            XCTAssertEqual("GET", request.httpMethod)
        }
    }
    
    func test_get_should_complete_with_error_when_request_completes_with_error() {
        let sut = makeSut()
        UrlProtocolStub.simulate(data: nil, response: nil, error: makeError())
        let exp = expectation(description: "waiting")
        sut.get(to: makeUrl()) { result in
            switch result {
                case .failure(let error): XCTAssertEqual(error, .noConnectivity)
                case .success: XCTFail("Expected error got \(result) instead")
            }
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1)
    }
}

extension AlamofireAdapterTests {
    
    func makeSut(file: StaticString = #filePath, line: UInt = #line) -> AlamofireAdapter {
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [UrlProtocolStub.self]
        let session = Session(configuration: configuration)
        let sut = AlamofireAdapter(session: session)
        checkMemoryLeak(for: sut, file: file, line: line)
        return sut
    }
    
    func testRequestFor(url: URL = makeUrl(), action: @escaping (URLRequest) -> Void) {
        let sut = makeSut()
        let exp = expectation(description: "waiting")
        sut.get(to: url) { _ in exp.fulfill() }
        var requestTemp: URLRequest?
        UrlProtocolStub.observeRequest { request in
            requestTemp = request
        }
        wait(for: [exp], timeout: 1)
        action(requestTemp!)
    }
}

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
