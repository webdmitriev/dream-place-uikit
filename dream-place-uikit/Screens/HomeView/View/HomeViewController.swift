//
//  HomeViewController.swift
//  dream-place-uikit
//
//  Created by Олег Дмитриев on 27.08.2025.
//

import UIKit

final class HomeViewController: UIViewController, HomeViewInput {
    
    private var hotels = [Hotel]()
    
    var output: HomeViewOutput!
    
    private lazy var tableView: UITableView = {
        $0.delegate = self
        $0.dataSource = self
        $0.register(UITableViewCell.self, forCellReuseIdentifier: "cell01")
        return $0
    }(UITableView(frame: view.frame, style: .plain))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        
        output.viewDidLoad()
        
        // для сброса onboarding
        // UserDefaults.standard.set(false, forKey: "onboardingCompleted")
    }

    // Methods
    func displayHotels(_ hotels: [Hotel]) {
        self.hotels = hotels
        self.tableView.reloadData()
    }
    
    func displayError(_ error: any Error) {
        print(error.localizedDescription)
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        hotels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell01", for: indexPath)
        let hotel = hotels[indexPath.row]
        
        cell.textLabel?.text = hotel.title
        cell.detailTextLabel?.text = "\(hotel.price)$ • Rating: \(hotel.rating)"
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        output.didSelectHotel(at: hotels[indexPath.row])
    }
    
}
