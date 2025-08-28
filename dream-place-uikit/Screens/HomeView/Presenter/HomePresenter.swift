//
//  HomePresenter.swift
//  dream-place-uikit
//
//  Created by Олег Дмитриев on 28.08.2025.
//

import Foundation

class HomePresenter: HomeViewOutput, HomeInteractorOutput {
    
    weak var view: HomeViewInput?
    var interactor: HomeInteractorInput!
    var router: HomeRouterInput!
    
    func viewDidLoad() {
        interactor?.fetchHotels()
    }
    
    func didSelectHotel(at hotel: Hotel) {
        router.navigateToHotelDetails(for: hotel)
    }
    
    func fetchHotels(_ hotels: [Hotel]) {
        view?.displayHotels(hotels)
    }
}
