//
//  BookingCell.swift
//  dream-place-uikit
//
//  Created by Олег Дмитриев on 16.09.2025.
//

import UIKit

final class BookingCell: UITableViewCell {
    
    // MARK: - Properties
    static let reuseID = "BookingCell"
    private let uiBuilder = UIBuilder()
    
    // UI элементы
    private lazy var cellView: UIView = uiBuilder.addView(bgc: .clear, clipsToBounds: true)
    private lazy var cellThumbnail: UIImageView = uiBuilder.addImage("default-bg", mode: .scaleAspectFill)
    private lazy var cellTitle: UILabel = uiBuilder.addLabel("", fz: .cellTitle, lines: 2)
    
    private lazy var cellRatingView: UIView = uiBuilder.addView(bgc: .appBg, clipsToBounds: true)
    private lazy var cellRating: UILabel = uiBuilder.addLabel("", fz: .label, color: .appBlack, lines: 1, align: .center)
    
    private lazy var cellPrice: UILabel = uiBuilder.addLabel("", lines: 1)
    private lazy var cellAddress: UILabel = uiBuilder.addLabel("", lines: 1, align: .right)
    

    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Setup UI
    private func setupUI() {
        contentView.addSubview(cellView)
        contentView.backgroundColor = .appBg
        
        cellView.addSubviews(cellThumbnail, cellTitle, cellRatingView, cellPrice, cellAddress)
        cellView.backgroundColor = .appWhite
        cellView.layer.cornerRadius = 8
        
        cellThumbnail.layer.cornerRadius = 6
        
        cellRatingView.addSubview(cellRating)
        cellRatingView.layer.cornerRadius = 6
        
        NSLayoutConstraint.activate([
            cellView.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            cellView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            cellView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            cellView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4),
            
            cellThumbnail.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 10),
            cellThumbnail.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 10),
            cellThumbnail.bottomAnchor.constraint(equalTo: cellView.bottomAnchor, constant: -10),
            cellThumbnail.widthAnchor.constraint(equalToConstant: 88),
            
            cellTitle.topAnchor.constraint(equalTo: cellThumbnail.topAnchor, constant: 4),
            cellTitle.leadingAnchor.constraint(equalTo: cellThumbnail.trailingAnchor, constant: 12),
            cellTitle.trailingAnchor.constraint(equalTo: cellRatingView.leadingAnchor, constant: -8),
            
            cellRatingView.widthAnchor.constraint(equalToConstant: 52),
            cellRatingView.heightAnchor.constraint(equalToConstant: 22),
            cellRatingView.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 12),
            cellRatingView.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -10),
            
            cellRating.centerYAnchor.constraint(equalTo: cellRatingView.centerYAnchor, constant: 0),
            cellRating.centerXAnchor.constraint(equalTo: cellRatingView.centerXAnchor, constant: 0),
            
            cellPrice.bottomAnchor.constraint(equalTo: cellThumbnail.bottomAnchor, constant: -4),
            cellPrice.leadingAnchor.constraint(equalTo: cellThumbnail.trailingAnchor, constant: 12),
            cellPrice.trailingAnchor.constraint(equalTo: cellAddress.leadingAnchor, constant: -8),
            
            cellAddress.bottomAnchor.constraint(equalTo: cellThumbnail.bottomAnchor, constant: -4),
            cellAddress.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -10),
        ])
    }
    
    func configuration(item: Booking) {
        if let imageString = item.image, let url = URL(string: imageString) {
            self.cellThumbnail.load(url: url)
        } else {
            self.cellThumbnail.image = UIImage(named: "default-bg")
        }
        
        self.cellTitle.text = "\(item.name)"

        if let rating = item.rating {
            self.cellRating.text = "⭐️ \(rating)"
        }
        
        if let price = item.price {
            self.cellPrice.setPriceText(price: price, subtitle: " /night", priceFZ: 20, textFZ: 16, color: .appBlack)
        }
        
        if let address = item.addressShort {
            self.cellAddress.text = address
        }
    }
    
}
