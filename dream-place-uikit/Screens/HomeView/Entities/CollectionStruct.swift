//
//  CollectionStruct.swift
//  dream-place-uikit
//
//  Created by Олег Дмитриев on 04.09.2025.
//

import Foundation
import CoreLocation

enum SectionType {
    case header
    case search
    case hotels
    case places
}

struct Items: Hashable, Identifiable {
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

struct CollectionStruct: Hashable {
    let title: String
    let action: Bool
    let type: SectionType
    let items: [Items]
    
    static func mockData() -> [CollectionStruct] {
        [
            CollectionStruct(title: "Hotel Near You", action: false, type: .header, items: [
                Items(name: "Header")
            ]),
            CollectionStruct(title: "Search", action: false, type: .search, items: [
                Items(name: "Search")
            ]),
            CollectionStruct(title: "Hotel Near You", action: true, type: .hotels, items: [
                Items(name: "Anda Blue House",
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
                Items(name: "Calape Bohol",
                      image: "https://api.webdmitriev.com/wp-content/uploads/2025/07/boholano-house-06-02.jpg",
                      address: "Pangangan Island, Calape, 6328 Bohol",
                      addressShort: "Calape, Bohol",
                      gallery: [
                        "https://api.webdmitriev.com/wp-content/uploads/2025/07/boholano-house-06-10.jpg",
                        "https://api.webdmitriev.com/wp-content/uploads/2025/07/boholano-house-06-11.jpg",
                        "https://api.webdmitriev.com/wp-content/uploads/2025/07/boholano-house-06-12.jpg"
                      ],
                      descr: "Welcome to resort paradise we ensure the best service during your stay in bali with an emphasis on customer comfort. Enjoy Balinese specialties, dance and music every Saturday for free at competitive prices. You can enjoy all the facilities at our resort",
                      facilities: ["Outdoor swimming pool", "Fitness center", "Non-smoking rooms", "Free Wifi", "Restaurant", "Free parking", "Bar", "Breakfast"],
                      price: 24, rating: 4.5),
                Items(name: "Bohol",
                      image: "https://api.webdmitriev.com/wp-content/uploads/2025/07/boholano-house-06-03.jpg",
                      address: "Barangay Danao, Panglao Island, Bohol, 6340",
                      addressShort: "Panglao Island",
                      gallery: [
                        "https://api.webdmitriev.com/wp-content/uploads/2025/07/boholano-house-06-09.jpg",
                        "https://api.webdmitriev.com/wp-content/uploads/2025/07/boholano-house-06-08.jpg",
                        "https://api.webdmitriev.com/wp-content/uploads/2025/07/boholano-house-06-07.jpg"
                      ],
                      descr: "Welcome to resort paradise we ensure the best service during your stay in bali with an emphasis on customer comfort. Enjoy Balinese specialties, dance and music every Saturday for free at competitive prices. You can enjoy all the facilities at our resort",
                      facilities: ["2 swimming pools", "Non-smoking rooms", "Free Wifi", "Restaurant", "Family rooms", "Bar", "Breakfast"],
                      price: 14, rating: 4.6),
                Items(name: "Abraham Bohol",
                      image: "https://api.webdmitriev.com/wp-content/uploads/2025/07/boholano-house-06-04.jpg",
                      address: "Panglao Island",
                      addressShort: "Purok 5, Panglao Island Circumferencial Rd Brgy. Danao",
                      gallery: [
                        "https://api.webdmitriev.com/wp-content/uploads/2025/07/boholano-house-06-06.jpg",
                        "https://api.webdmitriev.com/wp-content/uploads/2025/07/boholano-house-06-04.jpg"
                      ],
                      descr: "Welcome to resort paradise we ensure the best service during your stay in bali with an emphasis on customer comfort. Enjoy Balinese specialties, dance and music every Saturday for free at competitive prices. You can enjoy all the facilities at our resort",
                      facilities: ["Airport shuttle", "Non-smoking rooms", "Free Wifi", "Free parking"],
                      price: 20, rating: 5.0),
                Items(name: "Panglao",
                      image: "https://api.webdmitriev.com/wp-content/uploads/2025/07/boholano-house-06-05.jpg",
                      address: "Barangay Danao, Panglao Island, Bohol, 6340",
                      addressShort: "Panglao Island",
                      gallery: [
                        "https://api.webdmitriev.com/wp-content/uploads/2025/07/boholano-house-06-11.jpg",
                        "https://api.webdmitriev.com/wp-content/uploads/2025/07/boholano-house-06-05.jpg"
                      ],
                      descr: "Welcome to resort paradise we ensure the best service during your stay in bali with an emphasis on customer comfort. Enjoy Balinese specialties, dance and music every Saturday for free at competitive prices. You can enjoy all the facilities at our resort",
                      facilities: ["2 swimming pools", "Non-smoking rooms", "Free Wifi", "Restaurant", "Family rooms", "Bar", "Good Breakfast"],
                      price: 19, rating: 4.6)
            ]),
            CollectionStruct(title: "Explore Place", action: true, type: .places, items: [
                Items(name: "Chocolate Hills",
                      image: "https://api.webdmitriev.com/wp-content/uploads/2025/09/chocolate-hills-01.jpg",
                      address: "Towns of Carmen, Batuan and Sagbayan, Bohol",
                      descr: "The Chocolate Hills offer a unique blend of relaxation and excitement. \nStroll along designated viewing areas to capture stunning photographs, or add an adventurous twist to your visit with an ATV ride around Chocolate Hills that lets you traverse the landscape in style. \n\nLocal guides provide fascinating insights into the formation of these hills and the cultural lore surrounding them, enhancing your overall experience. \n\nWhether you're a nature enthusiast or simply seeking a memorable day out, the Chocolate Hills in Bohol are a must-visit destination that promises to leave a lasting impression.",
                      price: 4, rating: 4.8, latitude: 9.91855, longitude: 124.09363),
                Items(name: "Carmen",
                      image: "https://api.webdmitriev.com/wp-content/uploads/2025/05/boholano-house-04-02.jpg",
                      address: "Barangay Danao, Panglao Island, Bohol, 6340",
                      descr: "Bohol, an enchanting island province in the Philippines, is renowned for its stunning natural landscapes and unique wildlife. \n\nOne of its most iconic attractions is the Chocolate Hills, a geological formation consisting of over 1,200 perfectly cone-shaped hills that turn brown during the dry season, resembling mounds of chocolate. This breathtaking sight is best appreciated from the viewing deck at Chocolate Hills Complex, where visitors can capture panoramic views and learn about the hills’ geological history. \n\nIn addition to the Chocolate Hills, Bohol is home to the world’s smallest primate, the Philippine Tarsier. These adorable creatures, with their large eyes and tiny bodies, can be observed in their natural habitat at the Tarsier Sanctuary in Corella. Here, conservation efforts are in place to protect these fascinating animals while providing visitors with the opportunity to learn about their behavior and ecology.",
                      price: 4, rating: 5.0, latitude: 9.84985, longitude: 124.17684),
                Items(name: "Bilar",
                      image: "https://api.webdmitriev.com/wp-content/uploads/2025/05/boholano-house-04-03.jpg",
                      address: "Barangay Danao, Panglao Island, Bohol, 6340",
                      descr: "Bohol, an enchanting island province in the Philippines, is renowned for its stunning natural landscapes and unique wildlife. \n\nOne of its most iconic attractions is the Chocolate Hills, a geological formation consisting of over 1,200 perfectly cone-shaped hills that turn brown during the dry season, resembling mounds of chocolate. This breathtaking sight is best appreciated from the viewing deck at Chocolate Hills Complex, where visitors can capture panoramic views and learn about the hills’ geological history. \n\nIn addition to the Chocolate Hills, Bohol is home to the world’s smallest primate, the Philippine Tarsier. These adorable creatures, with their large eyes and tiny bodies, can be observed in their natural habitat at the Tarsier Sanctuary in Corella. Here, conservation efforts are in place to protect these fascinating animals while providing visitors with the opportunity to learn about their behavior and ecology.",
                      price: 5, rating: 5.0),
                Items(name: "Panglao",
                      image: "https://api.webdmitriev.com/wp-content/uploads/2025/05/boholano-house-04-04.jpg",
                      address: "Barangay Danao, Panglao Island, Bohol, 6340",
                      descr: "Bohol, an enchanting island province in the Philippines, is renowned for its stunning natural landscapes and unique wildlife. \n\nOne of its most iconic attractions is the Chocolate Hills, a geological formation consisting of over 1,200 perfectly cone-shaped hills that turn brown during the dry season, resembling mounds of chocolate. This breathtaking sight is best appreciated from the viewing deck at Chocolate Hills Complex, where visitors can capture panoramic views and learn about the hills’ geological history. \n\nIn addition to the Chocolate Hills, Bohol is home to the world’s smallest primate, the Philippine Tarsier. These adorable creatures, with their large eyes and tiny bodies, can be observed in their natural habitat at the Tarsier Sanctuary in Corella. Here, conservation efforts are in place to protect these fascinating animals while providing visitors with the opportunity to learn about their behavior and ecology.",
                      price: 6, rating: 5.0),
                Items(name: "Tarsier",
                      image: "https://api.webdmitriev.com/wp-content/uploads/2025/05/boholano-house-04-05.jpg",
                      address: "Barangay Danao, Panglao Island, Bohol, 6340",
                      descr: "Bohol, an enchanting island province in the Philippines, is renowned for its stunning natural landscapes and unique wildlife. \n\nOne of its most iconic attractions is the Chocolate Hills, a geological formation consisting of over 1,200 perfectly cone-shaped hills that turn brown during the dry season, resembling mounds of chocolate. This breathtaking sight is best appreciated from the viewing deck at Chocolate Hills Complex, where visitors can capture panoramic views and learn about the hills’ geological history. \n\nIn addition to the Chocolate Hills, Bohol is home to the world’s smallest primate, the Philippine Tarsier. These adorable creatures, with their large eyes and tiny bodies, can be observed in their natural habitat at the Tarsier Sanctuary in Corella. Here, conservation efforts are in place to protect these fascinating animals while providing visitors with the opportunity to learn about their behavior and ecology.",
                      price: 7, rating: 5.0),
            ])
        ]
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
        case .pool: return "figure.pool.swim"       // SF Symbol
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
