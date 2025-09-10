//
//  CollectionStruct.swift
//  dream-place-uikit
//
//  Created by Олег Дмитриев on 04.09.2025.
//

import Foundation

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
                      descr: "Welcome to resort paradise we ensure the best service during your stay in bali with an emphasis on customer comfort. Enjoy Balinese specialties, dance and music every Saturday for free at competitive prices. You can enjoy all the facilities at our resort",
                      facilities: ["Outdoor swimming pool", "Airport shuttle", "Non-smoking rooms", "Free Wifi", "Restaurant", "Room service", "Free parking", "Family rooms", "Bar"],
                      price: 18, rating: 4.8),
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
                Items(name: "Bohol",
                      image: "https://api.webdmitriev.com/wp-content/uploads/2025/05/boholano-house-04-01.jpg"),
                Items(name: "Chocolate Hills Chocolate Hills Chocolate Hills",
                      image: "https://api.webdmitriev.com/wp-content/uploads/2025/05/boholano-house-04-02.jpg"),
                Items(name: "Bilar",
                      image: "https://api.webdmitriev.com/wp-content/uploads/2025/05/boholano-house-04-03.jpg"),
                Items(name: "Panglao",
                      image: "https://api.webdmitriev.com/wp-content/uploads/2025/05/boholano-house-04-04.jpg"),
                Items(name: "Tarsier",
                      image: "https://api.webdmitriev.com/wp-content/uploads/2025/05/boholano-house-04-05.jpg"),
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
