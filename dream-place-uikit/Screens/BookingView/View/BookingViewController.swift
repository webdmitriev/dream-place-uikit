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
    
    // UI элементы
    private lazy var tableView: UITableView = {
        $0.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UITableView())
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .appBg
        
        title = "Booking"
        
        setupUI()
        setupConstraints()
    }
    
    // MARK: - Setup UI
    private func setupUI() {
        view.addSubview(tableView)
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    
    // MARK: - Constraints
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    
    // MARK: - Navigation
    
    
    // MARK: - Actions
    
}

extension BookingViewController: BookingViewInput {
    func displayBooking(_ booking: [Booking]) {
        self.booking = booking
    }
    
    func displayError(_ error: any Error) {
        print(error.localizedDescription)
    }
    
    
}

extension BookingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.backgroundColor = .appRed
        
        return cell
    }
    
    
}
