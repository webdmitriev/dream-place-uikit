//
//  HomeRouter.swift
//  dream-place-uikit
//
//  Created by Олег Дмитриев on 28.08.2025.
//

import UIKit

final class HomeRouter: HomeRouterInput {

    weak var controller: UIViewController?
    
    func navigateToBookingDetails(for booking: Booking) {
        let alert = UIAlertController(title: booking.name, message: booking.address, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        controller?.present(alert, animated: true)
        
        //controller?.navigationController?.pushViewController(UIViewController(), animated: true)
    }
    
    func openBookingTab() {
        controller?.tabBarController?.selectedIndex = 1
    }
    
}
