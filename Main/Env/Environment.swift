//
//  Environment.swift
//  Main
//
//  Created by Wagner Coleta on 26/02/22.
//

import Foundation

public final class Environment {
    public enum EnvironmentEnum: String {
        case apiBaseUrl = "API_BASE_URL"
    }
    
    public static func variable(_ key: EnvironmentEnum) -> String {
        return Bundle.main.infoDictionary![key.rawValue] as! String
    }
}
