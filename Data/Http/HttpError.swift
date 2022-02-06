//
//  HttpError.swift
//  Data
//
//  Created by Wagner Coleta on 05/02/22.
//

import Foundation

public enum HttpError: Error {
    case noConnectivity
    case badRequest
    case serverError
    case unauthorized
    case forbidden
}
