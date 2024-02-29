//
//  GFHTextField.swift
//  GHFollowersSA
//
//  Created by Sparsh on 08/02/24.
//

import UIKit

class GHFTextField: UITextField, UITextFieldDelegate {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    init(placeholder: String) {
        super.init(frame: .zero)
        configure(placeholder: placeholder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(placeholder: String = "") {
        translatesAutoresizingMaskIntoConstraints = false
        
        layer.cornerRadius = 15
        layer.borderWidth = 1
        layer.borderColor = CGColor(
            srgbRed: 139/255,
            green: 50/255,
            blue: 170/255,
            alpha: 1.0
        )
        
        textColor = .label
        tintColor = UIColor(red: 139/255, green: 50/255, blue: 170/255, alpha: 1.0)

        textAlignment = .center
        font = UIFont.preferredFont(forTextStyle: .title3)
        adjustsFontSizeToFitWidth = true
        minimumFontSize = 12
        
        backgroundColor = .secondarySystemBackground
        autocorrectionType = .no
        
        self.placeholder = placeholder
        delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        resignFirstResponder()
        return true
    }
}
