//
//  Builder.swift
//  dream-place-uikit
//
//  Created by Олег Дмитриев on 27.08.2025.
//

import UIKit

final class Builder {
    static func createOnboardingView() -> UIViewController {
        let view = OnboardingView()
        return view
    }
    
    static func createHomeView() -> UIViewController {
        let viewController = HomeViewController()
        let presenter = HomePresenter()
        let interactor = MockHomeInteractor() // mock
        let router = HomeRouter()
        
        viewController.output = presenter
        presenter.view = viewController
        presenter.interactor = interactor
        presenter.router = router
        
        interactor.presenter = presenter
        viewController.router = router
        router.controller = viewController
        
        viewController.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
        
        return viewController
    }
    
    static func createBookingView() -> UIViewController {
        let view = BookingViewController()
        view.tabBarItem = UITabBarItem(title: "Booking", image: UIImage(named: "tab-bar-check"), tag: 1)
        return view
    }
    
    static func createFavoriteView() -> UIViewController {
        let view = FavoriteViewController()
        view.tabBarItem = UITabBarItem(title: "Favorite", image: UIImage(systemName: "heart"), tag: 2)
        return view
    }
    
    static func createProfileView() -> UIViewController {
        let view = ProfileViewController()
        view.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(named: "tab-bar-person"), tag: 3)
        return view
    }
    
    static func createTabBarController() -> UITabBarController {
        let tabBarController = UITabBarController()
        
        let homeVC = createHomeView()
        let bookingVC = createBookingView()
        let favoriteVC = createFavoriteView()
        let profileVC = createProfileView()
        
        tabBarController.viewControllers = [
            UINavigationController(rootViewController: homeVC),
            UINavigationController(rootViewController: bookingVC),
            UINavigationController(rootViewController: favoriteVC),
            UINavigationController(rootViewController: profileVC)
        ]
        
        configureTabBarAppearance(tabBarController.tabBar)
        
        return tabBarController
    }
    
    private static func configureTabBarAppearance(_ tabBar: UITabBar) {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        
        // 1. Цвет фона TabBar
        appearance.backgroundColor = .appBg
        
        // 2. Border сверху
        appearance.shadowColor = .gray
        appearance.shadowImage = nil
        
        // 3. Настройка фона для разных состояний
        appearance.stackedLayoutAppearance.normal.iconColor = .gray
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [
            .foregroundColor: UIColor.gray,
            .font: UIFont.systemFont(ofSize: 10)
        ]
        
        appearance.stackedLayoutAppearance.selected.iconColor = .systemBlue
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [
            .foregroundColor: UIColor.systemBlue,
            .font: UIFont.systemFont(ofSize: 10, weight: .medium)
        ]
        
        // 4. Применяем настройки
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance
        
        // 5. Дополнительные настройки
        tabBar.tintColor = .systemBlue
        tabBar.unselectedItemTintColor = .gray
        
        // 6. Убираем полупрозрачность
        tabBar.isTranslucent = false
    }
}
