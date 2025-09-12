//
//  PlaceDetailsView.swift
//  dream-place-uikit
//
//  Created by Олег Дмитриев on 08.09.2025.
//

import UIKit

final class PlaceDetailsView: UIViewController {

    // MARK: - Properties
    private let item: Items
    private let uiBuilder = UIBuilder()
    private let height: CGFloat = UIScreen.main.bounds.height

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

    // MARK: - Init
    init(item: Items) {
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
        view.addSubviews(imageView, scrollView)

        imageView.addSubview(cellGradient)
        scrollView.addSubview(contentView)
        
        scrollView.delaysContentTouches = false
        scrollView.canCancelContentTouches = false
        
        contentView.addSubviews(titleLabel, ratingLabel, addressImage, addressBtn)
        
        addressImage.widthAnchor.constraint(equalToConstant: 18).isActive = true
        addressImage.heightAnchor.constraint(equalToConstant: 18).isActive = true
        addressBtn.contentHorizontalAlignment = .left
        addressBtn.addTarget(self, action: #selector(handleAddressBtnTapped), for: .touchUpInside)

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

        // titleLabel + ratingLabel + addressImage + addressBtn
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: height / 1.8),
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
        ])
        
        // contentView -> bottomAnchor
        NSLayoutConstraint.activate([
            contentView.bottomAnchor.constraint(equalTo: addressBtn.bottomAnchor, constant: uiBuilder.offset)
        ])
    }

    // MARK: - Configure
    private func configureUI() {
        titleLabel.text = item.name
        ratingLabel.text = "⭐️ \(item.rating ?? 0)"
        addressBtn.setTitle("\(item.address ?? "")", for: .normal)
        
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
        navigationItem.rightBarButtonItems = [likeButton, mapButton]
        
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
        print("🗺️ Открыть карту")
    }
    
    @objc
    private func handleAddressBtnTapped() {
        print("handleAddressBtnTapped")
    }
}
