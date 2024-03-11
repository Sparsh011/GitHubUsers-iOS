//
//  YourProfileVC.swift
//  GitHubUsers
//
//  Created by Sparsh Chadha on 02/03/24.
//

import UIKit
import Lottie

class UserAuthVC: UIViewController, ResponseDelegate {
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
    
    let loginButton = GHFButton(backgroundColor: .systemBlue, buttonTitle: "Login With GitHub ")
    let loginLabel = UILabel()
    private let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    private var animationView: LottieAnimationView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        BaseViewModel.shared.responseDelegate = self
        
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
        let githubOAuthAuthorizeUrl = "\(Constants.githubOAuthBaseUrl)\(Constants.githubOAuthApiRoute)?client_id=\(Constants.githubOAuthClientId)"
        if let url = URL(string: githubOAuthAuthorizeUrl) {
            UIApplication.shared.open(url)
            DispatchQueue.main.async {
                self.showLoader()
            }
        }
    }
    
    private func showLoader() {
        animationView = .init(name: "loader")
        
        animationView!.translatesAutoresizingMaskIntoConstraints = false
        animationView!.contentMode = .scaleAspectFit
        animationView!.loopMode = .loop
        animationView!.animationSpeed = 1
        
        view.addSubview(animationView!)
        
        NSLayoutConstraint.activate([
            animationView!.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            animationView!.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            animationView!.widthAnchor.constraint(equalToConstant: 60),
            animationView!.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        animationView!.play()
    }
    
    private func configureUIFor(user: GitHubAuthResponse?) {
        print("Here with \(user)")
        animationView!.removeFromSuperview()
        
        guard let user = user else {
            print("Unable to get user")
            return
        }
        
        configureAvatar(forUrl: user.avatarUrl)
    }
    
    private func configureAvatar(forUrl url: String) {
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
}
