//
//  RemoteReadActive.swift
//  Data
//
//  Created by Wagner Coleta on 05/02/22.
//

import Foundation
import Domain

public final class RemoteReadActive: ReadActive {
    private let url: URL
    private let httpClient: HttpClientGet
    
    public init(url: URL, httpClient: HttpClientGet){
        self.url = url
        self.httpClient = httpClient
    }
    
    public func read(readActiveModels: [ReadActiveModel], completion: @escaping (Result<[ActiveModel]?, DomainError>) -> Void) {
        if let urlQuery = getURLQuery(urlBase: self.url, readActiveModels: readActiveModels) {
            httpClient.get(to: urlQuery) { [weak self] result in
                guard self != nil else { return }
                switch result {
                    case .success(let data):
                        if let activeModels = try? JSONDecoder().decode([ActiveModel].self, from: data!) {
                            completion(.success(activeModels))
                        } else {
                            if let activeModels = self?.extractXMLtoResult(data: data!) {
                                completion(.success(activeModels))
                            } else {
                                completion(.failure(.unexpected))
                            }
                        }
                    case .failure: completion(.failure(.unexpected))
                }
            }
        } else {
            completion(.failure(.unexpected))
        }
    }
    
    public func extractXMLtoResult(data: Data) -> [ActiveModel]? {
        
        if let file = String(data: data, encoding: .utf8) {
            
            var xml = file
            
            var linha = xml.sliceByString(from: "<Papel ", to: "/>")
            
            var existeLinha: Bool = linha != nil && linha != ""
            
            if (existeLinha){
                
                var activeModels: [ActiveModel] = []
                
                while existeLinha {
                    let codigo = linha!.sliceByString(from: "Codigo=\u{0022}", to: "\u{0022}")
                    let nome = linha!.sliceByString(from: "Nome=\u{0022}", to: "\u{0022}")
                    var preco = linha!.sliceByString(from: "Ultimo=\u{0022}", to: "\u{0022}")
                    preco = preco?.replacingOccurrences(of: ",", with: ".")
                    
                    if let vr_preco = Double(preco!) {
                        
                        let active = ActiveModel(
                            id: "",
                            code: codigo!,
                            name: nome!,
                            price: vr_preco,
                            priceAlert: 0.0,
                            variation: 0.0,
                            operationLarger: false)
                        
                        activeModels.append(active)
                    }
                    
                    xml = xml.replacingOccurrences(of: "<Papel " + linha!, with: "")
                    
                    linha = xml.sliceByString(from: "<Papel ", to: "/>")
                    
                    existeLinha = linha != nil && linha != ""
                }
                return activeModels
            }
            return nil
        }
        return nil
    }
}

extension String {

    func sliceByString(from:String, to:String) -> String? {
        //From - startIndex
        var range = self.range(of: from)
        if (range == nil){
            return nil
        }
        
        let subString = String(self[range!.upperBound...])

        //To - endIndex
        range = subString.range(of: to)
        return String(subString[..<range!.lowerBound])
    }
}

