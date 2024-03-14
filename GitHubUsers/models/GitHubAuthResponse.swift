//
//  AccessTokenResponse.swift
//  GitHubUsers
//
//  Created by Sparsh Chadha on 06/03/24.
//

import Foundation

struct GitHubAuthResponse: Codable {
    let isTokenValid: Bool
    let accessToken: String?
    let userDetails: GitHubUser?
}
