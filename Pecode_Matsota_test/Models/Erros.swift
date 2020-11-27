//
//  Erros.swift
//  Pecode_Matsota_test
//
//  Created by Andrew Matsota on 27.11.2020.
//

import Foundation

enum Errors: Error {
    case unknown
    case invalidURL
    
    var localizedDescription: String {
        switch self {
        case .unknown:
            debugPrint(comment)
            return NSLocalizedString("Unknown error", comment: comment)
            
        case .invalidURL:
            debugPrint(comment)
            return NSLocalizedString("URL link invalid", comment: comment)
        }
    }
    
    private var comment: String {
        return "CUSTOM ERROR: Errors: \(self)"
    }
    
}
