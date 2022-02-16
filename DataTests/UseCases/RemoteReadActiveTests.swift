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
        let url = makeUrl()
        let (sut, httpClientSpy) = makeSut(url: url)
        let readActiveModels = makeReadActiveModels()
        sut.read(readActiveModels: readActiveModels) { _ in }
        XCTAssertEqual(httpClientSpy.urls, [url])
    }
    
    func test_read_should_complete_with_error_if_client_completes_with_error() {
        let (sut, httpClientSpy) = makeSut()
        expect(sut, completeWith: .failure(.unexpected), when: {
            httpClientSpy.completeWithError(.noConnectivity)
        })
    }
    
    func test_read_should_complete_with_active_if_client_completes_with_valid_data() {
        let (sut, httpClientSpy) = makeSut()
        let expectedActives = makeActiveModels()
        expect(sut, completeWith: .success(expectedActives), when: {
            let data = toData(expectedActives)!
            httpClientSpy.completeWithData(data)
        })
    }
    
    func test_read_should_complete_with_error_if_client_completes_with_invalid_data() {
        let (sut, httpClientSpy) = makeSut()
        expect(sut, completeWith: .failure(.unexpected), when: {
            httpClientSpy.completeWithData(makeInvalidData())
        })
    }
    
    func test_read_should_not_complete_if_sut_has_been_deallocated() {
        let httpClientSpy = HttpClientSpy()
        var sut: RemoteReadActive? = RemoteReadActive(url: makeUrl(), httpClient: httpClientSpy)
        var resultTemp: Result<[ActiveModel]?, DomainError>?
        sut?.read(readActiveModels: makeReadActiveModels()) { result in
            resultTemp = result
        }
        sut = nil
        httpClientSpy.completeWithError(.noConnectivity)
        XCTAssertNil(resultTemp)
    }
    
    func test_read_should_complete_extract_xml_at_data() {
        let httpClientSpy = HttpClientSpy()
        let sut = RemoteReadActive(url: makeUrl(), httpClient: httpClientSpy)
        let data = makeActiveModelXML()!
        let activeModels = sut.extractXMLtoResult(data: data)
        XCTAssertNotNil(activeModels)
        XCTAssert(activeModels!.count > 0)
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
    
    func makeSut(url: URL = URL(string: "http://any-url.com")!, file: StaticString = #filePath, line: UInt = #line) -> (sut: RemoteReadActive, httpClientSpy: HttpClientSpy)  {
        let httpClientSpy = HttpClientSpy()
        let sut = RemoteReadActive(url: url, httpClient: httpClientSpy)
        checkMemoryLeak(for: sut, file: file, line: line)
        checkMemoryLeak(for: httpClientSpy, file: file, line: line)
        return (sut, httpClientSpy)
    }
    
    func expect(_ sut: RemoteReadActive, completeWith expectedResult: Result<[ActiveModel], DomainError>, when action: () -> Void, file: StaticString = #filePath, line: UInt = #line){
        let readActiveModels = makeReadActiveModels()
        let exp = expectation(description: "waiting-async")//async
        sut.read(readActiveModels: readActiveModels) { receivedResult in
            switch (expectedResult, receivedResult) {
            case (.failure(let expectedError), .failure(let receivedError)): XCTAssertEqual(expectedError, receivedError, file: file, line: line)
                case (.success(let expectedActive), .success(let receivedActive)): XCTAssertEqual(expectedActive, receivedActive, file: file, line: line)
                default: XCTFail("Expected \(expectedResult) received \(receivedResult) instead", file: file, line: line)
            }
            exp.fulfill()
        }
        action()
        wait(for: [exp], timeout: 1)//aguarda 1s para executar o exp.fulfill() async
    }
    
    func makeReadActiveModels() -> [ReadActiveModel]{
        let result:[ReadActiveModel] = [ReadActiveModel(code: "PETR4"), ReadActiveModel(code: "MGLU3")]
        return result
    }
}
