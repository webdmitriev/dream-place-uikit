//
//  PlacesCell.swift
//  dream-place-uikit
//
//  Created by Олег Дмитриев on 08.09.2025.
//

import UIKit

final class PlacesCell: UICollectionViewCell {
    static let reuseID = "PlacesCell"
    
    private let uiBuilder = UIBuilder()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    private func setupUI() {
        contentView.backgroundColor = .appRed.withAlphaComponent(0.1)
        contentView.layer.cornerRadius = 20
        contentView.clipsToBounds = true
        
        setupConstraints()
    }
    
    private func setupConstraints() {
//        NSLayoutConstraint.activate([
////
//        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(item: Items) {
//        self.cellTitle.text = item.name
//        
//        if let imageString = item.image, let url = URL(string: imageString) {
//            self.cellImage.load(url: url)
//        } else {
//            self.cellImage.image = UIImage(named: "post-01")
//        }
//        
//        self.cellPrice.setPriceText(price: item.price ?? 0, subtitle: "/night")
//        self.cellAddress.text = item.addressShort ?? ""
//        self.cellRating.text = "⭐️ \(item.rating ?? 0)"
    }
}
