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
}
