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

struct CollectionStruct: Hashable {
    let title: String
    let action: Bool
    let type: SectionType
    let items: [Booking]
}
