//
//  YourProfileVC.swift
//  GitHubUsers
//
//  Created by Sparsh Chadha on 02/03/24.
//

import UIKit
import Lottie

class UserAuthVC: UIViewController, ResponseDelegate {
    
    private let loginButton = GHFButton(backgroundColor: .systemBlue, buttonTitle: "Login With GitHub ")
    private let loginLabel = UILabel()
    private let avatarImageView = GHAvatarImageView()
    private var animationView: LottieAnimationView?
    let logoIV = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        AuthViewModel.shared.responseDelegate = self
        
        configureUI()
    }
    
    private func configureUI() {
        if let accessToken = getAccessToken() {
            AuthViewModel.shared.getUserDetailsFrom(accessToken: accessToken)
            showLoader()
        } else {
            showLoginUI()
        }
    }
    
    private func getAccessToken() -> String? {
        if let data = KeychainHelper.getData(forService: Bundle.main.bundleIdentifier ?? Constants.FallbackKeychainService, account: Constants.GitHubAccessTokenAccount),
           let accessToken = String(data: data, encoding: .utf8) {
            return accessToken
        }
        
        return nil
    }
    
    @objc func startLoginWithGithub() {
        let githubOAuthAuthorizeUrl = "\(Constants.GitHubOAuthBaseUrl)\(Constants.GitHubOAuthApiRoute)?client_id=\(Constants.GitHubOAuthClientId)"
        if let url = URL(string: githubOAuthAuthorizeUrl) {
            UIApplication.shared.open(url)
            DispatchQueue.main.async {
                self.showLoader()
            }
        }
    }
    
    private func showLoader() {
        animationView = .init(name: "loader")
        
        view.addSubview(animationView!)
        animationView?.configureAnimationView()
        
        NSLayoutConstraint.activate([
            animationView!.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            animationView!.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            animationView!.widthAnchor.constraint(equalToConstant: 60),
            animationView!.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        animationView?.play()
    }
    
    private func configureUIFor(user: GitHubAuthResponse?) {
        animationView!.removeFromSuperview()
        loginLabel.removeFromSuperview()
        loginButton.removeFromSuperview()
        
        guard let user = user else {
            print("Unable to get user")
            return
        }
        
        configureAvatar(forUrl: user.userDetails?.avatarUrl)
    }
    
    private func configureAvatar(forUrl url: String?) {
        guard let url = url else {
            return
        }
        view.addSubview(avatarImageView)

        NSLayoutConstraint.activate([
            avatarImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            avatarImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        let avatarUrl = URL(string: url)
        if let avatarUrl = avatarUrl {
            loadImage(from: avatarUrl)
        }
    }
    
    private func loadImage(from url: URL?) {
        guard let url = url else { return }
        URLSession.shared.dataTask(with: url) { [weak self] (data, _, error) in
            if let error = error {
                print("Error loading image: \(error.localizedDescription)")
                return
            }
            guard let data = data, let image = UIImage(data: data) else { return }
            DispatchQueue.main.async {
                self?.avatarImageView.image = image
            }
        }.resume()
    }
    
    private func configureUIFor(error: Error) {
        animationView!.removeFromSuperview()
        let errorImage = UIImage(named: "no-result-found")
        let errorIV = UIImageView()
        errorIV.image = errorImage
        errorIV.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(errorIV)
        
        let errorText = error.localizedDescription
        let errorLabel = UILabel()
        view.addSubview(errorLabel)
        
        errorLabel.text = errorText
        errorLabel.numberOfLines = 0
        errorLabel.isUserInteractionEnabled = true
        errorLabel.font = UIFont.systemFont(ofSize: 18)
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.textAlignment = .left
        
        NSLayoutConstraint.activate([
            errorIV.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            errorIV.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            errorIV.widthAnchor.constraint(equalToConstant: 100),
            errorIV.heightAnchor.constraint(equalToConstant: 100),
            
            errorLabel.topAnchor.constraint(equalTo: errorIV.bottomAnchor, constant: 20),
            errorLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func showLoginUI() {
        loginLabel.text = "Login with GitHub to view your profile every time you open the app."
        loginLabel.translatesAutoresizingMaskIntoConstraints = false
        loginLabel.numberOfLines = 0
        loginLabel.textAlignment = .center
        view.addSubview(loginLabel)
        
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loginButton)
        
        logoIV.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(logoIV)
        logoIV.image = UIImage(named: Constants.GitHubLogoName)
        
        NSLayoutConstraint.activate([
            logoIV.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            logoIV.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoIV.heightAnchor.constraint(equalToConstant: 175),
            logoIV.widthAnchor.constraint(equalToConstant: 225),
            
            loginLabel.topAnchor.constraint(equalTo: logoIV.bottomAnchor, constant: 50),
            loginLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            loginLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            
            loginButton.topAnchor.constraint(equalTo: loginLabel.bottomAnchor, constant: 40),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            loginButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        loginButton.addTarget(self, action: #selector(startLoginWithGithub), for: .touchUpInside)
    }
    
    func didFetchData<T>(_ response: T) {
        DispatchQueue.main.async {
            self.configureUIFor(user: response as? GitHubAuthResponse)
        }
    }
    
    func didFailFetchingData(_ error: Error) {
        DispatchQueue.main.async {
            self.configureUIFor(error: error)
        }
    }
}
