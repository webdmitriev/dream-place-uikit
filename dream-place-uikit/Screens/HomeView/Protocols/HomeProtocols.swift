//
//  HomeProtocols.swift
//  dream-place-uikit
//
//  Created by Олег Дмитриев on 28.08.2025.
//

import Foundation

// View
protocol HomeViewInput: AnyObject {
    func displayHotels(_ hotels: [Hotel])
    func displayError(_ error: Error)
}


// Presenter
protocol HomeViewOutput: AnyObject {
    func viewDidLoad()
    func didSelectHotel(at hotel: Hotel)
    func changeOnboardingStatus(_ status: Bool)
}


// Interactor
protocol HomeInteractorInput: AnyObject {
    func fetchHotels()
}

protocol HomeInteractorOutput: AnyObject {
    func fetchHotels(_ hotels: [Hotel])
}


// Router
protocol HomeRouterInput: AnyObject {
    func navigateToHotelDetails(for hotel: Hotel)
}
