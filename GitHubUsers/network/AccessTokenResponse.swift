//
//  AccessTokenResponse.swift
//  GitHubUsers
//
//  Created by Sparsh Chadha on 06/03/24.
//

import Foundation

//struct AccessTokenResponse: Codable {
//    let accessToken: String
//    let tokenType: String
//    let scope: String
//}

struct GitHubAuthResponse: Codable {
    let login: String
    let id: Int
    let nodeId: String
    let avatarUrl: String
    let url: String
    let htmlUrl: String
    let followersUrl: String
    let followingUrl: String
    let gistsUrl: String
    let starredUrl: String
    let subscriptionsUrl: String
    let organizationsUrl: String
    let reposUrl: String
    let eventsUrl: String
    let receivedEventsUrl: String
    let type: String
    let siteAdmin: Bool
    let name: String
    let company: String?
    let blog: String
    let location: String?
    let email: String?
    let hireable: Bool?
    let bio: String?
    let twitterUsername: String?
    let publicRepos: Int
    let publicGists: Int
    let followers: Int
    let following: Int
    let createdAt: String
    let updatedAt: String
}

