//
//  CollectionDiffableHeader.swift
//  dream-place-uikit
//
//  Created by Олег Дмитриев on 04.09.2025.
//

import UIKit

class CollectionDiffableHeader: UICollectionReusableView {
    static let reuseID: String = "CollectionDiffableHeader"
    
    lazy var titleCell: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "Header"
        $0.font = .systemFont(ofSize: 24, weight: .bold)
        $0.textColor = .black
        
        return $0
    }(UILabel())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(titleCell)
        NSLayoutConstraint.activate([
            titleCell.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            titleCell.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            titleCell.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
        ])
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Methods
    func actionCell(isHide: Bool) {
        self.titleCell.isHidden = !isHide
    }
}
