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
    
    private lazy var headerImage: UIImageView = {
        $0.image = UIImage(named: "home-bg")
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        return $0
    }(UIImageView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 332)))
    
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
        
        createDataSource()
        createSnapshot()
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        // output.viewDidLoad()
    }
    
    // MARK: 1 - UICollectionViewCompositionalLayout
    private func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { [weak self] sectionIndex, environment in
            guard let self else { return nil }
            
            let currentSection = self.items[sectionIndex]
            let section = self.createSection(currentSection.type)

            if currentSection.action {
                section.boundarySupplementaryItems = [self.createTopHeader()]
            }
            
            return section
        }
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
                return cell
            }
        }
        
        self.dataSource.supplementaryViewProvider = { [weak self] collectionView, kind, indexPath in
            guard kind == UICollectionView.elementKindSectionHeader else { return UICollectionReusableView() }
            
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                         withReuseIdentifier: CollectionDiffableHeader.reuseID,
                                                                         for: indexPath) as! CollectionDiffableHeader
            
            
            let section = self?.items[indexPath.section]
            header.titleCell.text = section?.title
            header.actionCell(isHide: section?.action ?? false)
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


// MARK: Top Add Header
extension HomeViewController {
    private func createTopHeader(height: CGFloat = 44) -> NSCollectionLayoutBoundarySupplementaryItem {
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
                                              heightDimension: .absolute(132))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let group = NSCollectionLayoutGroup.vertical(layoutSize: itemSize, subitems: [item])
        return NSCollectionLayoutSection(group: group)
    }

    private func createHotelsSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .absolute(280))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let group = NSCollectionLayoutGroup.vertical(layoutSize: itemSize, subitems: [item])
        return NSCollectionLayoutSection(group: group)
    }
}



//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let scrolledPixels = scrollView.contentOffset.y
//        homeBgImageView.frame = CGRect(x: 0, y: -scrolledPixels,
//                                       width: view.frame.width, height: view.frame.width + scrolledPixels)
//    }
