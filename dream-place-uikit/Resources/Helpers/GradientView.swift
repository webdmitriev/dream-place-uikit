//
//  GradientView.swift
//  dream-place-uikit
//
//  Created by Олег Дмитриев on 08.09.2025.
//

import UIKit

final class GradientView: UIView {
    private let gradientLayer = CAGradientLayer()

    init(colors: [UIColor] = [.black.withAlphaComponent(0.6), .clear],
         startPoint: CGPoint = CGPoint(x: 0.5, y: 1.0),
         endPoint: CGPoint = CGPoint(x: 0.5, y: 0.0)) {
        super.init(frame: .zero)

        gradientLayer.colors = colors.map { $0.cgColor }
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint

        layer.insertSublayer(gradientLayer, at: 0)
        backgroundColor = .clear
        isUserInteractionEnabled = false  // чтобы не перекрывал клики
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }
}
