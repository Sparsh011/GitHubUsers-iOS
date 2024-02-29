//
//  CustomToast.swift
//  GHFollowersSA
//
//  Created by Sparsh on 23/02/24.
//

import Foundation
import UIKit

extension UIViewController {
    
    func showToast(message : String, font: UIFont) {
        
        let toastLabel = UILabel(
            frame: CGRect(x: self.view.frame.size.width/2 - 75,
                          y: self.view.frame.size.height - 100,
                          width: 150,
                          height: 35)
        )
        
        toastLabel.backgroundColor = .systemGray
        toastLabel.textColor = .white
        toastLabel.font = font
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds = true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
}
