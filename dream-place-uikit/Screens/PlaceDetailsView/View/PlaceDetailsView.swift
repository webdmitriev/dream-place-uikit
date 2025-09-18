//
//  PlaceDetailsView.swift
//  dream-place-uikit
//
//  Created by Олег Дмитриев on 08.09.2025.
//

import UIKit
import CoreLocation

final class PlaceDetailsView: UIViewController {

    // MARK: - Properties
    private let item: Places
    private let uiBuilder = UIBuilder()
    private let height: CGFloat = UIScreen.main.bounds.height

    private lazy var latitude: Double = 0
    private lazy var longitude: Double = 0

    // UI элементы
    private lazy var scrollView: UIScrollView = uiBuilder.addScrollView(bgc: .clear)
    private lazy var contentView: UIView = uiBuilder.addView(clipsToBounds: false)
    private lazy var imageView: UIImageView = uiBuilder.addImage("default-bg", mode: .scaleAspectFill)
    private lazy var cellGradient = GradientView(
        colors: [
            UIColor.appBlack.withAlphaComponent(0.7),
            UIColor.clear
        ],
        startPoint: CGPoint(x: 0.5, y: 1.0),
        endPoint: CGPoint(x: 0.5, y: 0.0)
    )

    private lazy var titleLabel: UILabel = uiBuilder.addLabel("Title", fz: .placeTitle, fw: .bold, color: .appWhite, lines: 2)
    private lazy var ratingLabel: UILabel = uiBuilder.addLabel("⭐️ 4.8", fz: .text, color: .appWhite, lines: 1, align: .right)
    
    private lazy var addressImage: UIImageView = uiBuilder.addImage("icon-location", mode: .scaleAspectFit)
    private lazy var addressBtn: UIButton = uiBuilder.addButton("Address", height: false, bgc: .clear)
    
    private lazy var avatarsView: UIView = uiBuilder.addView(bgc: .clear)
    private lazy var avatar01: UIImageView = uiBuilder.addImage("avatar-01", mode: .scaleAspectFill)
    private lazy var avatar02: UIImageView = uiBuilder.addImage("avatar-02", mode: .scaleAspectFill)
    private lazy var avatar03: UIImageView = uiBuilder.addImage("avatar-03", mode: .scaleAspectFill)
    private lazy var avatar04: UIImageView = uiBuilder.addImage("avatar-04", mode: .scaleAspectFill)
    private lazy var avatar05: UIImageView = uiBuilder.addImage("avatar-05", mode: .scaleAspectFill)
    
    private lazy var avatarText: UILabel = uiBuilder.addLabel("", lines: 1)
    
    private lazy var descrLabel: UILabel = uiBuilder.addLabel("", fz: .text, color: .appWhite, lines: 0)
    
