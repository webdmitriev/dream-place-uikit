//
//  HeaderCell.swift
//  dream-place-uikit
//
//  Created by Олег Дмитриев on 07.09.2025.
//

import UIKit

final class HeaderCell: UICollectionViewCell {
    static let reuseID = "HeaderCell"
    
    private let uiBuilder = UIBuilder()
    
    private lazy var homeHeaderView: UIView = uiBuilder.addView(bgc: .clear, clipsToBounds: false)

    private lazy var homeHeaderLabel: UILabel = uiBuilder.addLabel("Current Location", fz: .label, fw: .medium,
                                                           color: .appWhite, lines: 1)

    private lazy var homeHeaderLocation: UILabel = uiBuilder.addLabel("Bohol, Philippines (PH)", fz: .text, fw: .medium,
                                                              color: .appWhite, lines: 1)

    private lazy var homeHeaderNotification: UIButton = uiBuilder.addButtonImage("btn-notification", system: false,
                                                                         width: 40, height: 40)

    private lazy var homeHeaderNotificationBalloon: UIView = uiBuilder.addView(bgc: .clear)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    private func setupUI() {
        contentView.addSubview(homeHeaderView)
        homeHeaderView.addSubviews(homeHeaderLabel, homeHeaderLocation, homeHeaderNotification, homeHeaderNotificationBalloon)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            homeHeaderView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            homeHeaderView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: uiBuilder.offset),
            homeHeaderView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -uiBuilder.offset),

            homeHeaderLabel.topAnchor.constraint(equalTo: homeHeaderView.topAnchor, constant: 0),
            homeHeaderLabel.leadingAnchor.constraint(equalTo: homeHeaderView.leadingAnchor, constant: 0),
            homeHeaderLabel.trailingAnchor.constraint(equalTo: homeHeaderNotification.leadingAnchor, constant: -20),

            homeHeaderLocation.topAnchor.constraint(equalTo: homeHeaderLabel.bottomAnchor, constant: 4),
            homeHeaderLocation.leadingAnchor.constraint(equalTo: homeHeaderView.leadingAnchor, constant: 0),
            homeHeaderLocation.trailingAnchor.constraint(equalTo: homeHeaderNotification.leadingAnchor, constant: -20),

            homeHeaderNotification.topAnchor.constraint(equalTo: homeHeaderView.topAnchor, constant: 0),
            homeHeaderNotification.trailingAnchor.constraint(equalTo: homeHeaderView.trailingAnchor, constant: 0),

            homeHeaderNotificationBalloon.topAnchor.constraint(equalTo: homeHeaderNotification.topAnchor, constant: 8),
            homeHeaderNotificationBalloon.trailingAnchor.constraint(equalTo: homeHeaderNotification.trailingAnchor, constant: -8),

            homeHeaderView.bottomAnchor.constraint(equalTo: homeHeaderNotification.bottomAnchor, constant: 0)
        ])
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}
