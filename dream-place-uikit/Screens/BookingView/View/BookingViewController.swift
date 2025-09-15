//
//  BookingViewController.swift
//  dream-place-uikit
//
//  Created by Олег Дмитриев on 27.08.2025.
//

import UIKit

final class BookingViewController: UIViewController {
    
    var output: BookingViewOutput!
    weak var router: BookingRouter?
    
    private var booking = [Booking]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .appBg
        
        title = "Booking"
    }
    
}

extension BookingViewController: BookingViewInput {
    func displayBooking(_ booking: [Booking]) {
        self.booking = booking
    }
    
    func displayError(_ error: any Error) {
        print(error.localizedDescription)
    }
    
    
}
