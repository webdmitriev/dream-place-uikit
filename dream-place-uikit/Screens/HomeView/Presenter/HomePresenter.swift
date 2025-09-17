//
//  HomePresenter.swift
//  dream-place-uikit
//
//  Created by Олег Дмитриев on 28.08.2025.
//

import Foundation

final class HomePresenter: HomeViewOutput, HomeInteractorOutput {

    weak var view: HomeViewInput?
    var interactor: HomeInteractorInput!
    var router: HomeRouterInput!
    
    func viewDidLoad() {
        interactor?.fetchData()
    }
    
    func didSelectBooking(at booking: Booking) {
        router.navigateToBookingDetails(for: booking)
    }
    
    func changeOnboardingStatus(_ status: Bool) {
        UserDefaults.standard.set(status, forKey: "onboardingCompleted")
    }
    
    // MARK: - HomeInteractorOutput
    func didLoadSections(_ sections: [CollectionStruct]) {
        view?.didLoadSections(sections)
    }
    
    func didFailWithError(_ error: any Error) {
        view?.didFailWithError(error)
    }
}
