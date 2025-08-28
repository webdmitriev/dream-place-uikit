//
//  Hotel.swift
//  dream-place-uikit
//
//  Created by Олег Дмитриев on 28.08.2025.
//

import Foundation

struct Hotel: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let address: String
    let price: Double
    let rating: Double
}
