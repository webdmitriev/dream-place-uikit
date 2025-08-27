//
//  FontManager.swift
//  dream-place-uikit
//
//  Created by Олег Дмитриев on 27.08.2025.
//

import UIKit

enum FontManager: String {
    case mRegular = "Montserrat-Regular"
    case mBold = "Montserrat-Bold"
}

extension UIFont {
    static func montserrat(_ name: FontManager, _ size: CGFloat = 16) -> UIFont? {
        return UIFont(name: name.rawValue, size: size)
    }
}
