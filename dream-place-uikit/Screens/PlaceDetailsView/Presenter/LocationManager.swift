//
//  LocationManager.swift
//  dream-place-uikit
//
//  Created by Олег Дмитриев on 14.09.2025.
//

import Foundation
import CoreLocation

protocol LocationManagerDelegate: AnyObject {
    func didUpdateLocation(_ location: CLLocationCoordinate2D)
    func didFailWithError(_ error: Error)
}

final class LocationManager: NSObject {
    static let shared = LocationManager()
    
    private let locationManager = CLLocationManager()
    
    weak var delegate: LocationManagerDelegate?
    
    override init() {
        super.init()
        locationManager.delegate = self
    }
    
    func requestLocation() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let coordinate = locations.last?.coordinate else { return }
        delegate?.didUpdateLocation(coordinate)

        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        delegate?.didFailWithError(error)
    }
}
