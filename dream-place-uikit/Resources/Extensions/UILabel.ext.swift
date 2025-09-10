//
//  UILabel.ext.swift
//  dream-place-uikit
//
//  Created by Олег Дмитриев on 08.09.2025.
//

import UIKit

extension UILabel {
    func setPriceText(price: Int, subtitle: String, priceFZ: CGFloat = 15, color: UIColor = .appWhite) {
        let fullText = NSMutableAttributedString(
            string: "$\(price)",
            attributes: [
                .font: UIFont.systemFont(ofSize: priceFZ, weight: .bold),
                .foregroundColor: color
            ]
        )
        
        fullText.append(NSAttributedString(
            string: "\(subtitle)",
            attributes: [
                .font: UIFont.systemFont(ofSize: 14, weight: .regular),
                .foregroundColor: color
            ]
        ))
        
        self.attributedText = fullText
    }
}

