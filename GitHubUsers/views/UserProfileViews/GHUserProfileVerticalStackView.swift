//
//  GHUserProfileVerticalStackView.swift
//  GitHubUsers
//
//  Created by Sparsh Chadha on 18/03/24.
//

import UIKit

class GHUserProfileVerticalStackView: UIStackView {
    
    init(profile: GitHubUser) {
        super.init(frame: .zero)
        configure(profile: profile)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(profile: GitHubUser) {
        configureStackView()
        configureAvatar(avatarUrlStr: profile.avatarUrl)
        configureUsernameAndBio(name: profile.name, profileUrl: profile.htmlUrl, bio: profile.bio)
    }
    
    private func configureStackView() {
        axis = .vertical
        spacing = 10
        translatesAutoresizingMaskIntoConstraints = false
        isUserInteractionEnabled = true
    }
    
    private func configureAvatar(avatarUrlStr: String) {
        let userAvatar = GHAvatarImageView()
        userAvatar.loadImage(fromUrl: URL(string: avatarUrlStr))
        addArrangedSubview(userAvatar)
    }
    
    private func configureUsernameAndBio(name: String?, profileUrl: String, bio: String?) {
        let nameLabel = GHUsernameLabel()
        nameLabel.setNameAndBio(name: name ?? "Name Unavailable", bio: bio ?? "")
        nameLabel.setProfileUrl(URL(string: profileUrl))
        addArrangedSubview(nameLabel)
    }
}
