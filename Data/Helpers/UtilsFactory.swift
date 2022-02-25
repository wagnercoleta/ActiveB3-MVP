//
//  UtilsFactory.swift
//  Data
//
//  Created by Wagner Coleta on 24/02/22.
//

import Foundation
import Domain

func getURLQuery(urlBase: URL, readActiveModels: [ReadActiveModel]) -> URL? {
    var lstActive: String = ""
    
    readActiveModels.forEach { readActiveModel in
        lstActive += "\(readActiveModel.code)|"
    }
    
    let encodedActive = "\(lstActive)"
    
    let encodedUrlFinal = encodedActive.addingPercentEncoding(withAllowedCharacters: .alphanumerics)
    
    let urlFinal = urlBase.absoluteString + encodedUrlFinal!
    
    guard let urlQuery = URL(string: urlFinal) else {
        return nil
    }
    
    return urlQuery
}
