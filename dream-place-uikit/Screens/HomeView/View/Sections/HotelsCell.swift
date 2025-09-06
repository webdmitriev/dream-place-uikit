//
//  HotelsCell.swift
//  dream-place-uikit
//
//  Created by Олег Дмитриев on 07.09.2025.
//

import UIKit

final class HotelsCell: UICollectionViewCell {
    static let reuseID = "HotelsCell"
    
    private let uiBuilder = UIBuilder()
    
    private lazy var stackView: UIStackView = uiBuilder.addStackHeader()
    
    private lazy var titleLabel: UILabel = uiBuilder.addLabel("Hotel Near You", fz: .header, fw: .medium, color: .appBlack, lines: 1)
    
    private lazy var headerBtn: UIButton = uiBuilder.addButton("View all", color: .appBlue, bgc: .clear)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    private func setupUI() {
        contentView.backgroundColor = .appWhite
        contentView.layer.cornerRadius = 24
        contentView.addSubviews(stackView)

        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(headerBtn)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
