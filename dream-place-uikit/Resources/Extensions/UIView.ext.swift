//
//  UIView.ext.swift
//  dream-place-uikit
//
//  Created by Олег Дмитриев on 03.09.2025.
//

import UIKit

extension UIView {
    func addSubviews(_ subviews: UIView...) {
        subviews.forEach { addSubview($0) }
    }
    
    func applyShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.12
        layer.shadowOffset = CGSize(width: 4, height: 0)
        layer.shadowRadius = 16 / 2
        layer.masksToBounds = false
    }
}
