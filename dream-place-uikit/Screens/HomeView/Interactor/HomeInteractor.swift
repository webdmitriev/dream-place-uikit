//
//  HomeInteractor.swift
//  dream-place-uikit
//
//  Created by Олег Дмитриев on 28.08.2025.
//

import Foundation
import Combine

class HomeInteractor: HomeInteractorInput {

    private let repository: BookingRepositoryProtocol
    weak var presenter: HomeInteractorOutput?
    
    private var cancellables: Set<AnyCancellable> = []
    
    init (repository: BookingRepositoryProtocol, presenter: HomeInteractorOutput? = nil) {
        self.repository = repository
        self.presenter = presenter
    }
    
    func fetchData() {
        // 1. Сначала собираем статичные секции
        var sections: [CollectionStruct] = [
            CollectionStruct(title: "Hotel Near You", action: false, type: .header, items: [.booking(Booking(name: "Header"))]),
            CollectionStruct(title: "Search", action: false, type: .search, items: [.booking(Booking(name: "Search"))]),
            CollectionStruct(title: "Hotel Near You", action: true, type: .hotels, items: []),
            CollectionStruct(title: "Explore Place", action: true, type: .places, items: [])
        ]
        
        // 2. Загружаем отели
        repository.fetchBookings()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                if case let .failure(error) = completion {
                    self?.presenter?.didFailWithError(error)
                }
            } receiveValue: { [weak self] bookings in
                guard let self = self else { return }
                
                if let index = sections.firstIndex(where: { $0.type == .hotels }) {
                    sections[index] = CollectionStruct(
                        title: "Hotel Near You",
                        action: true,
                        type: .hotels,
                        items: bookings.map { SectionItem.booking($0) }
                    )
                }
                
                self.presenter?.didLoadSections(sections)
            }
            .store(in: &cancellables)
        

        // 3. Загружаем места
        repository.fetchPlaces()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                if case let .failure(error) = completion {
                    self?.presenter?.didFailWithError(error)
                }
            } receiveValue: { [weak self] places in
                guard let self = self else { return }
                
                if let index = sections.firstIndex(where: { $0.type == .places }) {
                    sections[index] = CollectionStruct(
                        title: "Explore Place",
                        action: true,
                        type: .places,
                        items: places.map { SectionItem.places($0) }
                    )
                }
                
                self.presenter?.didLoadSections(sections)
            }
            .store(in: &cancellables)
    }
    
}