    // MARK: - Bottom block
    private lazy var bottomBlock: UIView = uiBuilder.addView(bgc: .clear, clipsToBounds: true)
    private lazy var btnBookNow: UIButton = uiBuilder.addButton("Explore", height: false, color: .appWhite, bgc: .appBlue)
    private lazy var bottomPrice: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setPriceText(price: 0, subtitle: "/person", priceFZ: 24, textFZ: 18)
        return $0
    }(UILabel())

    // MARK: - Init
    init(item: Places) {
        self.item = item
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        configureUI()
        
        setupCustomBackButton()
        setupTransparentNavigationBar()
    }

    // MARK: - Setup UI
    private func setupUI() {
        view.backgroundColor = .appBg
        view.addSubviews(imageView, scrollView, bottomBlock)

        imageView.addSubview(cellGradient)
        scrollView.addSubview(contentView)
        
        contentView.addSubviews(titleLabel, ratingLabel, addressImage, addressBtn, avatarsView, descrLabel)
        
        addressImage.widthAnchor.constraint(equalToConstant: 18).isActive = true
        addressImage.heightAnchor.constraint(equalToConstant: 18).isActive = true
        addressBtn.contentHorizontalAlignment = .left
        addressBtn.addTarget(self, action: #selector(handleAddressBtnTapped), for: .touchUpInside)
        
        avatarsView.addSubviews(avatar01, avatar02, avatar03, avatar04, avatar05, avatarText)
        [avatar01, avatar02, avatar03, avatar04, avatar05].forEach {
            $0.widthAnchor.constraint(equalToConstant: 28).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 28).isActive = true
            $0.layer.borderWidth = 2
            $0.layer.borderColor = UIColor.appWhite.cgColor
            $0.layer.cornerRadius = 14
        }
        
        // scrollView + contentView constraints
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),

            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])

        // imageView
        cellGradient.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            cellGradient.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            cellGradient.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
            cellGradient.bottomAnchor.constraint(equalTo: imageView.bottomAnchor),
            cellGradient.heightAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: 0.9),
        ])

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: height / 2),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: uiBuilder.offset),
            titleLabel.trailingAnchor.constraint(equalTo: ratingLabel.leadingAnchor, constant: -uiBuilder.offset),
            
            ratingLabel.widthAnchor.constraint(equalToConstant: 70),
            ratingLabel.bottomAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            ratingLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -uiBuilder.offset),
            
            addressImage.centerYAnchor.constraint(equalTo: addressBtn.centerYAnchor),
            addressImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: uiBuilder.offset),
            
            addressBtn.heightAnchor.constraint(equalToConstant: 28),
            addressBtn.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            addressBtn.leadingAnchor.constraint(equalTo: addressImage.trailingAnchor, constant: 8),
            addressBtn.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -uiBuilder.offset),
            
            avatarsView.topAnchor.constraint(equalTo: addressBtn.bottomAnchor, constant: 16),
            avatarsView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: uiBuilder.offset),
            avatarsView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -uiBuilder.offset),
            avatarsView.bottomAnchor.constraint(equalTo: avatar01.bottomAnchor),
            
            avatar01.topAnchor.constraint(equalTo: avatarsView.topAnchor),
            avatar01.leadingAnchor.constraint(equalTo: avatarsView.leadingAnchor),
            
            avatar02.topAnchor.constraint(equalTo: avatarsView.topAnchor),
            avatar02.leadingAnchor.constraint(equalTo: avatarsView.leadingAnchor, constant: 16),
            
            avatar03.topAnchor.constraint(equalTo: avatarsView.topAnchor),
            avatar03.leadingAnchor.constraint(equalTo: avatarsView.leadingAnchor, constant: 32),
            
            avatar04.topAnchor.constraint(equalTo: avatarsView.topAnchor),
            avatar04.leadingAnchor.constraint(equalTo: avatarsView.leadingAnchor, constant: 48),
            
            avatar05.topAnchor.constraint(equalTo: avatarsView.topAnchor),
            avatar05.leadingAnchor.constraint(equalTo: avatarsView.leadingAnchor, constant: 64),
            
            avatarText.centerYAnchor.constraint(equalTo: avatarsView.centerYAnchor),
            avatarText.leadingAnchor.constraint(equalTo: avatar05.trailingAnchor, constant: 12),
            avatarText.trailingAnchor.constraint(equalTo: avatarsView.trailingAnchor, constant: 0),
            
            descrLabel.topAnchor.constraint(equalTo: avatarsView.bottomAnchor, constant: 16),
            descrLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: uiBuilder.offset),
            descrLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -uiBuilder.offset),
            

            descrLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0)
            
        ])
        
        // bottomBlock + labelPrice + bottomPrice + btnBookNow
        bottomBlock.applyShadow()
        bottomBlock.addSubviews(bottomPrice, btnBookNow)
        btnBookNow.addTarget(self, action: #selector(bookNowTapped), for: .touchUpInside)

        NSLayoutConstraint.activate([
            bottomBlock.heightAnchor.constraint(equalToConstant: 92),
            bottomBlock.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomBlock.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomBlock.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            
            bottomPrice.centerYAnchor.constraint(equalTo: btnBookNow.centerYAnchor),
            bottomPrice.leadingAnchor.constraint(equalTo: bottomBlock.leadingAnchor, constant: uiBuilder.offset),
            bottomPrice.trailingAnchor.constraint(equalTo: btnBookNow.leadingAnchor, constant: -14),
            
            btnBookNow.topAnchor.constraint(equalTo: bottomBlock.topAnchor, constant: 10),
            btnBookNow.trailingAnchor.constraint(equalTo: bottomBlock.trailingAnchor, constant: -uiBuilder.offset),
            btnBookNow.widthAnchor.constraint(equalToConstant: 140),
            btnBookNow.heightAnchor.constraint(equalToConstant: 48)
        ])
        
        scrollView.contentInset.bottom = 50

    }

    // MARK: - Configure
    private func configureUI() {
        titleLabel.text = item.name
        ratingLabel.text = "⭐️ \(item.rating ?? 0)"
        addressBtn.setTitle("\(item.address ?? "")", for: .normal)
        avatarText.setBoldText(bold: "99+", text: "people have adventures here")
        descrLabel.text = item.descr ?? " "
        descrLabel.setLineHeight(28)
        bottomPrice.setPriceText(price: item.price ?? 0, subtitle: "/person", priceFZ: 24, textFZ: 18)
        
        if let coord = item.coordinate {
            latitude = coord.latitude
            longitude = coord.longitude
        }
        
        if let imageString = item.image, let url = URL(string: imageString) {
            imageView.load(url: url)
        } else {
            imageView.image = UIImage(named: "default-bg")
        }
    }
    
    // MARK: - Navigation
    private func setupCustomBackButton() {
        let backButton = UIBarButtonItem(
            image: UIImage(named: "btn-back")?.withRenderingMode(.alwaysOriginal),
            style: .plain,
            target: self,
            action: #selector(backButtonTapped)
        )
        
        let likeButton = UIBarButtonItem(
            image: UIImage(named: "btn-like")?.withRenderingMode(.alwaysOriginal),
            style: .plain,
            target: self,
            action: #selector(likeButtonTapped)
        )
        
        let mapButton = UIBarButtonItem(
            image: UIImage(named: "btn-map")?.withRenderingMode(.alwaysOriginal),
            style: .plain,
            target: self,
            action: #selector(mapButtonTapped)
        )
        
        // Устанавливаем кнопки
        navigationItem.leftBarButtonItem = backButton
        if latitude != 0 && longitude != 0 {
            navigationItem.rightBarButtonItems = [likeButton, mapButton]
        } else {
            navigationItem.rightBarButtonItems = [likeButton]
        }
        
        // Скрываем стандартную кнопку назад
        navigationItem.hidesBackButton = true
    }
        
    private func setupTransparentNavigationBar() {
        let appearance = UINavigationBarAppearance()
        
        // Для обычного состояния - прозрачный
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = .clear
        appearance.backgroundEffect = nil
        appearance.shadowColor = .clear // Убираем разделительную линию
        
        // Для скролла - тоже прозрачный
        let scrollingAppearance = UINavigationBarAppearance()
        scrollingAppearance.configureWithTransparentBackground()
        scrollingAppearance.backgroundColor = .clear
        scrollingAppearance.backgroundEffect = nil
        scrollingAppearance.shadowColor = .clear
        
        // Применяем настройки
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = scrollingAppearance
        navigationController?.navigationBar.compactAppearance = appearance
        
        // Дополнительные настройки
        navigationController?.navigationBar.isTranslucent = true
    }
    
    // MARK: - Actions
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }

    @objc private func likeButtonTapped() {
        print("❤️ Лайк!")
    }

    @objc private func mapButtonTapped() {
        let mapVC = MapController()
        mapVC.hidesBottomBarWhenPushed = true
        mapVC.pendingDestination = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        navigationController?.pushViewController(mapVC, animated: true)
    }
    
    @objc
    private func handleAddressBtnTapped() {
        print("handleAddressBtnTapped")
    }
    
    @objc
    private func bookNowTapped() {
        print("bookNowTapped")
    }
}
