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
        baseUrl: String,
        apiRoute: String,
        completion: @escaping NetworkCompletion
    ) {
        var request = URLRequest(url: URL(string: baseUrl + apiRoute)!)
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
          
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            completion(data, response, error)
        }
        task.resume()
    }
}
