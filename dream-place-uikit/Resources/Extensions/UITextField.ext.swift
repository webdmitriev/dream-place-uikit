//
//  UITextField.ext.swift
//  dream-place-uikit
//
//  Created by Олег Дмитриев on 03.09.2025.
//

import UIKit

extension UITextField {
    func addPaddingToTextField(x: CGFloat = 24, y: CGFloat = 13) {
        let paddingView: UIView = UIView.init(frame: CGRectMake(0, 0, x, y))
        self.leftView = paddingView;
        self.leftViewMode = .always;
        self.rightView = UIView.init(frame: CGRectMake(0, 0, x + 40, y));
        self.rightViewMode = .always;
    }
}
