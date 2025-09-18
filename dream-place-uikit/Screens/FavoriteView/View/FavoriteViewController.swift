//
//  FavoriteViewController.swift
//  dream-place-uikit
//
//  Created by Олег Дмитриев on 27.08.2025.
//

import UIKit

final class FavoriteViewController: UIViewController {
    
    // MARK: - Properties
    private let uiBuilder = UIBuilder()
    private let bookingFavorites = CoreDataManager.shared.fetchFavorites()
    
    // UI элементы
    private lazy var scrollView: UIScrollView = uiBuilder.addScrollView(bgc: .clear)
    private lazy var contentView: UIView = uiBuilder.addView(clipsToBounds: false)
    
    private lazy var descrLabel: UILabel = uiBuilder.addLabel(
        "Bohol",
        fz: .text, color: .appBlack, lines: 0
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .appBg
        
        setupUI()
        print(bookingFavorites.count)
    }
    
    // MARK: - Setup UI
    private func setupUI() {
        view.addSubview(scrollView)
        
        scrollView.addSubview(contentView)
        
        contentView.addSubview(descrLabel)
        
        // scrollView + contentView constraints
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            descrLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            descrLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: uiBuilder.offset),
            descrLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -uiBuilder.offset),
            

            descrLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0)
        ])
    }
    
}
