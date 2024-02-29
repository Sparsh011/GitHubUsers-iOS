//
//  GHUserFieldValue.swift
//  GHFollowersSA
//
//  Created by Sparsh Chadha on 29/02/24.
//

import UIKit

class GHUserFieldValue: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        numberOfLines = 0
        isUserInteractionEnabled = true
        font = UIFont.systemFont(ofSize: 18)
        translatesAutoresizingMaskIntoConstraints = false
        textAlignment = .left
    }
    
}
