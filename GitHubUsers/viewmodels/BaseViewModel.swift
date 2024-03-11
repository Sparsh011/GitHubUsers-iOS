//
//  BaseViewModel.swift
//  GHFollowersSA
//
//  Created by Sparsh on 21/02/24.
//
import Foundation

class BaseViewModel {
    static let shared = BaseViewModel()
    weak var responseDelegate: ResponseDelegate?
    
    func getProfileFor(user userName: String, apiRoute: String) {
        GHNetworkHelper.shared.fetchData(
            method: "GET",
            baseUrl: Constants.GithubAPIBaseURL,
            apiRoute: apiRoute
        ) { [weak self] (data, response, error) in
            guard let self = self else { return }
            
            if let error = error {
                self.responseDelegate?.didFailFetchingData(error)
                return
            }
            
            guard let data = data else {
                let noDataError = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "No data received"])
                self.responseDelegate?.didFailFetchingData(noDataError)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                let invalidResponseError = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid Response!"])
                self.responseDelegate?.didFailFetchingData(invalidResponseError)
                return
            }
            
            let statusCode = httpResponse.statusCode
            
            if statusCode != 200 {
                var statusCodeError: NSError
                if statusCode == 404 {
                    statusCodeError = NSError(domain: "", code: statusCode, userInfo: [NSLocalizedDescriptionKey: "Error \(statusCode), Profile Not Found!"])
                } else {
                    statusCodeError = NSError(domain: "", code: statusCode, userInfo: [NSLocalizedDescriptionKey: "Error \(statusCode)"])
                }
                
                self.responseDelegate?.didFailFetchingData(statusCodeError)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let user = try decoder.decode(GitHubUser.self, from: data)
                self.responseDelegate?.didFetchData(user)
            } catch {
                self.responseDelegate?.didFailFetchingData(error)
            }
        }
    }
    
    func getFollowersFor(followersApiRoute apiRoute: String) {
        GHNetworkHelper.shared.fetchData(
            method: "GET",
            baseUrl: Constants.GithubAPIBaseURL,
            apiRoute: apiRoute
        ) { [weak self] (data, response, error) in
            guard let self = self else { return }
            
            if let error = error {
                self.responseDelegate?.didFailFetchingData(error)
                return
            }
            
            guard let data = data else {
                let noDataError = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "No data received"])
                self.responseDelegate?.didFailFetchingData(noDataError)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let users = try decoder.decode([GitHubFollower].self, from: data)
                self.responseDelegate?.didFetchData(users)
            } catch {
                self.responseDelegate?.didFailFetchingData(error)
            }
        }
    }
    
    func loginUser(from code: String) {
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
                        responseDelegate?.didFetchData(userAuthResponse)
                    } catch {
                        print("Error in decoding - \(error)")
                    }
                }
            )
        }
    }
}
