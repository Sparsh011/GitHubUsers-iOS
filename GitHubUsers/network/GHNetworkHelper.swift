//
//  GHNetworkHelper.swift
//  GHFollowersSA
//
//  Created by Sparsh on 21/02/24.
//

import Foundation

class GHNetworkHelper {
    typealias NetworkCompletion = (Data?, URLResponse?, Error?) -> Void
    static let shared = GHNetworkHelper()
    
    func fetchData(
        method: String,
        headers: [String: String]? = nil,
        bodyParams: [String: Any]? = nil,
        requestParams: [String: Any]? = nil,
        baseUrl: String,
        apiRoute: String,
        completion: @escaping NetworkCompletion
    ) {
        var urlComponents = URLComponents(string: baseUrl + apiRoute)
        
        if let requestParams = requestParams {
            var queryItems = [URLQueryItem]()
            for (key, value) in requestParams {
                if let valueString = value as? String {
                    queryItems.append(URLQueryItem(name: key, value: valueString))
                }
            }
            urlComponents?.queryItems = queryItems
        }
        
        guard let url = urlComponents?.url else {
            completion(nil, nil, NSError(domain: "Invalid URL", code: 0, userInfo: nil))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method
        
        if let headers = headers {
            for (key, value) in headers {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        if let bodyParams = bodyParams {
            let bodyData = try? JSONSerialization.data(withJSONObject: bodyParams)
            request.httpBody = bodyData
        }
        
        request.timeoutInterval = 90
          
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            completion(data, response, error)
        }
        task.resume()
    }
}
