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
    
    func addButton(_ text: String) -> UIButton {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 48).isActive = true
        button.setTitle(text, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: FontSize.btn.rawValue, weight: .medium)
        button.setTitleColor(.appWhite, for: .normal)
        button.backgroundColor = .appBlue
        button.layer.cornerRadius = cornerRadius12
        return button
    }
    
}
