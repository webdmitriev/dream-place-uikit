//
//  FavoriteViewController.swift
//  dream-place-uikit
//
//  Created by Олег Дмитриев on 27.08.2025.
//

import UIKit

final class FavoriteViewController: UIViewController {
    
    // MARK: - Properties
    private let uiBuilder = UIBuilder()
    private var booking: [FavoriteBooking] = []
    
    // UI элементы
    private lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.register(FavoriteCell.self, forCellReuseIdentifier: FavoriteCell.reuseID)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.separatorStyle = .none
        table.contentInsetAdjustmentBehavior = .never
        table.dataSource = self
        table.delegate = self
        return table
    }()
    
    private lazy var emptyStateLabel: UILabel = uiBuilder.addLabel("Not found", color: .appBlack, align: .center)

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Favorites"
        view.backgroundColor = .appBg
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Загружаем актуальные избранные
        booking = CoreDataManager.shared.fetchFavorites()
        tableView.reloadData()
        
        emptyStateLabel.isHidden = !booking.isEmpty
    }
    
    // MARK: - Setup UI
    private func setupUI() {
        view.addSubviews(tableView, emptyStateLabel)
        emptyStateLabel.isHidden = true
        setupConstraints()
    }
    
    // MARK: - Constraints
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            emptyStateLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emptyStateLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            emptyStateLabel.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 32),
            emptyStateLabel.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -32),
            
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
}

extension FavoriteViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        booking.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteCell.reuseID, for: indexPath) as! FavoriteCell
        let item = booking[indexPath.row]
        cell.configuration(item: item)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        112
    }
    
    // MARK: - Swipe to delete
    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] _, _, completion in
            guard let self = self else { return }
            
            let item = booking[indexPath.row]
            
            // Удаляем из Core Data
            CoreDataManager.shared.removeFavorite(id: Int(item.id))
            
            // Удаляем из массива и таблицы
            booking.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
            emptyStateLabel.isHidden = !booking.isEmpty
            
            completion(true)
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let _ = booking[indexPath.row]
//        let detailsVC = BookingDetailsView(item: item)
//        detailsVC.hidesBottomBarWhenPushed = true
//        navigationController?.pushViewController(detailsVC, animated: true)
    }
}
