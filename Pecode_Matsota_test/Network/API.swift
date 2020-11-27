//
//  API.swift
//  Pecode_Matsota_test
//
//  Created by Andrew Matsota on 27.11.2020.
//

import Foundation

//MARK: - URL
struct API {
    
    static let scheme = "http"
    
    static let host = "newsapi.org"

}









//MARK: - Methods
extension API {
    
    enum Method: String {
        
        case top_headlines = "/v2/top-headlines"
        
        case everything = "/v2/everything"
    }
    
}

