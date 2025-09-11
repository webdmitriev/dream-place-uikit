//
//  HotelDetailsView.swift
//  dream-place-uikit
//
//  Created by Олег Дмитриев on 08.09.2025.
//

import UIKit

final class HotelDetailsView: UIViewController {

    // MARK: - Properties
    private let item: Items
    private let uiBuilder = UIBuilder()
    private var imageHeightConstraint: NSLayoutConstraint!
    private var imageTopConstraint: NSLayoutConstraint!
    private var isDescriptionExpanded = false

    // UI элементы
    private lazy var scrollView: UIScrollView = uiBuilder.addScrollView(bgc: .appBg)
    private lazy var contentView: UIView = uiBuilder.addView(clipsToBounds: false)
    private lazy var imageView: UIImageView = uiBuilder.addImage("post-01", mode: .scaleAspectFill)
    private lazy var cellGradient = GradientView(
        colors: [
            UIColor.appBlack.withAlphaComponent(0.9),
            UIColor.clear
        ],
        startPoint: CGPoint(x: 0.5, y: 1.0),
        endPoint: CGPoint(x: 0.5, y: 0.0)
    )
    private lazy var titleLabel: UILabel = uiBuilder.addLabel("title", fz: .header, fw: .bold, color: .appWhite, lines: 2)
    private lazy var addressLabel: UILabel = uiBuilder.addLabel("address", fz: .text, color: .appGray, lines: 3)

    private lazy var descrTitleLabel: UILabel = uiBuilder.addLabel("About Us", fz: .header, color: .appBlack, lines: 1)
    private lazy var descrLabel: UILabel = {
        let label = uiBuilder.addLabel("descr", fz: .text, fw: .medium, color: .appGrayText, lines: 8)
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    private lazy var showMoreButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Read more", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        btn.tintColor = .systemBlue
        btn.addTarget(self, action: #selector(toggleDescription), for: .touchUpInside)
        return btn
    }()
    
    private lazy var facilitiesTitle: UILabel = uiBuilder.addLabel("Services & Facilities",
                                                                   fz: .header, color: .appBlack, lines: 1)
    
    // MARK: - Facilities
    private lazy var facilitiesContainer: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.alignment = .top
        stack.spacing = 16
        return stack
    }()

