//
//  AccessTokenResponse.swift
//  GitHubUsers
//
//  Created by Sparsh Chadha on 06/03/24.
//

import Foundation

struct AccessTokenResponse: Codable {
    let accessToken: String
    let tokenType: String
    let scope: String
}
