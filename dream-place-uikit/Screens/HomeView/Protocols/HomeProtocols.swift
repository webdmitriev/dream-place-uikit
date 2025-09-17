//
//  HomeProtocols.swift
//  dream-place-uikit
//
//  Created by Олег Дмитриев on 28.08.2025.
//

import Foundation

// View
protocol HomeViewInput: AnyObject {
    func didLoadSections(_ sections: [CollectionStruct])
    func didFailWithError(_ error: any Error)
}


// Presenter
protocol HomeViewOutput: AnyObject {
    func viewDidLoad()
    func didSelectBooking(at hotel: Booking)
    func changeOnboardingStatus(_ status: Bool)
}


// Interactor
protocol HomeInteractorInput: AnyObject {
    func fetchData()
}

protocol HomeInteractorOutput: AnyObject {
    func didLoadSections(_ sections: [CollectionStruct])
    func didFailWithError(_ error: Error)
}


// Router
protocol HomeRouterInput: AnyObject {
    func navigateToBookingDetails(for booking: Booking)
}
