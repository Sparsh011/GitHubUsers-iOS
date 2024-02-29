//
//  ViewController.swift
//  GHFollowersSA
//
//  Created by Sparsh on 21/02/24.
//

import UIKit
import Lottie

class UserProfileVC: UIViewController, ResponseDelegate, UIScrollViewDelegate {
    func didFetchData<T>(_ response: T) {
        if let user = response as? GitHubUser {
            DispatchQueue.main.async { [weak self] in
                self?.configureUIFor(user: user)
            }
        }
    }
    
    func didFailFetchingData(_ error: Error) {
        DispatchQueue.main.async { [weak self] in
            print("error - \(error)")
            self?.configureUIFor(error: error)
        }
    }
    
    lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.delegate = self
        return scroll
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isUserInteractionEnabled = true
        return stackView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemBlue
        label.textAlignment = .center
        label.numberOfLines = 0
        label.isUserInteractionEnabled = true
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let bioHeadingLabel = GHUserFieldHeader(text: "Bio")
    private let bioLabel = GHUserFieldValue()
    
    private let emailHeadingLabel = GHUserFieldHeader(text: "Email")
    private let emailLabel = GHUserFieldValue()
    
    private let publicReposHeadingLabel = GHUserFieldHeader(text: "Public Repositories")
    private let publicReposLabel = GHUserFieldValue()
    
    private let followersHeadingLabel = GHUserFieldHeader(text: "Followers")
    private let followersLabel = GHUserFieldValue()
    
    
    private let followingHeadingLabel = GHUserFieldHeader(text: "Following")
    private let followingLabel = GHUserFieldValue()
    
    private var profileUrl: String = "https://github.com"
    
    private var username: String = ""
    private var apiRoute: String = ""
    
    private var animationView: LottieAnimationView?
    
    convenience init(username: String, apiRoute: String) {
        self.init()
        self.username = username
        self.apiRoute = apiRoute
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        BaseViewModel.shared.responseDelegate = self
        
        configureLottieAnimation()
        
        BaseViewModel.shared.getProfileFor(user: username, apiRoute: apiRoute)
    }
    
    private func configureScrollViewAndStackView() {
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
        
        scrollView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
    
    private func configureLottieAnimation() {
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
    
    private func configureUIFor(user: GitHubUser) {
        animationView!.removeFromSuperview()
        configureScrollViewAndStackView()
        configureAvatar(forUrl: user.avatarUrl)
        configureNameLabel(forName: user.name, profileUrl: user.htmlUrl)
        configureLabels(
            forBio: user.bio,
            email: user.email,
            followers: String(user.followers),
            following: String(user.following),
            publicRepos: String(user.publicRepos)
        )
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
    
    
    private func configureAvatar(forUrl url: String) {
        stackView.addArrangedSubview(avatarImageView)
        
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
    
    private func configureNameLabel(forName name: String?, profileUrl: String) {
        self.profileUrl = profileUrl
        guard let notNullName = name else {
            nameLabel.text = "Unable To Get Name \n"
            return
        }
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(openGitHubProfile))
        
        stackView.addArrangedSubview(nameLabel)
        
        nameLabel.addGestureRecognizer(tapGesture)
        nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        nameLabel.text = notNullName + "\n"
    }
    
    private func configureLabels(forBio bio: String?, email: String?, followers: String, following: String, publicRepos: String) {
        stackView.addArrangedSubview(bioHeadingLabel)
        stackView.addArrangedSubview(bioLabel)
        
        stackView.addArrangedSubview(emailHeadingLabel)
        stackView.addArrangedSubview(emailLabel)
        
        stackView.addArrangedSubview(publicReposHeadingLabel)
        stackView.addArrangedSubview(publicReposLabel)
        
        stackView.addArrangedSubview(followersHeadingLabel)
        stackView.addArrangedSubview(followersLabel)
        
        stackView.addArrangedSubview(followingHeadingLabel)
        stackView.addArrangedSubview(followingLabel)
        
        bioLabel.text = "    \(bio ?? "No Bio")"
        emailLabel.text = "    \(email ?? "No Email")"
        publicReposLabel.text = "    \(publicRepos)"
        followersLabel.text = "    \(followers)"
        followingLabel.text = "    \(following)"
    }
    
    @objc private func openGitHubProfile() {
        if let url = URL(string: profileUrl) {
            UIApplication.shared.open(url)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }
}
