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
    
    private lazy var cellImage: UIImageView = uiBuilder.addImage("post-01", mode: .scaleAspectFill)
    private lazy var cellGradient = GradientView(
        colors: [
            UIColor.appBlack.withAlphaComponent(0.9),
            UIColor.clear
        ],
        startPoint: CGPoint(x: 0.5, y: 1.0),
        endPoint: CGPoint(x: 0.5, y: 0.0)
    )
    private lazy var cellTitle: UILabel = uiBuilder.addLabel("Title", fz: .text, fw: .bold, color: .appWhite, lines: 1)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    private func setupUI() {
        contentView.backgroundColor = .appRed.withAlphaComponent(0.1)
        contentView.layer.cornerRadius = 20
        contentView.clipsToBounds = true
        
        cellGradient.translatesAutoresizingMaskIntoConstraints = false
        cellImage.addSubview(cellGradient)
        
        cellTitle.textAlignment = .center
        
        contentView.addSubviews(cellImage, cellTitle)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            cellImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            cellImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cellImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            cellImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            cellGradient.leadingAnchor.constraint(equalTo: cellImage.leadingAnchor),
            cellGradient.trailingAnchor.constraint(equalTo: cellImage.trailingAnchor),
            cellGradient.bottomAnchor.constraint(equalTo: cellImage.bottomAnchor),
            cellGradient.heightAnchor.constraint(equalTo: cellImage.heightAnchor, multiplier: 0.7),
            
            cellTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            cellTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            cellTitle.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(item: Items) {
        self.cellTitle.text = item.name
        
        if let imageString = item.image, let url = URL(string: imageString) {
            self.cellImage.load(url: url)
        } else {
            self.cellImage.image = UIImage(named: "post-01")
        }
    }
}