    private lazy var leftColumn: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        stack.alignment = .leading
        return stack
    }()

    private lazy var rightColumn: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        stack.alignment = .leading
        return stack
    }()
    
    // MARK: - Gallery preview
    private lazy var galleryStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        stack.alignment = .center
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.isUserInteractionEnabled = true
        return stack
    }()
    
    // MARK: - Bottom block
    private lazy var bottomBlock: UIView = uiBuilder.addView(bgc: .appWhite, clipsToBounds: true)
    private lazy var btnBookNow: UIButton = uiBuilder.addButton("Book Now", height: false, color: .appWhite, bgc: .appBlue)
    private lazy var labelPrice: UILabel = uiBuilder.addLabel("Price estimate", fz: .text, color: .appGrayText, lines: 1)
    private lazy var bottomPrice: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setPriceText(price: 28, subtitle: "/night", priceFZ: 20)
        return $0
    }(UILabel())
    

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

        scrollView.delegate = self
        
        setupUI()
        configureUI()
        setupGallery()
        setupCustomBackButton()
        setupTransparentNavigationBar()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let maxHeight = descrLabel.font.lineHeight * 8
        showMoreButton.isHidden = descrLabel.bounds.height <= maxHeight
    }

    // MARK: - Setup UI
    private func setupUI() {
        view.addSubviews(scrollView, bottomBlock)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)

        contentView.addSubview(imageView)
        imageView.addSubview(cellGradient)
        
        contentView.addSubviews(titleLabel, addressLabel, descrTitleLabel, facilitiesTitle)

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

        // imageView + cellGradient
        imageView.applyBottomCornerRadius(28)
        imageTopConstraint = imageView.topAnchor.constraint(equalTo: contentView.topAnchor)
        imageHeightConstraint = imageView.heightAnchor.constraint(equalToConstant: 470)
        cellGradient.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            imageTopConstraint,
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageHeightConstraint,
            
            cellGradient.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            cellGradient.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
            cellGradient.bottomAnchor.constraint(equalTo: imageView.bottomAnchor),
            cellGradient.heightAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: 0.7),
        ])
        
        contentView.addSubview(galleryStack)
        NSLayoutConstraint.activate([
            galleryStack.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -16),
            galleryStack.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -24),
            galleryStack.widthAnchor.constraint(equalToConstant: 60),
            galleryStack.heightAnchor.constraint(equalToConstant: 190),
        ])

        // titleLabel + addressLabel
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: uiBuilder.offset),
            titleLabel.trailingAnchor.constraint(equalTo: galleryStack.leadingAnchor, constant: -uiBuilder.offset),
            titleLabel.bottomAnchor.constraint(equalTo: addressLabel.topAnchor, constant: -16),
            
            addressLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: uiBuilder.offset),
            addressLabel.trailingAnchor.constraint(equalTo: galleryStack.leadingAnchor, constant: -uiBuilder.offset),
            addressLabel.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -24),
        ])

        // descrTitleLabel
        NSLayoutConstraint.activate([
            descrTitleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 24),
            descrTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: uiBuilder.offset),
            descrTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -uiBuilder.offset),
        ])
        
        contentView.addSubviews(descrLabel, showMoreButton)
        showMoreButton.backgroundColor = .appBg
        NSLayoutConstraint.activate([
            descrLabel.topAnchor.constraint(equalTo: descrTitleLabel.bottomAnchor, constant: 8),
            descrLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: uiBuilder.offset),
            descrLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -uiBuilder.offset),
            
            showMoreButton.bottomAnchor.constraint(equalTo: descrLabel.bottomAnchor, constant: 6),
            showMoreButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -uiBuilder.offset),
        ])

        // facilitiesTitle
        NSLayoutConstraint.activate([
            facilitiesTitle.topAnchor.constraint(equalTo: descrLabel.bottomAnchor, constant: 34),
            facilitiesTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: uiBuilder.offset),
            facilitiesTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -uiBuilder.offset),
        ])
        
        contentView.addSubview(facilitiesContainer)
        facilitiesContainer.addArrangedSubview(leftColumn)
        facilitiesContainer.addArrangedSubview(rightColumn)
        facilitiesContainer.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            facilitiesContainer.topAnchor.constraint(equalTo: facilitiesTitle.bottomAnchor, constant: 8),
            facilitiesContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: uiBuilder.offset),
            facilitiesContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -uiBuilder.offset),

            facilitiesContainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -110)
        ])
        
        // bottomBlock + labelPrice + bottomPrice + btnBookNow
        bottomBlock.applyShadow()
        bottomBlock.addSubviews(labelPrice, bottomPrice, btnBookNow)
        btnBookNow.addTarget(self, action: #selector(bookNowTapped), for: .touchUpInside)

        NSLayoutConstraint.activate([
            bottomBlock.heightAnchor.constraint(equalToConstant: 92),
            bottomBlock.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomBlock.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomBlock.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            
            labelPrice.topAnchor.constraint(equalTo: bottomBlock.topAnchor, constant: 10),
            labelPrice.leadingAnchor.constraint(equalTo: bottomBlock.leadingAnchor, constant: uiBuilder.offset),
            labelPrice.trailingAnchor.constraint(equalTo: btnBookNow.leadingAnchor, constant: -14),
            
            bottomPrice.topAnchor.constraint(equalTo: labelPrice.bottomAnchor, constant: 2),
            bottomPrice.leadingAnchor.constraint(equalTo: bottomBlock.leadingAnchor, constant: uiBuilder.offset),
            bottomPrice.trailingAnchor.constraint(equalTo: btnBookNow.leadingAnchor, constant: -14),
            
            btnBookNow.topAnchor.constraint(equalTo: bottomBlock.topAnchor, constant: 10),
            btnBookNow.trailingAnchor.constraint(equalTo: bottomBlock.trailingAnchor, constant: -uiBuilder.offset),
            btnBookNow.widthAnchor.constraint(equalToConstant: 140),
            btnBookNow.heightAnchor.constraint(equalToConstant: 48)
        ])
    }

    // MARK: - Configure
    private func configureUI() {
        titleLabel.text = item.name
        addressLabel.text = item.address
        descrLabel.text = item.descr

        bottomPrice.setPriceText(price: item.price ?? 0, subtitle: " /night", priceFZ: 17, color: .appBlack)
        
        if let imageString = item.image, let url = URL(string: imageString) {
            imageView.load(url: url)
        } else {
            imageView.image = UIImage(named: "post-01")
        }
        
        if let gallery = item.gallery {
            galleryStack.arrangedSubviews.forEach { $0.removeFromSuperview() }

            for (index, urlString) in gallery.prefix(3).enumerated() {
                let thumb = UIImageView()
                thumb.contentMode = .scaleAspectFill
                thumb.clipsToBounds = true
                thumb.layer.cornerRadius = 8
                thumb.isUserInteractionEnabled = true
                thumb.tag = index
                
                if let url = URL(string: urlString) {
                    thumb.load(url: url)
                }

                let tap = UITapGestureRecognizer(target: self, action: #selector(galleryImageTapped(_:)))
                thumb.addGestureRecognizer(tap)

                galleryStack.addArrangedSubview(thumb)
            }
        }


        // --- Facilities
        guard let facilities = item.facilities else { return }

        leftColumn.arrangedSubviews.forEach { $0.removeFromSuperview() }
        rightColumn.arrangedSubviews.forEach { $0.removeFromSuperview() }

        let middleIndex = Int(ceil(Double(facilities.count) / 2.0))
        let leftItems = facilities.prefix(middleIndex)
        let rightItems = facilities.suffix(from: middleIndex)

        for facilityName in leftItems {
            if let type = FacilityType(rawValue: facilityName) {
                leftColumn.addArrangedSubview(makeFacilityView(type: type))
            }
        }

        for facilityName in rightItems {
            if let type = FacilityType(rawValue: facilityName) {
                rightColumn.addArrangedSubview(makeFacilityView(type: type))
            }
        }


    }
    
    private func makeFacilityView(type: FacilityType) -> UIStackView {
        let imageView = UIImageView(image: UIImage(systemName: type.iconName))
        imageView.tintColor = .systemBlue
        imageView.contentMode = .scaleAspectFit
        imageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        
        let label = UILabel()
        label.text = type.rawValue
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = .darkGray
        
        let stack = UIStackView(arrangedSubviews: [imageView, label])
        stack.axis = .horizontal
        stack.spacing = 8
        stack.alignment = .center
        return stack
    }
    
    private func setupGallery() {
        guard let gallery = item.gallery else { return }
        
        galleryStack.arrangedSubviews.forEach { $0.removeFromSuperview() }

        for (index, urlString) in gallery.prefix(3).enumerated() {
            let thumb = UIImageView()
            thumb.image = UIImage(named: "post-01")
            thumb.contentMode = .scaleAspectFill
            thumb.clipsToBounds = true
            thumb.layer.cornerRadius = 6
            thumb.isUserInteractionEnabled = true
            thumb.tag = index

            // загрузка картинки
            if let url = URL(string: urlString) {
                thumb.load(url: url)
            }

            // жест
            let tap = UITapGestureRecognizer(target: self, action: #selector(galleryImageTapped(_:)))
            thumb.addGestureRecognizer(tap)

            galleryStack.addArrangedSubview(thumb)
        }
        
        highlightThumbnail(at: 0)
    }
    
    // highlightThumbnail
    private func highlightThumbnail(at index: Int) {
        for (i, subview) in galleryStack.arrangedSubviews.enumerated() {
            guard let img = subview as? UIImageView else { continue }
            if i == index {
                img.layer.borderWidth = 2
                img.layer.borderColor = UIColor.appBlue.cgColor
            } else {
                img.layer.borderWidth = 2
                img.layer.borderColor = UIColor.appWhite.cgColor
            }
        }
    }

    // MARK: - Navigation
    private func setupCustomBackButton() {
        // Создаем кастомную кнопку
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
        
        // Устанавливаем кастомную кнопку
        navigationItem.leftBarButtonItem = backButton
        navigationItem.rightBarButtonItem = likeButton
        
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
    
    @objc
    private func galleryImageTapped(_ sender: UITapGestureRecognizer) {
        guard let view = sender.view else { return }
        let index = view.tag
        
        if let urlString = item.gallery?[index], let url = URL(string: urlString) {
            imageView.load(url: url)
            highlightThumbnail(at: index)
        }
    }

    
    @objc
    private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc
    private func likeButtonTapped() {
        print("likeButtonTapped")
    }
    
    @objc
    private func bookNowTapped() {
        print("bookNowTapped")
    }
    
    @objc
    private func toggleDescription() {
        isDescriptionExpanded.toggle()
        
        if isDescriptionExpanded {
            descrLabel.numberOfLines = 0
            UIView.animate(withDuration: 0.25) {
                self.showMoreButton.alpha = 0
                self.view.layoutIfNeeded()
            } completion: { _ in
                self.showMoreButton.isHidden = true
            }
        } else {
            descrLabel.numberOfLines = 8
            showMoreButton.isHidden = false
            showMoreButton.alpha = 0
            showMoreButton.setTitle("Read more", for: .normal)
            UIView.animate(withDuration: 0.25) {
                self.showMoreButton.alpha = 1
                self.view.layoutIfNeeded()
            }
        }
    }

}

extension HotelDetailsView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y

        if offsetY < 0 {
            imageTopConstraint.constant = offsetY
            imageHeightConstraint.constant = 470 - offsetY
        } else {
            imageTopConstraint.constant = 0
            imageHeightConstraint.constant = 470
        }
    }

}
