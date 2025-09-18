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

enum SectionItem: Hashable {
    case booking(Booking)
    case places(Places)
}

struct CollectionStruct: Hashable {
    let title: String
    let action: Bool
    let type: SectionType
    let items: [SectionItem]
}
