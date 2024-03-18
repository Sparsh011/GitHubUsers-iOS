//
//  GHUsernameLabel.swift
//  GitHubUsers
//
//  Created by Sparsh Chadha on 18/03/24.
//

import UIKit

class GHUsernameLabel: UILabel {
    private var profileUrl: URL?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init() {
        super.init(frame: .zero)
        configure()
    }
    
    private func configure() {
        textColor = .systemBlue
        textAlignment = .center
        numberOfLines = 0
        isUserInteractionEnabled = true
        font = UIFont.boldSystemFont(ofSize: 22)
        translatesAutoresizingMaskIntoConstraints = false
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(openGitHubProfile))
        
        addGestureRecognizer(tapGesture)
    }
    
    func setNameAndBio(name: String, bio: String) {
        let fullName = NSMutableAttributedString(string: name)
        let bioText = NSMutableAttributedString(string: "\n \(bio)")
        
        let bioAttributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.foregroundColor: UIColor.label,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)
        ]
        bioText.addAttributes(bioAttributes, range: NSRange(location: 0, length: bioText.length))
        
        fullName.append(bioText)
        attributedText = fullName
    }
    
    
    func setProfileUrl(_ url: URL?) {
        self.profileUrl = url
    }
    
    @objc private func openGitHubProfile() {
        if let url = profileUrl {
            UIApplication.shared.open(url)
        }
    }
    
}
