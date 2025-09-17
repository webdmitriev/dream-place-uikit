//
//  BookingInteractor.swift
//  dream-place-uikit
//
//  Created by Олег Дмитриев on 15.09.2025.
//

import Foundation
import Combine

final class BookingInteractor: BookingInteractorInput {
    
    private let repository: BookingRepositoryProtocol
    weak var presenter: BookingInteractorOutput?

    private var cancellables = Set<AnyCancellable>()
    
    init(repository: BookingRepositoryProtocol, presenter: BookingInteractorOutput? = nil) {
        self.repository = repository
        self.presenter = presenter
    }
    
    func fetchBooking() {
        repository.fetchBookings()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                if case let .failure(error) = completion {
                    self?.presenter?.didFetchHotelsFailedWithError(error)
                }
            } receiveValue: { [weak self] booking in
                self?.presenter?.fetchBooking(booking)
            }
            .store(in: &cancellables)
    }
}
