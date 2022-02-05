//
//  DataTests.swift
//  DataTests
//
//  Created by Wagner Coleta on 05/02/22.
//

import XCTest
import Domain

class RemoteReadActive {
    private let url: URL
    private let httpClient: HttpClientGet
    
    init(url: URL, httpClient: HttpClientGet){
        self.url = url
        self.httpClient = httpClient
    }
    
    func read(readActiveModels: [ReadActiveModel]) {
        let data = try? JSONEncoder().encode(readActiveModels)
        httpClient.get(to: self.url, with: data)
    }
}

//SOLID - "I -> Interface Segregation Principle (ISP)
protocol HttpClientGet {
    func get(to url: URL, with data: Data?)
}

class RemoteReadActiveTests: XCTestCase {

    func test_read_should_call_httpClient_with_correct_url() {
        let url = URL(string: "http://any-url.com")!
        let (sut, httpClientSpy) = makeSut(url: url)
        let readActiveModels = makeReadActiveModels()
        sut.read(readActiveModels: readActiveModels)
        XCTAssertEqual(httpClientSpy.url, url)
    }
    
    func test_read_should_call_httpClient_with_correct_data() {
        let (sut, httpClientSpy) = makeSut()
        let readActiveModels = makeReadActiveModels()
        //let data = try? JSONEncoder().encode(readActiveModels)
        let data = toData(readActiveModels)
        sut.read(readActiveModels: readActiveModels)
        XCTAssertEqual(httpClientSpy.data, data)
    }
}

//Helper TestsClass
extension RemoteReadActiveTests {
    
    func toData(_ readActiveModels: [ReadActiveModel]) -> Data? {
        return try? JSONEncoder().encode(readActiveModels)
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
    
    class HttpClientSpy: HttpClientGet {
        var url: URL?
        var data: Data?
        
        func get(to url: URL, with data: Data?) {
            self.url = url
            self.data = data
        }
    }
}
