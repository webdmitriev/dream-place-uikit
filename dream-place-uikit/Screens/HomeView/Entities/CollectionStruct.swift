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
                      addressShort: "Barangay Trinidad 6310, Philippines", price: 18, rating: 4.8),
                Items(name: "Calape Bohol",
                      image: "https://api.webdmitriev.com/wp-content/uploads/2025/07/boholano-house-06-02.jpg",
                      addressShort: "Pangangan Island, Calape, 6328 Bohol", price: 24, rating: 4.5),
                Items(name: "Bohol",
                      image: "https://api.webdmitriev.com/wp-content/uploads/2025/07/boholano-house-06-03.jpg",
                      addressShort: "Barangay Danao, Panglao Island, Bohol, 6340", price: 14, rating: 4.6),
                Items(name: "Abraham Bohol",
                      image: "https://api.webdmitriev.com/wp-content/uploads/2025/07/boholano-house-06-04.jpg",
                      addressShort: "Purok 5, Panglao Island Circumferencial Rd Brgy. Danao", price: 20, rating: 5.0),
                Items(name: "Panglao",
                      image: "https://api.webdmitriev.com/wp-content/uploads/2025/07/boholano-house-06-05.jpg",
                      addressShort: "Barangay Danao, Panglao Island, Bohol, 6340", price: 19, rating: 4.6)
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
