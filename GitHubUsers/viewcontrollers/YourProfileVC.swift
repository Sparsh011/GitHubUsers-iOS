//
//  YourProfileVC.swift
//  GitHubUsers
//
//  Created by Sparsh Chadha on 02/03/24.
//

import UIKit

class YourProfileVC: UIViewController {
    let loginButton = GHFButton(backgroundColor: .systemBlue, buttonTitle: "Login With GitHub ")
    let loginLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        configureLoginButtonAndLabel()
    }
    
    private func configureLoginButtonAndLabel() {
        loginLabel.text = "Login to view your GitHub profile stats"
        loginLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loginLabel)
      
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loginButton)

        NSLayoutConstraint.activate([
            loginLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50),
            
            loginButton.topAnchor.constraint(equalTo: loginLabel.bottomAnchor, constant: 40),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            loginButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        loginButton.addTarget(self, action: #selector(startLoginWithGithub), for: .touchUpInside)
    }
    
    @objc func startLoginWithGithub() {
        if let url = URL(string: "https://github.com/login/oauth/authorize?client_id=1c91fdb72c57a551a942") {
            UIApplication.shared.open(url)
        }
    }
}
