//
//  GHFButton.swift
//  GHFollowersSA
//
//  Created by Sparsh on 08/02/24.
//

import UIKit

class GHFButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(backgroundColor: UIColor, buttonTitle: String) {
        super.init(frame: .zero)
        self.backgroundColor = backgroundColor
        self.setTitle(buttonTitle, for: .normal)
        configure()
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        
        layer.cornerRadius = 15
        titleLabel?.textColor = .white
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
    }

}
