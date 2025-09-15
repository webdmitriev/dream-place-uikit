//
//  BookingInteractor.swift
//  dream-place-uikit
//
//  Created by Олег Дмитриев on 15.09.2025.
//

import Foundation

final class BookingInteractor: BookingInteractorInput {
    
    weak var presenter: BookingInteractorOutput?
    
    func fetchBooking() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            let booking: [Booking] = [
                Booking(name: "Anda Blue House",
                        image: "https://api.webdmitriev.com/wp-content/uploads/2025/07/boholano-house-06-01.jpg",
                        address: "Anda Provincial Road 1022, 6311 Anda, Philippines",
                        addressShort: "Anda, Bohol",
                        gallery: [
                          "https://api.webdmitriev.com/wp-content/uploads/2025/07/boholano-house-06-01.jpg",
                          "https://api.webdmitriev.com/wp-content/uploads/2025/07/boholano-house-06-02.jpg",
                          "https://api.webdmitriev.com/wp-content/uploads/2025/07/boholano-house-06-03.jpg"
                        ],
                        descr: "Featuring an outdoor pool, lush green gardens, Bohol Beach Club is a beachfront resort that offers peaceful and comfortable accommodations with free WiFi access in the entire property. It operates a 24-hour front desk and features a private beach area where activities such as canoeing and windsurfing can be enjoyed. \n\nOffering sea views from the balcony, air-conditioned rooms come with a wardrobe, electronic safe, seating area and a flat-screen TV with cable/satellite channels. Rooms have a private entrance and private bathroom equipped with shower facility, hairdryer and free toiletries.",
                        facilities: ["Outdoor swimming pool", "Airport shuttle", "Non-smoking rooms", "Free Wifi", "Restaurant", "Room service", "Free parking", "Family rooms", "Bar"],
                        price: 18, rating: 4.8, latitude: 9.72435, longitude: 124.51744),
            ]
            
            self.presenter?.fetchBooking(booking)
        }
    }
    
    
}
