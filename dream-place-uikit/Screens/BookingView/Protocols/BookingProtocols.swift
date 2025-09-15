//
//  BookingProtocols.swift
//  dream-place-uikit
//
//  Created by Олег Дмитриев on 15.09.2025.
//

import Foundation

// view
protocol BookingViewInput: AnyObject {
    func displayBooking(_ booking: [Booking])
    func displayError(_ error: Error)
}


// presenter
protocol BookingViewOutput: AnyObject {
    func viewDidLoad()
    func didSelectBooking(at booking: Booking)
}


// interactor
protocol BookingInteractorInput: AnyObject {
    func fetchBooking()
}

protocol BookingInteractorOutput: AnyObject {
    func fetchBooking(_ bookig: [Booking])
    func didFetchHotelsFailedWithError(_ error: Error)
}


// router
protocol BookingRouterInput: AnyObject {
    func navigateToHotelDetail(for booking: Booking)
}
