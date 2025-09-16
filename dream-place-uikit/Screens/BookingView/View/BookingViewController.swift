//
//  BookingViewController.swift
//  dream-place-uikit
//
//  Created by Олег Дмитриев on 27.08.2025.
//

import UIKit

final class BookingViewController: UIViewController {
    
    // MARK: - Properties
    var output: BookingViewOutput!
    weak var router: BookingRouter?
    
    private var booking = [Booking]()
    private var filteredBooking: [Booking] = []
    private var isSearching: Bool = false
    private var searchTimer: Timer?
    
    // UI элементы
    private lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(BookingCell.self, forCellReuseIdentifier: BookingCell.reuseID)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.separatorStyle = .none
        table.dataSource = self
        table.delegate = self
        return table
    }()
    
    private var searchController: UISearchController!
    
    private lazy var emptyStateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Ничего не найдено"
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .systemGray
        label.textAlignment = .center
        label.numberOfLines = 0
        label.isHidden = true // По умолчанию скрыт
        return label
    }()
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .appBg
        
        setupUI()

        output.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = false
        definesPresentationContext = true
    }
    
    // MARK: - Setup UI
    private func setupUI() {
        view.addSubviews(tableView, emptyStateLabel)
        
        title = "Booking"
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "Find your place"
        searchController.searchBar.tintColor = .systemBlue
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchResultsUpdater = self
        
        // Устанавливаем search controller как header
        tableView.tableHeaderView = searchController.searchBar
        
        setupConstraints()
    }
    
    
    // MARK: - Constraints
    private func setupConstraints() {
        NSLayoutConstraint.activate([
             tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
             tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
             tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
             tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
         ])
        
        NSLayoutConstraint.activate([
            emptyStateLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emptyStateLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            emptyStateLabel.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 32),
            emptyStateLabel.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -32)
        ])
    }
    
    
    // MARK: - Navigation
    
    
    // MARK: - Actions
    
}

extension BookingViewController: BookingViewInput {
    func displayBooking(_ booking: [Booking]) {
        self.booking = booking
        self.filteredBooking = booking
        self.isSearching = false
        tableView.reloadData()
    }
    
    func displayError(_ error: any Error) {
        print(error.localizedDescription)
    }
}

extension BookingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        isSearching ? filteredBooking.count : booking.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BookingCell.reuseID, for: indexPath) as! BookingCell
        
        let item = isSearching ? filteredBooking[indexPath.row] : booking[indexPath.row]
        cell.configuration(item: item)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        112
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let _ = isSearching ? filteredBooking[indexPath.row] : booking[indexPath.row]
//        let detailsVC = HotelDetailsView(item: item)
//        detailsVC.hidesBottomBarWhenPushed = true
//        navigationController?.pushViewController(detailsVC, animated: true)
    }
}

extension BookingViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }

        searchTimer?.invalidate()
        searchTimer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false) { _ in
            DispatchQueue.main.async {
                if searchText.isEmpty {
                    self.filteredBooking = self.booking
                    self.isSearching = false
                } else {
                    self.filteredBooking = self.booking.filter { property in
                        let titleMatch = property.name.lowercased().contains(searchText.lowercased())
                        let locationMatch = property.addressShort?.lowercased().contains(searchText.lowercased()) ?? false
                        return titleMatch || locationMatch
                    }
                    self.isSearching = true
                }

                let isEmpty = !searchText.isEmpty && self.filteredBooking.isEmpty
                self.emptyStateLabel.isHidden = !isEmpty

                self.tableView.reloadData()
                print("📊 Найдено результатов: \(self.filteredBooking.count)")
            }
        }
    }
}
