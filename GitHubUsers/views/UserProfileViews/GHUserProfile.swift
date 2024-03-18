//
//  GHUserProfile.swift
//  GitHubUsers
//
//  Created by Sparsh Chadha on 14/03/24.
//

import UIKit

class GHUserProfile: UIScrollView {
//    private let avatarIV = GHAvatarImageView()
//    private let verticalStackView: UIStackView = {
//        let stackView = UIStackView()
//        stackView.axis = .vertical
//        stackView.spacing = 10
//        stackView.translatesAutoresizingMaskIntoConstraints = false
//        stackView.isUserInteractionEnabled = true
//        return stackView
//    }()
//    
//    private let nameLabel: UILabel = {
//        let label = UILabel()
//        label.textColor = .systemBlue
//        label.textAlignment = .center
//        label.numberOfLines = 0
//        label.isUserInteractionEnabled = true
//        label.font = UIFont.boldSystemFont(ofSize: 22)
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//    
//    private let categoryLabel: UILabel = {
//        let label = UILabel()
//        label.textAlignment = .left
//        label.numberOfLines = 0
//        label.isUserInteractionEnabled = false
//        label.font = UIFont.boldSystemFont(ofSize: 22)
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//    
//    private let contentLabel: UILabel = {
//        let label = UILabel()
//        label.textColor = UIColor(cgColor: CGColor(
//            srgbRed: 139/255,
//            green: 50/255,
//            blue: 170/255,
//            alpha: 1.0
//        ))
//        label.textAlignment = .right
//        label.numberOfLines = 0
//        label.isUserInteractionEnabled = false
//        label.font = UIFont.boldSystemFont(ofSize: 22)
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//    private let contentColor = UIColor(cgColor: CGColor(
//        srgbRed: 139/255,
//        green: 50/255,
//        blue: 170/255,
//        alpha: 1.0
//    ))
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(profile: GitHubUser, delegate: UIViewController) {
        super.init(frame: .zero)
        configure(profile: profile)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configure(profile: GitHubUser) {
        addSubview(GHUserProfileVerticalStackView(profile: profile))
    }
    
}
