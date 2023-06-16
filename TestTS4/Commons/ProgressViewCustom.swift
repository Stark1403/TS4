//
//  ProgressViewCustom.swift
//  TestTS4
//
//  Created by cesar.torres on 14/06/23.
//

import Lottie
import UIKit

class ProgressViewCustom {
    var loader: LottieAnimationView
    var viewWithBlurredBackground: UIVisualEffectView
    let widthProgress: CGFloat = 200.0
    let animationSpeed: CGFloat = 1.0
    var contentView: UIView
    init(inView: UIView) {
        self.contentView = inView
        loader = LottieAnimationView(name: "loader")
        loader.contentMode = .scaleAspectFit
        loader.loopMode = .loop
        loader.animationSpeed = animationSpeed
        let effect = UIBlurEffect(style: .light)
        viewWithBlurredBackground = UIVisualEffectView(effect: effect)
        viewWithBlurredBackground.frame = inView.frame
        viewWithBlurredBackground.contentView.addSubview(loader)
        loaderConstraints()
    }

    private func loaderConstraints() {
        loader.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loader.centerXAnchor.constraint(equalTo: viewWithBlurredBackground.centerXAnchor),
            loader.centerYAnchor.constraint(equalTo: viewWithBlurredBackground.centerYAnchor),
            loader.widthAnchor.constraint(equalToConstant: widthProgress),
            loader.heightAnchor.constraint(equalToConstant: widthProgress)
        ])
    }

    private func contentConstraints() {
        viewWithBlurredBackground.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            viewWithBlurredBackground.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            viewWithBlurredBackground.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            viewWithBlurredBackground.topAnchor.constraint(equalTo: contentView.topAnchor),
            viewWithBlurredBackground.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

    func startProgressView() {
        contentView.addSubview(viewWithBlurredBackground)
        contentConstraints()
        loader.play()
    }

    func stopProgressView() {
        loader.stop()
        viewWithBlurredBackground.alpha = 1.0
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.3, options: .curveEaseIn, animations: { [weak self] in
            self?.viewWithBlurredBackground.alpha = 0.0
        }, completion: { [weak self] _ in
            self?.loader.removeFromSuperview()
            self?.viewWithBlurredBackground.removeFromSuperview()
        })
    }
}
