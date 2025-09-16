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
        $0.register(BookingCell.self, forCellReuseIdentifier: BookingCell.reuseID)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UITableView(frame: view.frame, style: .grouped))
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .appBg
        
        title = "Booking"
        
        output.viewDidLoad()
        
        setupUI()
        setupConstraints()
    }
    
    // MARK: - Setup UI
    private func setupUI() {
        view.addSubview(tableView)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
    }
    
    
    // MARK: - Constraints
    private func setupConstraints() {
        //
    }
    
    
    // MARK: - Navigation
    
    
    // MARK: - Actions
    
}

extension BookingViewController: BookingViewInput {
    func displayBooking(_ booking: [Booking]) {
        self.booking = booking
        tableView.reloadData()
    }
    
    func displayError(_ error: any Error) {
        print(error.localizedDescription)
    }
}

extension BookingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.booking.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BookingCell.reuseID, for: indexPath) as! BookingCell
        
        let item = self.booking[indexPath.row]
        
        cell.configuration(item: item)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        112
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("tap")
//        let item = self.booking[indexPath.row]
//        
//        let detailsVC = HotelDetailsView(item: item)
//        detailsVC.hidesBottomBarWhenPushed = true
//        navigationController?.pushViewController(detailsVC, animated: true)
    }
}
