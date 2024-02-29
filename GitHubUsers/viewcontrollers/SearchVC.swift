//
//  ViewController.swift
//  GHFollowersSA
//
//  Created by Sparsh on 07/02/24.
//

import UIKit

class SearchVC: UIViewController {
    let logoIV = UIImageView()
    let userNameTextField = GHFTextField(placeholder: "Username")
    let getFollowersButton = GHFButton(backgroundColor: .systemBlue, buttonTitle: "Followers")
    let getUserProfileButton = GHFButton(backgroundColor: .systemBlue, buttonTitle: "Profile")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground
        
        configureLogoIV()
        configureUserNameTextField()
        configureGetFollowersButton()
        configureGetUserProfileButton()
        configureKeyboardHiding()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = true
    }
    
    private func configureLogoIV() {
        view.addSubview(logoIV)
        logoIV.translatesAutoresizingMaskIntoConstraints = false
        
        logoIV.image = UIImage(named: Constants.GitHubLogoName)
        
        NSLayoutConstraint.activate([
            logoIV.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            logoIV.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoIV.heightAnchor.constraint(equalToConstant: 200),
            logoIV.widthAnchor.constraint(equalToConstant: 250)
        ])
    }
    
    private func configureUserNameTextField() {
        view.addSubview(userNameTextField)
        
        NSLayoutConstraint.activate([
            userNameTextField.topAnchor.constraint(equalTo: logoIV.bottomAnchor, constant: 60),
            userNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            userNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            userNameTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func configureGetFollowersButton() {
        view.addSubview(getFollowersButton)
        
        NSLayoutConstraint.activate([
            getFollowersButton.topAnchor.constraint(equalTo: userNameTextField.bottomAnchor, constant: 40),
            getFollowersButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            getFollowersButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            getFollowersButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        getFollowersButton.addTarget(self, action: #selector(getFollowersOfUser), for: .touchUpInside)
    }
    
    private func configureGetUserProfileButton() {
        view.addSubview(getUserProfileButton)
        
        NSLayoutConstraint.activate([
            getUserProfileButton.topAnchor.constraint(equalTo: getFollowersButton.bottomAnchor, constant: 20),
            getUserProfileButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            getUserProfileButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            getUserProfileButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        getUserProfileButton.addTarget(self, action: #selector(getUserProfile), for: .touchUpInside)
    }
    
    
    private func configureKeyboardHiding() {
        let closeKeyboardTap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        
        view.addGestureRecognizer(closeKeyboardTap)
    }
    
    
    @objc func getFollowersOfUser() {
        let username = userNameTextField.text ?? ""
        if username.count > 0 {
            let followersApiRoute = "/users/\(username)/followers"
            let followingApiRoute = "/users/\(username)/following"
            
            let followersVC = FollowersVC(username: username, followersApiRoute: followersApiRoute, followingApiRoute: followingApiRoute)
            followersVC.hidesBottomBarWhenPushed = true
            
            self.navigationController?.pushViewController(followersVC, animated: true)
        } else {
            self.showToast(message: "Enter a username", font: UIFont.systemFont(ofSize: 16))
        }
    }
    
    @objc func getUserProfile() {
        let username = userNameTextField.text ?? ""
        if username.count > 0 {
            let apiRoute = "/users/\(username)"
            
            let userProfileVC = UserProfileVC(username: username, apiRoute: apiRoute)
            userProfileVC.hidesBottomBarWhenPushed = true
            
            self.navigationController?.pushViewController(userProfileVC, animated: true)
        } else {
            self.showToast(message: "Enter a username", font: UIFont.systemFont(ofSize: 16))
        }
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
