//
//  UIBuilder.swift
//  dream-place-uikit
//
//  Created by Олег Дмитриев on 27.08.2025.
//

import UIKit

final class UIBuilder {
    
    enum FontSize: CGFloat {
        case onboardingTitle = 32
        case header = 22
        case title = 20
        case text = 16
        case btn = 15
        case label = 12
    }
    
    let offset: CGFloat = 16
    let cornerRadius12: CGFloat = 12
    let cornerRadiusStandart: CGFloat = 32
    
    func addOnboardingImage(_ img: String) -> UIImageView {
        let imageView = UIImageView(image: UIImage(named: img))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }
    
    func addLabel(_ str: String, fz: FontSize = .text, fw: UIFont.Weight = .regular,
                  color: UIColor = .appBlack, lines: Int = 0, align: NSTextAlignment = .left) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = str
        label.font = .systemFont(ofSize: fz.rawValue, weight: fw)
        label.numberOfLines = lines
        label.textAlignment = align
        label.textColor = color
        return label
    }
    
    func addButton(_ text: String, color: UIColor = .appWhite, bgc: UIColor = .appBlue) -> UIButton {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 48).isActive = true
        button.setTitle(text, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: FontSize.btn.rawValue, weight: .medium)
        button.setTitleColor(color, for: .normal)
        button.backgroundColor = bgc
        button.layer.cornerRadius = cornerRadius12
        return button
    }
    
    func addButtonImage(_ img: String, system: Bool = true, width: CGFloat = 48, height: CGFloat = 48, tint: UIColor = .appGrayText) -> UIButton {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalToConstant: width).isActive = true
        button.heightAnchor.constraint(equalToConstant: height).isActive = true
        
        button.setImage(system ? UIImage(systemName: img) : UIImage(named: img), for: .normal)

        button.tintColor = system ? tint : .white
        return button
    }
    
    func addScrollView(bgc: UIColor) -> UIScrollView {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.contentInsetAdjustmentBehavior = .never
        scroll.alwaysBounceVertical = false
        scroll.backgroundColor = bgc
        return scroll
    }
    
    func addView(bgc: UIColor, brs: CGFloat = 0, clipsToBounds: Bool = true) -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = bgc
        view.layer.cornerRadius = brs
        view.clipsToBounds = clipsToBounds
        return view
    }
    
    func addSearchBar(_ placeholder: String = "", height: CGFloat = 48, color: UIColor = .appGrayText, bgc: UIColor = .appWhite) -> UITextField {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.heightAnchor.constraint(equalToConstant: height).isActive = true
        
        textField.placeholder = placeholder

        textField.textColor = color
        textField.backgroundColor = bgc
        textField.layer.cornerRadius = height / 2
        textField.addPaddingToTextField()
        
        return textField
    }
    
    func addStackHeader() -> UIStackView {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.spacing = 16
        return stack
    }
    
}
