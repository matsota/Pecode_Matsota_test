//
//  NetworkService.swift
//  Pecode_Matsota_test
//
//  Created by Andrew Matsota on 27.11.2020.
//

import Foundation
import Alamofire

protocol Networking {
    
    func getRequest(for path: String, with params: [String: Any],
                    result: @escaping(Data?, Error?) -> Void)
    
}

class NetworkService {
    
    private let localErrors = Errors.self
    
}












//MARK: By Protocol
extension NetworkService: Networking {
    
    func getRequest(for path: String, with params: [String : Any],
                    result: @escaping (Data?, Error?) -> Void) {
        guard let url = url(from: path, params) else {
            result(nil, localErrors.invalidURL)
            return
        }

        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil, interceptor: nil).responseData { (response) in
            switch response.result {
            case .success(let data):
                result(data, nil)
                
            case .failure(let error):
                result(nil, error)
            }
        }
    }
    
}








//MARK: - Private Methods
private extension NetworkService {
    
    func url(from path: String, _ parameters: [String: Any]) -> URL? {
        var components = URLComponents()
        
        components.scheme = API.scheme
        components.host = API.host
        components.path = path
        
        var queryItems = [URLQueryItem]()
        for (key, value) in parameters {
            queryItems.append(URLQueryItem(name: key, value: "\(value)"))
        }
        queryItems.append(URLQueryItem(name: "apiKey", value: "53a2ee9437bb4d23b71b314e35df50b1"))
        components.queryItems = queryItems
        
        return components.url
    }
    
}

/// - `Update` for ability to insert data in HTTPBody
struct HTTPBody: ParameterEncoding {
    
    public func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
        var urlRequest = try urlRequest.asURLRequest()
        urlRequest.httpBody = data
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        return urlRequest
    }
    
    init(from data: Data) {
        self.data = data
    }
    
    private let data: Data
}
