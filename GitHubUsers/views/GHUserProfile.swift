//
//  GHUserProfile.swift
//  GitHubUsers
//
//  Created by Sparsh Chadha on 14/03/24.
//

import UIKit

class GHUserProfile: UIScrollView {
    private let avatarIV = GHAvatarImageView()
    private let verticalStackView: UIStackView = {
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
    
    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 0
        label.isUserInteractionEnabled = false
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let contentLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(cgColor: CGColor(
            srgbRed: 139/255,
            green: 50/255,
            blue: 170/255,
            alpha: 1.0
        ))
        label.textAlignment = .right
        label.numberOfLines = 0
        label.isUserInteractionEnabled = false
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let contentColor = UIColor(cgColor: CGColor(
        srgbRed: 139/255,
        green: 50/255,
        blue: 170/255,
        alpha: 1.0
    ))
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(profile: GitHubUser) {
        super.init(frame: .zero)
        configure(profile: profile)
    }
    
    private func configure(profile: GitHubUser) {
        addSubview(verticalStackView)
        addViewsToStackView(profile: profile)
    }
    
    private func addViewsToStackView(profile: GitHubUser) {
        handleAvatar(profile.avatarUrl)
        handleBio(profile.bio)

        
    }
    
    private func handleAvatar(_ avatarUrl: String) {
        verticalStackView.addArrangedSubview(avatarIV)
        loadAvatar(avatarUrl)
    }
    
    private func loadAvatar(_ avatarUrl: String) {
        guard let url = URL(string: avatarUrl) else {
            return
        }
        URLSession.shared.dataTask(with: url) { [weak self] (data, _, error) in
            if let error = error {
                print("Error loading image: \(error.localizedDescription)")
                return
            }
            guard let data = data, let image = UIImage(data: data) else { return }
            DispatchQueue.main.async {
                self?.avatarIV.image = image
            }
        }.resume()
    }
    
    private func handleBio(_ bio: String?) {
        handleUserName(userName: "Sparsh011")
    }

    private func handleUserName(userNameTitle: String = "Username", userName: String) {
        let category = createLabel(text: userNameTitle, alignment: .left, textColor: nil)
        
        let content = createLabel(text: userName, alignment: .right, textColor: contentColor)

        let horizontalStackView = getHorizontaStackView()

        horizontalStackView.addArrangedSubview(category)
        horizontalStackView.addArrangedSubview(content)

        verticalStackView.addArrangedSubview(horizontalStackView)
    }
    
    
    private func createLabel(text: String, alignment: NSTextAlignment, textColor: UIColor?) -> UILabel {
        let label = UILabel()
        label.textAlignment = alignment
        label.numberOfLines = 0
        label.isUserInteractionEnabled = false
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        if textColor != nil {
            label.textColor = textColor!
        }
        return label
    }
    
    private func getHorizontaStackView() -> UIStackView {
        let horizontalStackView = UIStackView()
        horizontalStackView.axis = .horizontal
        horizontalStackView.alignment = .fill
        horizontalStackView.distribution = .fill
        horizontalStackView.spacing = 8
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        
        return horizontalStackView
    }

}
