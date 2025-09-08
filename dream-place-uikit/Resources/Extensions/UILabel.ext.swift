//
//  UILabel.ext.swift
//  dream-place-uikit
//
//  Created by Олег Дмитриев on 08.09.2025.
//

import UIKit

extension UILabel {
    func setPriceText(price: Int, subtitle: String) {
        let fullText = NSMutableAttributedString(
            string: "$\(price)",
            attributes: [
                .font: UIFont.systemFont(ofSize: 15, weight: .bold),
                .foregroundColor: UIColor.appWhite
            ]
        )
        
        fullText.append(NSAttributedString(
            string: "\(subtitle)",
            attributes: [
                .font: UIFont.systemFont(ofSize: 14, weight: .regular),
                .foregroundColor: UIColor.appWhite
            ]
        ))
        
        self.attributedText = fullText
    }
}

