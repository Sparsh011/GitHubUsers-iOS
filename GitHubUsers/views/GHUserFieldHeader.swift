//
//  GHUserFieldHeader.swift
//  GHFollowersSA
//
//  Created by Sparsh Chadha on 29/02/24.
//

import UIKit

class GHUserFieldHeader: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    init(text: String) {
        super.init(frame: .zero)
        configure(text: text)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(text: String = "") {
        self.text = "  \(text)"
        numberOfLines = 0
        isUserInteractionEnabled = true
        font = UIFont.boldSystemFont(ofSize: 22)
        translatesAutoresizingMaskIntoConstraints = false
        textAlignment = .left
        
    }
}
