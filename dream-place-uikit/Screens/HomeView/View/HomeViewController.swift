//
//  HomeViewController.swift
//  dream-place-uikit
//
//  Created by Олег Дмитриев on 27.08.2025.
//

import UIKit

final class HomeViewController: UIViewController, HomeViewInput {
    
    private var hotels = [Hotel]()
    private let uiBuilder = UIBuilder()
    
    var output: HomeViewOutput!
    
    lazy var homeBgImageView: UIImageView = {
        $0.image = UIImage(named: "home-bg")
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        return $0
    }(UIImageView())
    
    // Scroll
    lazy var scrollView: UIScrollView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIScrollView())
    
    // MARK: Header
    lazy var homeHeaderView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIStackView())
    
    lazy var homeHeaderLabel: UILabel = uiBuilder.addLabel("Current Location", fz: .label, fw: .medium,
                                                           color: .appWhite, lines: 1)
    
    lazy var homeHeaderLocation: UILabel = uiBuilder.addLabel("Labuan Bajo, INA Labuan Bajo, INA Labuan Bajo, INA Labuan Bajo, INA Labuan Bajo, INA", fz: .text, fw: .medium,
                                                              color: .appWhite, lines: 1)
    
    lazy var homeHeaderNotification: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.widthAnchor.constraint(equalToConstant: 40).isActive = true
        $0.heightAnchor.constraint(equalToConstant: 40).isActive = true
        $0.setImage(UIImage(named: "btn-notification"), for: .normal)
        return $0
    }(UIButton())
    
    lazy var homeHeaderNotificationBalloon: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.widthAnchor.constraint(equalToConstant: 10).isActive = true
        $0.heightAnchor.constraint(equalToConstant: 10).isActive = true
        $0.backgroundColor = .appRed
        $0.isHidden = false
        return $0
    }(UIView())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupOwnedViews()
        sutupOwnedConstraints()
        
        // output.viewDidLoad()
        
    }
    
    func displayHotels(_ hotels: [Hotel]) {
        self.hotels = hotels
    }
    
    func displayError(_ error: any Error) {
        print(error.localizedDescription)
    }
    
    func changeOnboardingStatus(_ status: Bool) {
        UserDefaults.standard.set(status, forKey: "onboardingCompleted")
    }
}

// MARK: Home
extension HomeViewController {
    func setupOwnedViews() {
        [homeBgImageView, scrollView].forEach {
            view.addSubview($0)
        }
        setupHeaderUI()
    }
    
    func sutupOwnedConstraints() {
        setupConstraints()
        setupHeaderConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            homeBgImageView.topAnchor.constraint(equalTo: view.topAnchor),
            homeBgImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            homeBgImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            homeBgImageView.heightAnchor.constraint(equalToConstant: 332),
            
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            scrollView.bottomAnchor.constraint(equalTo: homeHeaderView.bottomAnchor, constant: 0)
        ])
    }
}


// MARK: Header
extension HomeViewController {
    func setupHeaderUI() {
        [homeHeaderView, homeHeaderLabel, homeHeaderLocation, homeHeaderNotification, homeHeaderNotificationBalloon].forEach {
            view.addSubview($0)
        }
    }
    
    func setupHeaderConstraints() {
        NSLayoutConstraint.activate([
            homeHeaderView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            homeHeaderView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: uiBuilder.offset),
            homeHeaderView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -uiBuilder.offset),
            
            homeHeaderLabel.topAnchor.constraint(equalTo: homeHeaderView.topAnchor, constant: 0),
            homeHeaderLabel.leadingAnchor.constraint(equalTo: homeHeaderView.leadingAnchor, constant: 0),
            homeHeaderLabel.trailingAnchor.constraint(equalTo: homeHeaderNotification.leadingAnchor, constant: -20),
            
            homeHeaderLocation.topAnchor.constraint(equalTo: homeHeaderLabel.bottomAnchor, constant: 4),
            homeHeaderLocation.leadingAnchor.constraint(equalTo: homeHeaderView.leadingAnchor, constant: 0),
            homeHeaderLocation.trailingAnchor.constraint(equalTo: homeHeaderNotification.leadingAnchor, constant: -20),
            
            homeHeaderNotification.topAnchor.constraint(equalTo: homeHeaderView.topAnchor, constant: 0),
            homeHeaderNotification.trailingAnchor.constraint(equalTo: homeHeaderView.trailingAnchor, constant: 0),
            
            homeHeaderNotificationBalloon.topAnchor.constraint(equalTo: homeHeaderNotification.topAnchor, constant: 8),
            homeHeaderNotificationBalloon.trailingAnchor.constraint(equalTo: homeHeaderNotification.trailingAnchor, constant: -8),
        ])
    }
}
