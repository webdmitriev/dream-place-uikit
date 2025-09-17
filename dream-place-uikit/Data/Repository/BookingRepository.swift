//
//  BookingRepository.swift
//  dream-place-uikit
//
//  Created by Олег Дмитриев on 17.09.2025.
//

import Foundation
import Combine

protocol BookingRepositoryProtocol {
    func fetchBookings() -> AnyPublisher<[Booking], Error>
}

final class BookingRepository: BookingRepositoryProtocol {
    private let baseURL = URL(string: "https://api.webdmitriev.com/wp-json/wp/v2")!
    private let urlSession: URLSession
    
    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }
    
    func fetchBookings() -> AnyPublisher<[Booking], Error> {
        let url = baseURL.appendingPathComponent("dream-place")
        
        return urlSession.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [BookingDTO].self, decoder: JSONDecoder())
            .map { $0.map { $0.toDomain() } }
            .eraseToAnyPublisher()
    }
}
