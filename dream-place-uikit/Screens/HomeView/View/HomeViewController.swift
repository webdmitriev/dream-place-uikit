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
    

    // MARK: SearchBar
    lazy var searchBar: UITextField = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.heightAnchor.constraint(equalToConstant: 48).isActive = true
        $0.placeholder = "Look for homestay"
        $0.textColor = .appGrayText
        $0.backgroundColor = .appWhite
        $0.layer.cornerRadius = 24
        $0.addPaddingToTextField()
        return $0
    }(UITextField())
    
    lazy var searchFindButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.widthAnchor.constraint(equalToConstant: 32).isActive = true
        $0.heightAnchor.constraint(equalToConstant: 32).isActive = true
        $0.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        $0.tintColor = .appGrayText
        return $0
    }(UIButton())
    
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
        setupSearchBarUI()
        
    }
    
    func sutupOwnedConstraints() {
        setupConstraints()
        setupHeaderConstraints()
        setupSearchBarConstraints()
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
            
            homeHeaderView.bottomAnchor.constraint(equalTo: homeHeaderNotification.bottomAnchor, constant: 0)
        ])
    }
}

// MARK: SearchBar
extension HomeViewController {
    func setupSearchBarUI() {
        [searchBar, searchFindButton].forEach {
            view.addSubview($0)
        }
    }
    
    func setupSearchBarConstraints() {
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: homeHeaderView.bottomAnchor, constant: 66),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: uiBuilder.offset),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -uiBuilder.offset),
            
            searchFindButton.centerYAnchor.constraint(equalTo: searchBar.centerYAnchor),
            searchFindButton.trailingAnchor.constraint(equalTo: searchBar.trailingAnchor, constant: -24),
        ])
    }
}
