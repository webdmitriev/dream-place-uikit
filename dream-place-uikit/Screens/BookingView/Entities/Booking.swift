//
//  Booking.swift
//  dream-place-uikit
//
//  Created by Олег Дмитриев on 15.09.2025.
//

import Foundation
import CoreLocation

struct Booking: Hashable, Identifiable {
    let id = UUID()
    let name: String
    
    var image: String?
    var address: String?
    var addressShort: String?
    var gallery: [String]?
    var descr: String?
    var facilities: [String]?
    var price: Int?
    var rating: Double?

    var latitude: Double?
    var longitude: Double?

    var coordinate: CLLocationCoordinate2D? {
        guard let latitude, let longitude else { return nil }
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}

