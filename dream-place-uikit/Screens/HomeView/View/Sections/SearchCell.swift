//
//  SearchCell.swift
//  dream-place-uikit
//
//  Created by Олег Дмитриев on 07.09.2025.
//

import UIKit

final class SearchCell: UICollectionViewCell {
    static let reuseID = "SearchCell"
    
    private let uiBuilder = UIBuilder()
    
    private lazy var searchBar: UITextField = uiBuilder.addSearchBar("Look for homestay")

    private lazy var searchBarBtn: UIButton = uiBuilder.addButtonImage("magnifyingglass",
                                                                       width: 32, height: 32, tint: .appGrayText)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    private func setupUI() {
        contentView.addSubviews(searchBar, searchBarBtn)
        
        searchBarBtn.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            searchBar.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: uiBuilder.offset),
            searchBar.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -uiBuilder.offset),
            searchBar.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24),

            searchBarBtn.centerYAnchor.constraint(equalTo: searchBar.centerYAnchor),
            searchBarBtn.trailingAnchor.constraint(equalTo: searchBar.trailingAnchor, constant: -18),
        ])
    }
    
    @objc
    private func searchButtonTapped() {
        print("searchButtonTapped")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
