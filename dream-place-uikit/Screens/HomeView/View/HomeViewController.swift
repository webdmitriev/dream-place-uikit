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
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        return $0
    }(UIImageView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 332)))
    
    // MARK: - ScrollView
    private lazy var scrollView: UIScrollView = uiBuilder.addScrollView(bgc: .clear)
    private lazy var scrollContent: UIView = uiBuilder.addView(bgc: .clear, clipsToBounds: false)
    

    // MARK: Header
    private lazy var homeHeaderView: UIView = uiBuilder.addView(bgc: .clear, clipsToBounds: false)
    
    private lazy var homeHeaderLabel: UILabel = uiBuilder.addLabel("Current Location", fz: .label, fw: .medium,
                                                           color: .appWhite, lines: 1)
    
    private lazy var homeHeaderLocation: UILabel = uiBuilder.addLabel("Bohol, Philippines (PH)", fz: .text, fw: .medium,
                                                              color: .appWhite, lines: 1)
    
    private lazy var homeHeaderNotification: UIButton = uiBuilder.addButtonImage("btn-notification", system: false,
                                                                         width: 40, height: 40)
    
    private lazy var homeHeaderNotificationBalloon: UIView = uiBuilder.addView(bgc: .clear)
    

    // MARK: SearchBar
    private lazy var searchBar: UITextField = uiBuilder.addSearchBar("Look for homestay")
    
    private lazy var searchBarBtn: UIButton = uiBuilder.addButtonImage("magnifyingglass",
                                                                       width: 32, height: 32, tint: .appGrayText)

    
    // MARK: Block vertical hotels
    private lazy var blockVerticalHotels: UIView = uiBuilder.addView(bgc: .appWhite, brs: uiBuilder.cornerRadiusStandart)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupOwnedViews()
        
        // output.viewDidLoad()
    }
    
    func displayHotels(_ hotels: [Hotel]) {
        self.hotels = hotels
    }
    
    func displayError(_ error: any Error) {
        print(error.localizedDescription)
    }
    
    private func changeOnboardingStatus(_ status: Bool) {
        UserDefaults.standard.set(status, forKey: "onboardingCompleted")
    }
}

// MARK: Home
extension HomeViewController {
    // setup all ui
    func setupOwnedViews() {
        view.addSubviews(homeBgImageView, scrollView)

        scrollView.addSubview(scrollContent)

        // ui
        setupHeaderUI()
        setupSearchBarUI()
        setupVerticalHotelsUI()

        // delegate
        setupScrollView()
        
        // constraints
        sutupOwnedConstraints()
    }
    
    // setup all constraints
    func sutupOwnedConstraints() {
        setupConstraints()
    }
    
    func setupConstraints() {

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            scrollContent.topAnchor.constraint(equalTo: scrollView.topAnchor),
            scrollContent.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            scrollContent.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            scrollContent.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            scrollContent.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
        ])
    }
}

// MARK: UIScrollViewDelegate - for changing picture on scroll
extension HomeViewController: UIScrollViewDelegate {
    private func setupScrollView() {
        scrollView.delegate = self
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrolledPixels = scrollView.contentOffset.y
        homeBgImageView.frame = CGRect(x: 0, y: -scrolledPixels,
                                       width: view.frame.width, height: view.frame.width + scrolledPixels)
    }
}

// MARK: Header
extension HomeViewController {
    func setupHeaderUI() {
        scrollContent.addSubviews(homeHeaderView, homeHeaderLabel, homeHeaderLocation, homeHeaderNotification, homeHeaderNotificationBalloon)
        
        homeHeaderNotificationBalloon.widthAnchor.constraint(equalToConstant: 10).isActive = true
        homeHeaderNotificationBalloon.heightAnchor.constraint(equalToConstant: 10).isActive = true
        homeHeaderNotificationBalloon.backgroundColor = .appRed
        
        setupHeaderConstraints()
    }
    
    func setupHeaderConstraints() {
        NSLayoutConstraint.activate([
            homeHeaderView.topAnchor.constraint(equalTo: scrollContent.safeAreaLayoutGuide.topAnchor, constant: 0),
            homeHeaderView.leadingAnchor.constraint(equalTo: scrollContent.leadingAnchor, constant: uiBuilder.offset),
            homeHeaderView.trailingAnchor.constraint(equalTo: scrollContent.trailingAnchor, constant: -uiBuilder.offset),
            
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
        scrollContent.addSubviews(searchBar, searchBarBtn)
        
        setupSearchBarConstraints()
    }
    
    func setupSearchBarConstraints() {
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: homeHeaderView.bottomAnchor, constant: 66),
            searchBar.leadingAnchor.constraint(equalTo: scrollContent.leadingAnchor, constant: uiBuilder.offset),
            searchBar.trailingAnchor.constraint(equalTo: scrollContent.trailingAnchor, constant: -uiBuilder.offset),
            
            searchBarBtn.centerYAnchor.constraint(equalTo: searchBar.centerYAnchor),
            searchBarBtn.trailingAnchor.constraint(equalTo: searchBar.trailingAnchor, constant: -18),
        ])
    }
    
    // Methods
    @objc
    func searchButtonTapped() {
        print("searchButtonTapped")
    }
}

// MARK: VerticalHotels
extension HomeViewController {
    func setupVerticalHotelsUI() {
        scrollContent.addSubviews(blockVerticalHotels)
        
        setupVerticalHotelsConstraints()
    }
    
    func setupVerticalHotelsConstraints() {
        NSLayoutConstraint.activate([
            blockVerticalHotels.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 36),
            blockVerticalHotels.leadingAnchor.constraint(equalTo: scrollContent.leadingAnchor),
            blockVerticalHotels.trailingAnchor.constraint(equalTo: scrollContent.trailingAnchor),
            blockVerticalHotels.heightAnchor.constraint(equalToConstant: 1400),
            
            blockVerticalHotels.bottomAnchor.constraint(equalTo: scrollContent.bottomAnchor)
        ])
    }
}
