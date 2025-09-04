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
}

struct Items: Hashable, Identifiable {
    let id = UUID()
    let name: String
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
            CollectionStruct(title: "Search", action: true, type: .search, items: [
                Items(name: "Search")
            ]),
            CollectionStruct(title: "Hotels", action: false, type: .hotels, items: [
                Items(name: "Hotel 1"),
                Items(name: "Hotel 2"),
                Items(name: "Hotel 3"),
            ])
        ]
    }
}
