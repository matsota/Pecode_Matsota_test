//
//  NetworkManager.swift
//  Pecode_Matsota_test
//
//  Created by Andrew Matsota on 27.11.2020.
//

import Foundation

//MARK: - Protocol
protocol NetworkProtocol {
    
    func readAvailableArticles(_ parameters: ArticleRequestParameters,
                               success: @escaping([ArticleList.Article], Int) -> Void,
                               failure: @escaping(String) -> Void)

}









//MARK: - Class
class NetworkManager {
    
    /// - Parameters
    private let networking: Networking
    private let localErrors = Errors.self
    
    init(networking: Networking) {
        self.networking = networking
    }
    
}











//MARK: - Methods
extension NetworkManager: NetworkProtocol {
    
    func readAvailableArticles(_ parameters: ArticleRequestParameters,
                               success: @escaping([ArticleList.Article], Int) -> Void,
                               failure: @escaping(String) -> Void) {
        networking.getRequest(for: parameters.api.rawValue, with: parameters.dictionary) { (data, error) in
            switch error {
            case .some(let error):
                failure(error.localizedDescription)
                
            case .none:
                self.decode(received: data, in: "readAvailableTopHeadlines") { (result: ArticleList) in
                    success(result.articles, result.totalResults)
                } failure: { (localizedDescription) in
                    failure(localizedDescription)
                }
            }
        }
    }

}









private extension NetworkManager {
    
    /// - `decode` received data in defined method with further transition of it
    func decode<T>(received data: Data?, in method: String,
                   success: @escaping(T) -> Void,
                   failure: @escaping(String) -> Void) where T: Decodable {
        do {
            guard let data = data else {
                failure(localErrors.unknown.localizedDescription)
                return
            }
            
            let response = try JSONDecoder().decode(T.self, from: data)
            success(response)
        }catch{
            debugPrint("ERROR: NetworkManager: decode in \(method)", error.localizedDescription)
            failure(error.localizedDescription)
        }
    }
    
}
