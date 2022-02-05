//
//  HttpClientGet.swift
//  Data
//
//  Created by Wagner Coleta on 05/02/22.
//

import Foundation

//SOLID - "I -> Interface Segregation Principle (ISP)
public protocol HttpClientGet {
    func get(to url: URL, with data: Data?)
}
