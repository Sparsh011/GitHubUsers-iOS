//
//  Constants.swift
//  GHFollowersSA
//
//  Created by Sparsh on 08/02/24.
//

import Foundation

class Constants {
    public static let GitHubLogoName = "gh-logo"
    public static let SharedServerBaseURL = "https://shared-server-sparsh-fastapi.onrender.com"
    public static let SharedServerLoginApiRoute = "/login"
    public static let SharedServerIsUserLoggedInApiRoute = "/check-login-status"
    public static let GithubAPIBaseURL = "https://api.github.com"
    public static let GitHubOAuthBaseUrl = "https://github.com/login/oauth"
    public static let GitHubOAuthApiRoute = "/authorize"
    public static let GitHubOAuthClientId = "1c91fdb72c57a551a942"
    public static let GitHubAccessTokenAccount = "github_access_token_account"
    public static let FallbackKeychainService = "github_app_keychain_service"
}
