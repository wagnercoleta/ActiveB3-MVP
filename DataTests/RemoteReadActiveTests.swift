//
//  DataTests.swift
//  DataTests
//
//  Created by Wagner Coleta on 05/02/22.
//

import XCTest

class RemoteReadActive {
    private let url: URL
    private let httpClient: HttpClientGet
    
    init(url: URL, httpClient: HttpClientGet){
        self.url = url
        self.httpClient = httpClient
    }
    
    func read() {
        httpClient.get(url: url)
    }
}

//SOLID - "I -> Interface Segregation Principle (ISP)
protocol HttpClientGet {
    func get(url: URL)
}

class RemoteReadActiveTests: XCTestCase {

    func test_() {
        let url = URL(string: "http://any-url.com")!
        let httpClientSpy = HttpClientSpy()
        let sut = RemoteReadActive(url: url, httpClient: httpClientSpy)
        sut.read()
        XCTAssertEqual(httpClientSpy.url, url)
    }

    class HttpClientSpy: HttpClientGet {
        var url: URL?
        
        func get(url: URL) {
            self.url = url
        }
    }
}
