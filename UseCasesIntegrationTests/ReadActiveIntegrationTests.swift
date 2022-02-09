//
//  UseCasesIntegrationTests.swift
//  UseCasesIntegrationTests
//
//  Created by Wagner Coleta on 06/02/22.
//

import XCTest
import Data
import Infra
import Domain

class ReadActiveIntegrationTests: XCTestCase {

    func test_read_active() {
        
        let ativoPETR4 = "PETR4"
        let encodedAtivos = ativoPETR4
        let encodedUrlFinal = encodedAtivos.addingPercentEncoding(withAllowedCharacters: .alphanumerics)
        let basePath = "https://bvmf.bmfbovespa.com.br/cotacoes2000/FormConsultaCotacoes.asp?strListaCodigos="
        let stringUrl = basePath + encodedUrlFinal!
        let url = URL(string: stringUrl)!
        
        let alamofireAdapter = AlamofireAdapter()
        let sut = RemoteReadActive(url: url, httpClient: alamofireAdapter)
        let readActiveModels = [ReadActiveModel(code: ativoPETR4)]
        
        let exp = expectation(description: "waiting")
        sut.read(readActiveModels: readActiveModels) { result in
            switch result {
            case .failure: XCTFail("Expect success got \(result) instead")
            case .success(let activeModels):
                XCTAssertNotNil(activeModels)
                XCTAssertTrue(activeModels!.count > 0)
                XCTAssertEqual(activeModels?[0].code, ativoPETR4)
                print(activeModels!)
            }
            exp.fulfill()
        }
        wait(for: [exp], timeout: 25)
    }

}
