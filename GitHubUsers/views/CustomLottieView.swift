//
//  GHLoader.swift
//  GitHubUsers
//
//  Created by Sparsh Chadha on 13/03/24.
//

import UIKit
import Lottie

extension LottieAnimationView {
    func configureAnimationView(
        contentMode: ContentMode = .scaleAspectFit,
        loopMode: LottieLoopMode = .loop,
        animationSpeed: CGFloat = 1
    ) {
        translatesAutoresizingMaskIntoConstraints = false
        self.contentMode = contentMode
        self.loopMode = loopMode
        self.animationSpeed = animationSpeed
    }
}
