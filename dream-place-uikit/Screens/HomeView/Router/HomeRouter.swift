//
//  HomeRouter.swift
//  dream-place-uikit
//
//  Created by Олег Дмитриев on 28.08.2025.
//

import UIKit

final class HomeRouter: HomeRouterInput {
    weak var controller: UIViewController?
    
    func navigateToHotelDetails(for hotel: Hotel) {
        let alert = UIAlertController(title: hotel.title, message: hotel.address, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        controller?.present(alert, animated: true)
        
        //controller?.navigationController?.pushViewController(UIViewController(), animated: true)
    }
    
    func openBookingTab() {
        controller?.tabBarController?.selectedIndex = 1
    }
    
}
