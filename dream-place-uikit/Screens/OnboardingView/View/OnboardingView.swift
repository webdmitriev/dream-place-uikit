//
//  OnboardingView.swift
//  dream-place-uikit
//
//  Created by Олег Дмитриев on 27.08.2025.
//

import UIKit

final class OnboardingView: UIViewController {
    
    private let builder = UIBuilder()
    
    private lazy var galleryView: UIImageView = builder.addOnboardingImage("onboarding")
    
    private lazy var onboardingTitle: UILabel = builder.addLabel(
        "Let’s Find Your Sweet \n& Dream Place",
        fz: .onboardingTitle,
        fw: .bold,
        align: .center)
    
    private lazy var onboardingDescr: UILabel = builder.addLabel(
        "Get the opportunity to stay at your dream location at an affordable price",
        fz: .text,
        align: .center)
    
    private lazy var skipButton: UIButton = builder.addButton("Let's go")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .appWhite
        
        [galleryView, onboardingTitle, onboardingDescr, skipButton].forEach {
            view.addSubview($0)
        }
        
        setupConstraints()
        
        skipButton.addTarget(self, action: #selector(skipButtonTapped), for: .touchUpInside)
    }

    // Methods
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            galleryView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            galleryView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            galleryView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            galleryView.heightAnchor.constraint(equalTo: galleryView.widthAnchor, constant: 0),
            
            onboardingTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: builder.offset),
            onboardingTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -builder.offset),
            onboardingTitle.bottomAnchor.constraint(equalTo: onboardingDescr.topAnchor, constant: -16),
            
            onboardingDescr.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: builder.offset),
            onboardingDescr.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -builder.offset),
            onboardingDescr.bottomAnchor.constraint(equalTo: skipButton.topAnchor, constant: -64),
            
            skipButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: builder.offset),
            skipButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -builder.offset),
            skipButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -builder.offset),
        ])
    }
    
    @objc private func skipButtonTapped() {
        if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
            UserDefaults.standard.set(true, forKey: "onboardingCompleted")
            sceneDelegate.sceneHomeView(showTabBar: true)
        }
    }
}
