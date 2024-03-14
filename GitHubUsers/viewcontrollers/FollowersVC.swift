//
//  FollowersVC.swift
//  GHFollowersSA
//
//  Created by Sparsh on 24/02/24.
//

import UIKit

class FollowersVC: UIViewController, ResponseDelegate {
    func didFetchData<T>(_ response: T) {
        if let users = response as? [GitHubFollower] {
            print("Received array of GitHubUser: \(users)")
            DispatchQueue.main.async {
                self.configureFollowersVC()
            }
        }
    }
    
    func didFailFetchingData(_ error: Error) {
        print("Error \(error)")
    }
    
    private var username: String = ""
    private var followersApiRoute: String = ""
    private var followingApiRoute: String = ""
    
    convenience init(username: String, followersApiRoute: String, followingApiRoute: String) {
        self.init()
        self.username = username
        self.followersApiRoute = followersApiRoute
        self.followingApiRoute = followingApiRoute
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        BaseViewModel.shared.responseDelegate = self
        
        BaseViewModel.shared.getFollowersFor(followersApiRoute: followersApiRoute)
        
        let dummyUser = GitHubUser(
            login: "sparsh011",
            id: 32483302,
            nodeId: "MDQ6VXNlcjMyNDgzMzAy",
            avatarUrl: "https://avatars.githubusercontent.com/u/32483302?v=4",
            gravatarId: "",
            url: "https://api.github.com/users/sparsh011",
            htmlUrl: "https://github.com/sparsh011",
            followersUrl: "https://api.github.com/users/sparsh011/followers",
            followingUrl: "https://api.github.com/users/sparsh011/following{/other_user}",
            gistsUrl: "https://api.github.com/users/sparsh011/gists{/gist_id}",
            starredUrl: "https://api.github.com/users/sparsh011/starred{/owner}{/repo}",
            subscriptionsUrl: "https://api.github.com/users/sparsh011/subscriptions",
            organizationsUrl: "https://api.github.com/users/sparsh011/orgs",
            reposUrl: "https://api.github.com/users/sparsh011/repos",
            eventsUrl: "https://api.github.com/users/sparsh011/events{/privacy}",
            receivedEventsUrl: "https://api.github.com/users/sparsh011/received_events",
            type: "User",
            siteAdmin: false,
            name: "Sparsh Chadha",
            company: "GitHub",
            blog: "https://sparsh011.github.io/",
            location: "India",
            email: "sparsh@example.com",
            hireable: true,
            bio: "Software Developer",
            twitterUsername: "sparsh011",
            publicRepos: 10,
            publicGists: 2,
            followers: 5,
            following: 7,
            createdAt: "2017-10-15T06:56:48Z",
            updatedAt: "2022-02-08T08:16:12Z"
        )

        let profile = GHUserProfile(profile: dummyUser)
        view.addSubview(profile)
        profile.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            profile.topAnchor.constraint(equalTo: view.topAnchor),
            profile.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            profile.heightAnchor.constraint(equalToConstant: 500),
            profile.widthAnchor.constraint(equalToConstant: 300)
        ])
    }
    
    private func configureFollowersVC() {
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }
}
