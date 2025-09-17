//
//  BookingViewController.swift
//  dream-place-uikit
//
//  Created by Олег Дмитриев on 27.08.2025.
//

import UIKit
import Combine

final class BookingViewController: UIViewController {
    
    // MARK: - Properties
    private let uiBuilder = UIBuilder()
    var output: BookingViewOutput!
    weak var router: BookingRouter?
    
    private var allBookings = [Booking]()
    private var booking = [Booking]()
    private var cancellables: Set<AnyCancellable> = []
    private let searchSubject = PassthroughSubject<String, Never>()
    
    // UI элементы
    private lazy var searchField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Find booking"
        textField.textColor = .label
        textField.font = .systemFont(ofSize: 17, weight: .medium)
        textField.backgroundColor = .secondarySystemBackground
        textField.layer.cornerRadius = 8
        textField.addPaddingToTextField()
        return textField
    }()
    private lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.register(BookingCell.self, forCellReuseIdentifier: BookingCell.reuseID)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.separatorStyle = .none
        table.dataSource = self
        table.delegate = self
        return table
    }()
    
    private lazy var emptyStateLabel: UILabel = uiBuilder.addLabel("Not found", color: .appBlack, align: .center)
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .appBg
        setupUI()
        output.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = false
        tableView.contentInsetAdjustmentBehavior = .never
    }
    
    // MARK: - Setup UI
    private func setupUI() {
        view.addSubviews(searchField, tableView, emptyStateLabel)
        title = "Booking"
        emptyStateLabel.isHidden = true
        
        searchField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        searchSubject
            .debounce(for: .milliseconds(300), scheduler: DispatchQueue.main)
            .map { $0 }
            .sink { [weak self] searchText in
                self?.filterBooking(with: searchText)
            }
            .store(in: &cancellables)
        
        searchField.delegate = self
        searchField.returnKeyType = .search
        
        setupConstraints()
    }
    
    
    // MARK: - Constraints
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            emptyStateLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emptyStateLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            emptyStateLabel.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 32),
            emptyStateLabel.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -32),

            searchField.heightAnchor.constraint(equalToConstant: 44),
            searchField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: uiBuilder.offset),
            searchField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -uiBuilder.offset),
            
            tableView.topAnchor.constraint(equalTo: searchField.bottomAnchor, constant: 4),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    // MARK: - Navigation
    
    
    // MARK: - Actions
    private func filterBooking(with searchText: String) {
        if searchText.isEmpty {
            emptyStateLabel.isHidden = true
            booking = allBookings
        } else {
            let filtered = allBookings.filter { booking in
                let nameMatch = booking.name.lowercased().contains(searchText.lowercased())
                let addressMatch = booking.addressShort?.lowercased().contains(searchText.lowercased()) ?? false
                return nameMatch || addressMatch
            }
            emptyStateLabel.isHidden = !filtered.isEmpty
            booking = filtered
        }
        tableView.reloadData()
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        guard let text = textField.text else { return }
        searchSubject.send(text)
    }

    @objc internal func textFieldDidEndEditing(_ textField: UITextField) {
        // Можно отправить последнее значение, если нужно
    }
    
}

extension BookingViewController: BookingViewInput {
    func displayBooking(_ booking: [Booking]) {
        self.allBookings = booking
        self.booking = booking
        emptyStateLabel.isHidden = true
        tableView.reloadData()
        
        searchField.text = ""
        searchSubject.send("")
    }
    
    func displayError(_ error: any Error) {
        print(error.localizedDescription)
    }
}

extension BookingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        booking.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BookingCell.reuseID, for: indexPath) as! BookingCell
        let item = booking[indexPath.row]
        cell.configuration(item: item)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        112
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let _ = booking[indexPath.row]
//        let detailsVC = HotelDetailsView(item: item)
//        detailsVC.hidesBottomBarWhenPushed = true
//        navigationController?.pushViewController(detailsVC, animated: true)
    }
}

extension BookingViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
