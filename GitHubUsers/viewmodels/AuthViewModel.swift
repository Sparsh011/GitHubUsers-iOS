//
//  AuthViewModel.swift
//  GitHubUsers
//
//  Created by Sparsh Chadha on 13/03/24.
//

import Foundation

class AuthViewModel {
    static let shared = AuthViewModel()
    weak var responseDelegate: ResponseDelegate?
    
    func loginUserFrom(code: String) {
        if !code.isEmpty {
            GHNetworkHelper.shared.fetchData(
                method: "GET",
                requestParams: [
                    "code": code
                ],
                baseUrl: Constants.SharedServerBaseURL,
                apiRoute: Constants.SharedServerLoginApiRoute,
                completion: { [weak self] (data, response, error) in
                    guard let self = self else { return }
                    
                    guard let data = data else {
                        let noDataError = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "No data received"])
                        responseDelegate?.didFailFetchingData(noDataError)
                        return
                    }
                    
                    do {
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .convertFromSnakeCase
                        let userAuthResponse = try decoder.decode(GitHubAuthResponse.self, from: data)
                        if userAuthResponse.isTokenValid {
                            let data = userAuthResponse.accessToken?.data(using: .utf8)
                            if KeychainHelper.saveData(data: data!, forService: Bundle.main.bundleIdentifier ?? Constants.FallbackKeychainService, account: Constants.GitHubAccessTokenAccount) {
                                responseDelegate?.didFetchData(userAuthResponse)
                            } else {
                                let errorSavingAccessToken = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Unable To Login"])
                                responseDelegate?.didFailFetchingData(errorSavingAccessToken)
                            }
                        } else {
                            let invalidAccessTokenError = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Access Token Invalid! Please Try Again"])
                            responseDelegate?.didFailFetchingData(invalidAccessTokenError)
                        }
                        
                    } catch {
                        print("Error in decoding - \(error)")
                    }
                }
            )
        }
    }
    
    func getUserDetailsFrom(accessToken: String) {
        GHNetworkHelper.shared.fetchData(
            method: "GET",
            requestParams: [
                "access_token": accessToken
            ],
            baseUrl: Constants.SharedServerBaseURL,
            apiRoute: Constants.SharedServerIsUserLoggedInApiRoute
        ) { [weak self] (data, response, error) in
            guard let self = self else { return }
            
            guard let data = data else {
                let noDataError = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "No data received"])
                responseDelegate?.didFailFetchingData(noDataError)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let userAuthResponse = try decoder.decode(GitHubAuthResponse.self, from: data)
                responseDelegate?.didFetchData(userAuthResponse)
            } catch {
                print("Error in decoding - \(error)")
                responseDelegate?.didFailFetchingData(error)
            }
        }
    }
}
