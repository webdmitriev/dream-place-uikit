//
//  BookingDTO.swift
//  dream-place-uikit
//
//  Created by Олег Дмитриев on 17.09.2025.
//

import Foundation
import CoreLocation

struct BookingDTO: Decodable {
    let name: String
    let image: String?
    let address: String?
    let addressShort: String?
    let gallery: [String]?
    let descr: String?
    let facilities: [String]?
    let price: Int?
    let rating: Double?
    let latitude: Double?
    let longitude: Double?
    
    func toDomain() -> Booking {
        Booking(
            name: name,
            image: image,
            address: address,
            addressShort: addressShort,
            gallery: gallery,
            descr: descr,
            facilities: facilities,
            price: price,
            rating: rating,
            latitude: latitude,
            longitude: longitude,
        )
    }
}

enum FacilityType: String {
    case pool = "Outdoor swimming pool"
    case shuttle = "Airport shuttle"
    case nonSmoking = "Non-smoking rooms"
    case wifi = "Free Wifi"
    case restaurant = "Restaurant"
    case roomService = "Room service"
    case parking = "Free parking"
    case family = "Family rooms"
    case bar = "Bar"
    case breakfast = "Good Breakfast"
    
    var iconName: String {
        switch self {
        case .pool: return "figure.pool.swim"
        case .shuttle: return "car"
        case .nonSmoking: return "nosign"
        case .wifi: return "wifi"
        case .restaurant: return "fork.knife"
        case .roomService: return "bell"
        case .parking: return "parkingsign.circle"
        case .family: return "person.3"
        case .bar: return "wineglass"
        case .breakfast: return "sunrise"
        }
    }
}
