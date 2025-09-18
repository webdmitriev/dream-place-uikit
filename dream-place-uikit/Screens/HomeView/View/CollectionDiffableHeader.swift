//
//  CollectionDiffableHeader.swift
//  dream-place-uikit
//
//  Created by Олег Дмитриев on 04.09.2025.
//

import UIKit

final class CollectionDiffableHeader: UICollectionReusableView {
    static let reuseID: String = "CollectionDiffableHeader"
    
    private let uiBuilder = UIBuilder()
    
    private lazy var stackView: UIStackView = uiBuilder.addStack()
    private lazy var titleLabel: UILabel = uiBuilder.addLabel("Hotel Near You", fz: .header, fw: .medium, color: .appBlack, lines: 1)
    private lazy var headerBtn: UIButton = uiBuilder.addButton("View all", color: .appBlue, bgc: .clear)
    var onTap: (() -> Void)? {
        didSet {
            headerBtn.isHidden = (onTap == nil)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(stackView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(headerBtn)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 14),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0)
        ])
        
        headerBtn.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Methods
    func actionCell(title: String, brsTop: CGFloat = 24) {
        self.titleLabel.text = title
    }
    
    @objc
    private func didTapButton() {
        onTap?()
    }
}
