//
//  BookingPresenter.swift
//  dream-place-uikit
//
//  Created by Олег Дмитриев on 15.09.2025.
//

import Foundation

final class BookingPresenter: BookingViewOutput, BookingInteractorOutput {
        
    weak var view: BookingViewInput?
    var interactor: BookingInteractorInput!
    var router: BookingRouterInput!
    
    func viewDidLoad() {
        interactor?.fetchBooking()
    }
    
    func didSelectBooking(at booking: Booking) {
        router.navigateToHotelDetail(for: booking)
    }
    
    func fetchBooking(_ booking: [Booking]) {
        view?.displayBooking(booking)
    }
    
    func didFetchHotelsFailedWithError(_ error: any Error) {
        print(error.localizedDescription)
    }
    
    
}
