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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    private func setupUI() {
        contentView.backgroundColor = .appWhite
        //contentView.addSubviews(stackView)
        
        setupConstraints()
    }
    
    private func setupConstraints() {

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
