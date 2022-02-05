//
//  DataTests.swift
//  DataTests
//
//  Created by Wagner Coleta on 05/02/22.
//

import XCTest
import Domain
import Data

class RemoteReadActiveTests: XCTestCase {

    func test_read_should_call_httpClient_with_correct_url() {
        let url = URL(string: "http://any-url.com")!
        let (sut, httpClientSpy) = makeSut(url: url)
        let readActiveModels = makeReadActiveModels()
        sut.read(readActiveModels: readActiveModels) { _ in }
        XCTAssertEqual(httpClientSpy.urls, [url])
    }
    
    func test_read_should_call_httpClient_with_correct_data() {
        let (sut, httpClientSpy) = makeSut()
        let readActiveModels = makeReadActiveModels()
        let data = toData(readActiveModels)
        sut.read(readActiveModels: readActiveModels) { _ in }
        XCTAssertEqual(httpClientSpy.data, data)
    }
    
    func test_read_should_complete_with_error_if_client_completes_with_error() {
        let (sut, httpClientSpy) = makeSut()
        let readActiveModels = makeReadActiveModels()
        let exp = expectation(description: "waiting-async")//async
        sut.read(readActiveModels: readActiveModels) { result in
            switch result {
                case .failure(let error): XCTAssertEqual(error, .unexpected)
                case .success: XCTFail("Expected error received \(result) instead")
            }
            exp.fulfill()
        }
        httpClientSpy.completeWithError(.noConnectivity)
        wait(for: [exp], timeout: 1)//aguarda 1s para executar o exp.fulfill() async
    }
    
    func test_read_should_complete_with_active_if_client_completes_with_data() {
        let (sut, httpClientSpy) = makeSut()
        let readActiveModels = makeReadActiveModels()
        let expectedActives = makeActiveModels()
        let exp = expectation(description: "waiting-async")//async
        sut.read(readActiveModels: readActiveModels) { result in
            switch result {
                case .failure: XCTFail("Expected success received \(result) instead")
                case .success(let receivedActives): XCTAssertEqual(receivedActives, expectedActives)
            }
            exp.fulfill()
        }
        let data = toData(expectedActives)!
        httpClientSpy.completeWithData(data)
        wait(for: [exp], timeout: 1)//aguarda 1s para executar o exp.fulfill() async
    }
    
}

//Helper TestsClass
extension RemoteReadActiveTests {
    
    func toData(_ readActiveModels: [ReadActiveModel]) -> Data? {
        return try? JSONEncoder().encode(readActiveModels)
    }
    
    func toData(_ activeModels: [ActiveModel]) -> Data? {
        return try? JSONEncoder().encode(activeModels)
    }
    
    func makeSut(url: URL = URL(string: "http://any-url.com")!) -> (sut: RemoteReadActive, httpClientSpy: HttpClientSpy)  {
        let httpClientSpy = HttpClientSpy()
        let sut = RemoteReadActive(url: url, httpClient: httpClientSpy)
        return (sut, httpClientSpy)
    }
    
    func makeReadActiveModels() -> [ReadActiveModel]{
        let result:[ReadActiveModel] = [ReadActiveModel(code: "PETR4"), ReadActiveModel(code: "MGLU3")]
        return result
    }
    
    func makeActiveModels() -> [ActiveModel]{
        let result:[ActiveModel] = [
            ActiveModel(id: "1", code: "PETR4", name: "PETROBRAS", price: 26.20, priceAlert: 27.00, variation: 2.00, operationLarger: false),
            ActiveModel(id: "2", code: "MGLU3", name: "MAGALU", price: 7.00, priceAlert: 10.50, variation: 5.00, operationLarger: false)
        ]
        return result
    }
    
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
}
