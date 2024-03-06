//
//  UtilFunctions.swift
//  GitHubUsers
//
//  Created by Sparsh Chadha on 02/03/24.
//

import Foundation

class UtilFunctions {
    public static let shared = UtilFunctions()
    
    func isAuthDeepLink(_ url: URL) -> Bool {
        if url.scheme == "githubstats" {
            if url.host == "auth" && url.queryParameters?["code"]?.count ?? 0 > 0 {
                return true
            } else {
                return false
            }
        }
        
        return false
    }
}


extension URL {
    var queryParameters: [String: String]? {
        guard let components = URLComponents(url: self, resolvingAgainstBaseURL: true),
              let queryItems = components.queryItems else {
            return nil
        }
        var parameters = [String: String]()
        queryItems.forEach { parameters[$0.name] = $0.value }
        return parameters
    }
}
