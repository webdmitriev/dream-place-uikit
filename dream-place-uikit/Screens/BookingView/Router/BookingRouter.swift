//
//  BookingRouter.swift
//  dream-place-uikit
//
//  Created by Олег Дмитриев on 15.09.2025.
//

import Foundation
import UIKit

final class BookingRouter: BookingRouterInput {
    weak var controller: UIViewController?
    
    func navigateToHotelDetail(for booking: Booking) {
        print(booking)
        print("navigateToHotelDetail")
    }
    
    
}
