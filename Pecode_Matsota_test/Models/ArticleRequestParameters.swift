//
//  ArticleRequestParameters.swift
//  Pecode_Matsota_test
//
//  Created by Andrew Matsota on 27.11.2020.
//

import Foundation

struct ArticleRequestParameters {
    
    let api: API.Method
    let page: Int
    let country: String?
    let search: String?
    
    init(_ api: API.Method, page: Int, _ country: CountriesIncluded) {
        self.api = api
        self.country = country.rawValue
        self.page = page
        self.search = nil
    }
    init(_ api: API.Method, page: Int, _ search: String?) {
        self.api = api
        self.country = nil
        self.page = page
        self.search = search
    }
    
    enum Keys: String {
        case page
        case country
        case search = "q"
    }
    
    var dictionary: [String: Any] {
        var dictionary: [String: Any] = [Keys.page.rawValue: page]
        
        if let country = country {
            dictionary[Keys.country.rawValue] = country
        }
        
        if let search = search {
            dictionary[Keys.search.rawValue] = search
        }
        return dictionary
    }
}

enum CountriesIncluded: String {
    case us
    case ua
}
