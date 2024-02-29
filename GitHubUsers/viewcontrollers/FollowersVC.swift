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
    }
    
    private func configureFollowersVC() {
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }
}
