//
//  HomeViewController.swift
//  dream-place-uikit
//
//  Created by Олег Дмитриев on 27.08.2025.
//

import UIKit

final class HomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .appBg
        
        title = "Home"
        
        // для сброса onboarding
        // UserDefaults.standard.set(false, forKey: "onboardingCompleted")
    }
    
}
