//
//  PlacesDTO.swift
//  dream-place-uikit
//
//  Created by Олег Дмитриев on 18.09.2025.
//

import Foundation
import CoreLocation

struct PlacesDTO: Decodable {
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
    
    func toDomain() -> Places {
        Places(
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

struct Places: Hashable, Identifiable {
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
