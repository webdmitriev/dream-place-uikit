//
//  HomeViewController.swift
//  dream-place-uikit
//
//  Created by Олег Дмитриев on 27.08.2025.
//

import UIKit

final class HomeViewController: UIViewController {
    
    private var hotels = [Hotel]()
    private let items: [CollectionStruct] = CollectionStruct.mockData()
    
    private let uiBuilder = UIBuilder()
    
    private let headerImageHeight: CGFloat = 332
    
    private lazy var headerImage: UIImageView = {
        $0.image = UIImage(named: "home-bg")
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        return $0
    }(UIImageView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: headerImageHeight)))
    
    var output: HomeViewOutput!
    
    private var dataSource: UICollectionViewDiffableDataSource<CollectionStruct, Items>!
    
    private lazy var collectionView: UICollectionView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        
        $0.register(CollectionDiffableHeader.self,
                    forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                    withReuseIdentifier: CollectionDiffableHeader.reuseID)
        
        $0.register(HeaderCell.self, forCellWithReuseIdentifier: HeaderCell.reuseID)
        $0.register(SearchCell.self, forCellWithReuseIdentifier: SearchCell.reuseID)
        $0.register(HotelsCell.self, forCellWithReuseIdentifier: HotelsCell.reuseID)
        
        $0.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        $0.backgroundColor = .clear
        
        return $0
    }(UICollectionView(frame: view.frame, collectionViewLayout: createLayout()))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubviews(headerImage, collectionView)
        
        collectionView.delegate = self
        
        createDataSource()
        createSnapshot()
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        // self.changeOnboardingStatus(false)
        // output.viewDidLoad()
    }
    
    // MARK: 1 - UICollectionViewCompositionalLayout
    private func createLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout { [weak self] sectionIndex, _ in
            guard let self else { return nil }
            
            let currentSection = self.items[sectionIndex]
            let section = self.createSection(currentSection.type)

            if currentSection.action {
                section.boundarySupplementaryItems = [self.createTopHeader()]
            }

            if currentSection.type == .hotels {
                let background = NSCollectionLayoutDecorationItem.background(elementKind: "background")
                background.zIndex = -1
                section.decorationItems = [background]
            }

            return section
        }

        layout.register(SectionBackgroundView.self, forDecorationViewOfKind: "background")
        return layout
    }

    private func createSection(_ type: SectionType) -> NSCollectionLayoutSection {
        switch type {
        case .header:
            return createHeaderSection()
        case .search:
            return createSearchSection()
        case .hotels:
            return createHotelsSection()
        }
    }

    // MARK: 2 - dataSource
    private func createDataSource() {
        self.dataSource = UICollectionViewDiffableDataSource<CollectionStruct, Items>(collectionView: collectionView) { [weak self] collectionView, indexPath, item in
            
            let currentSection = self!.items[indexPath.section].type
            
            switch currentSection {
            case .header:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HeaderCell.reuseID, for: indexPath) as! HeaderCell
                return cell
            case .search:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCell.reuseID, for: indexPath) as! SearchCell
                return cell
            case .hotels:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HotelsCell.reuseID, for: indexPath) as! HotelsCell
                cell.configure(item: item)
                return cell
            }
        }
        
        self.dataSource.supplementaryViewProvider = { [weak self] collectionView, kind, indexPath in
            guard kind == UICollectionView.elementKindSectionHeader else { return UICollectionReusableView() }
            
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                         withReuseIdentifier: CollectionDiffableHeader.reuseID,
                                                                         for: indexPath) as! CollectionDiffableHeader
            
            let section = self?.items[indexPath.section]
            header.actionCell(title: section?.title ?? "")
            return header
        }
    }
    
    // MARK: 3 - create snapshot
    private func createSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<CollectionStruct, Items>()
        snapshot.appendSections(items)
        
        items.forEach { section in
            snapshot.appendItems(section.items, toSection: section)
        }
        
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}

// MARK: Home
extension HomeViewController: HomeViewInput {
    func displayHotels(_ hotels: [Hotel]) {
        self.hotels = hotels
    }
    
    func displayError(_ error: any Error) {
        print(error.localizedDescription)
    }
    
    private func changeOnboardingStatus(_ status: Bool) {
        UserDefaults.standard.set(status, forKey: "onboardingCompleted")
    }
}

// MARK: UICollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let scrollHeight = scrollView.contentSize.height - scrollView.bounds.height
        let scrollPercentage = offsetY / scrollHeight
        
        // Изменяем высоту фона в зависимости от скролла
        updateBackgroundHeight(for: offsetY, percentage: scrollPercentage)
    }
    
    private func updateBackgroundHeight(for offsetY: CGFloat, percentage: CGFloat) {
        let newHeight = headerImageHeight - offsetY * 0.5
        headerImage.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: newHeight)
        
        UIView.animate(withDuration: 0.1) {
            self.view.layoutIfNeeded()
        }
    }
}

// MARK: Top Add Header
extension HomeViewController {
    private func createTopHeader(height: CGFloat = 48) -> NSCollectionLayoutBoundarySupplementaryItem {
        NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(height)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top
        )
    }
}

// MARK: Sections (height)
extension HomeViewController {
    private func createHeaderSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .absolute(42))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let group = NSCollectionLayoutGroup.vertical(layoutSize: itemSize, subitems: [item])
        return NSCollectionLayoutSection(group: group)
    }

    private func createSearchSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .absolute(142))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let group = NSCollectionLayoutGroup.vertical(layoutSize: itemSize, subitems: [item])
        return NSCollectionLayoutSection(group: group)
    }

    private func createHotelsSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(280))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(widthDimension: .absolute(164), heightDimension: .absolute(280)),
            repeatingSubitem: item, count: 1)

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.interGroupSpacing = 14
        section.contentInsets = .init(top: 20, leading: uiBuilder.offset, bottom: 20, trailing: uiBuilder.offset)
        
        return section
    }
}
