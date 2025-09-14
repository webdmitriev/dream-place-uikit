//
//  UILabel.ext.swift
//  dream-place-uikit
//
//  Created by Олег Дмитриев on 08.09.2025.
//

import UIKit

extension UILabel {
    func setPriceText(price: Int, subtitle: String, priceFZ: CGFloat = 15, textFZ: CGFloat = 14, color: UIColor = .appWhite) {
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
                .font: UIFont.systemFont(ofSize: textFZ, weight: .regular),
                .foregroundColor: color
            ]
        ))
        
        self.attributedText = fullText
    }
    
    func setBoldText(bold: String, text: String, boldFZ: CGFloat = 16, textFZ: CGFloat = 14, color: UIColor = .appWhite) {
        let fullText = NSMutableAttributedString(
            string: "\(bold) ",
            attributes: [
                .font: UIFont.systemFont(ofSize: boldFZ, weight: .bold),
                .foregroundColor: color
            ]
        )
        
        fullText.append(NSAttributedString(
            string: "\(text)",
            attributes: [
                .font: UIFont.systemFont(ofSize: textFZ, weight: .regular),
                .foregroundColor: color
            ]
        ))
        
        self.attributedText = fullText
    }
    
    func setLineHeight(_ lineHeight: CGFloat, lineSpacing: CGFloat = 0) {
        guard let labelText = self.text else { return }
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.minimumLineHeight = lineHeight
        paragraphStyle.maximumLineHeight = lineHeight
        paragraphStyle.lineSpacing = lineSpacing
        paragraphStyle.alignment = self.textAlignment

        let attributedString = NSMutableAttributedString(
            string: labelText,
            attributes: [
                .paragraphStyle: paragraphStyle,
                .font: self.font as Any
            ]
        )
        
        self.attributedText = attributedString
    }
}

