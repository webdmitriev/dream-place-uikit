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
    
    // UI элементы
    private lazy var scrollView: UIScrollView = uiBuilder.addScrollView(bgc: .clear)
    private lazy var contentView: UIView = uiBuilder.addView(clipsToBounds: false)
    
    private lazy var descrLabel: UILabel = uiBuilder.addLabel(
        "Bohol, an enchanting island province in the Philippines, is renowned for its stunning natural landscapes and unique wildlife. \n\nOne of its most iconic attractions is the Chocolate Hills, a geological formation consisting of over 1,200 perfectly cone-shaped hills that turn brown during the dry season, resembling mounds of chocolate. This breathtaking sight is best appreciated from the viewing deck at Chocolate Hills Complex, where visitors can capture panoramic views and learn about the hills’ geological history. \n\nIn addition to the Chocolate Hills, Bohol is home to the world’s smallest primate, the Philippine Tarsier. These adorable creatures, with their large eyes and tiny bodies, can be observed in their natural habitat at the Tarsier Sanctuary in Corella. Here, conservation efforts are in place to protect these fascinating animals while providing visitors with the opportunity to learn about their behavior and ecology. Bohol, an enchanting island province in the Philippines, is renowned for its stunning natural landscapes and unique wildlife. \n\nOne of its most iconic attractions is the Chocolate Hills, a geological formation consisting of over 1,200 perfectly cone-shaped hills that turn brown during the dry season, resembling mounds of chocolate. This breathtaking sight is best appreciated from the viewing deck at Chocolate Hills Complex, where visitors can capture panoramic views and learn about the hills’ geological history. \n\nIn addition to the Chocolate Hills, Bohol is home to the world’s smallest primate, the Philippine Tarsier. These adorable creatures, with their large eyes and tiny bodies, can be observed in their natural habitat at the Tarsier Sanctuary in Corella. Here, conservation efforts are in place to protect these fascinating animals while providing visitors with the opportunity to learn about their behavior and ecology. Bohol, an enchanting island province in the Philippines, is renowned for its stunning natural landscapes and unique wildlife. \n\nOne of its most iconic attractions is the Chocolate Hills, a geological formation consisting of over 1,200 perfectly cone-shaped hills that turn brown during the dry season, resembling mounds of chocolate. This breathtaking sight is best appreciated from the viewing deck at Chocolate Hills Complex, where visitors can capture panoramic views and learn about the hills’ geological history. \n\nIn addition to the Chocolate Hills, Bohol is home to the world’s smallest primate, the Philippine Tarsier. These adorable creatures, with their large eyes and tiny bodies, can be observed in their natural habitat at the Tarsier Sanctuary in Corella. Here, conservation efforts are in place to protect these fascinating animals while providing visitors with the opportunity to learn about their behavior and ecology. Bohol, an enchanting island province in the Philippines, is renowned for its stunning natural landscapes and unique wildlife. \n\nOne of its most iconic attractions is the Chocolate Hills, a geological formation consisting of over 1,200 perfectly cone-shaped hills that turn brown during the dry season, resembling mounds of chocolate. This breathtaking sight is best appreciated from the viewing deck at Chocolate Hills Complex, where visitors can capture panoramic views and learn about the hills’ geological history. \n\nIn addition to the Chocolate Hills, Bohol is home to the world’s smallest primate, the Philippine Tarsier. These adorable creatures, with their large eyes and tiny bodies, can be observed in their natural habitat at the Tarsier Sanctuary in Corella. Here, conservation efforts are in place to protect these fascinating animals while providing visitors with the opportunity to learn about their behavior and ecology. Bohol, an enchanting island province in the Philippines, is renowned for its stunning natural landscapes and unique wildlife. \n\nOne of its most iconic attractions is the Chocolate Hills, a geological formation consisting of over 1,200 perfectly cone-shaped hills that turn brown during the dry season, resembling mounds of chocolate. This breathtaking sight is best appreciated from the viewing deck at Chocolate Hills Complex, where visitors can capture panoramic views and learn about the hills’ geological history. \n\nIn addition to the Chocolate Hills, Bohol is home to the world’s smallest primate, the Philippine Tarsier. These adorable creatures, with their large eyes and tiny bodies, can be observed in their natural habitat at the Tarsier Sanctuary in Corella. Here, conservation efforts are in place to protect these fascinating animals while providing visitors with the opportunity to learn about their behavior and ecology. Bohol, an enchanting island province in the Philippines, is renowned for its stunning natural landscapes and unique wildlife. \n\nOne of its most iconic attractions is the Chocolate Hills, a geological formation consisting of over 1,200 perfectly cone-shaped hills that turn brown during the dry season, resembling mounds of chocolate. This breathtaking sight is best appreciated from the viewing deck at Chocolate Hills Complex, where visitors can capture panoramic views and learn about the hills’ geological history. \n\nIn addition to the Chocolate Hills, Bohol is home to the world’s smallest primate, the Philippine Tarsier. These adorable creatures, with their large eyes and tiny bodies, can be observed in their natural habitat at the Tarsier Sanctuary in Corella. Here, conservation efforts are in place to protect these fascinating animals while providing visitors with the opportunity to learn about their behavior and ecology. Bohol, an enchanting island province in the Philippines, is renowned for its stunning natural landscapes and unique wildlife. \n\nOne of its most iconic attractions is the Chocolate Hills, a geological formation consisting of over 1,200 perfectly cone-shaped hills that turn brown during the dry season, resembling mounds of chocolate. This breathtaking sight is best appreciated from the viewing deck at Chocolate Hills Complex, where visitors can capture panoramic views and learn about the hills’ geological history. \n\nIn addition to the Chocolate Hills, Bohol is home to the world’s smallest primate, the Philippine Tarsier. These adorable creatures, with their large eyes and tiny bodies, can be observed in their natural habitat at the Tarsier Sanctuary in Corella. Here, conservation efforts are in place to protect these fascinating animals while providing visitors with the opportunity to learn about their behavior and ecology.",
        fz: .text, color: .appBlack, lines: 0
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .appBg
        
        setupUI()
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
