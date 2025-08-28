//
//  HomeInteractor.swift
//  dream-place-uikit
//
//  Created by Олег Дмитриев on 28.08.2025.
//

import Foundation

class MockHomeInteractor: HomeInteractorInput {
    
    weak var presenter: HomeInteractorOutput?
    
    func fetchHotels() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            let hotels: [Hotel] = [
                Hotel(title: "Anda Blue House", address: "Barangay Trinidad 6310, Philippines",
                      price: 43.0, rating: 9.5),
                Hotel(title: "Calape Vacation Village and Resort", address: "Pangangan Island, Calape, 6328 Bohol",
                      price: 31.0, rating: 9.4),
                Hotel(title: "Bohol of the slope Hotel", address: "Barangay Danao, Panglao Island, Bohol, 6340",
                      price: 29.0, rating: 9.8),
                Hotel(title: "Abraham Bohol", address: "Purok 5, Panglao Island Circumferencial Rd Brgy. Danao",
                      price: 11.0, rating: 8.6),
                Hotel(title: "Panglao Severus Beach Hotel", address: "Barangay Danao, Panglao Island, Bohol, 6340",
                      price: 17.0, rating: 7.4),
                Hotel(title: "Panglao Green Hotel", address: "Barangay Danao, Panglao Island, Bohol, 6340",
                      price: 34.0, rating: 7.5),
            ]
            
            self.presenter?.fetchHotels(hotels)
//            if Bool.random() {
//                self.presenter?.fetchHotels(hotels)
//            } else {
//                // self.presenter?.fetchError(/* ошибка */)
//            }
        }
    }
    
}

class HomeInteractor: HomeInteractorInput {
    
    weak var presenter: HomeInteractorOutput?
    
    func fetchHotels() {
        print("oi")
    }
    
}
