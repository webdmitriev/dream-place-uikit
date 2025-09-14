//
//  MapPlaceController.swift
//  dream-place-uikit
//
//  Created by Олег Дмитриев on 14.09.2025.
//

import UIKit
import CoreLocation
import MapKit

final class MapPlaceController: UIViewController {
    
    private var currentLocation: CLLocationCoordinate2D?
    var pendingDestination: CLLocationCoordinate2D?

    
    private lazy var mapView: MKMapView = {
        $0.frame = view.bounds
        $0.delegate = self
        $0.showsUserLocation = true
        return $0
    }(MKMapView())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        LocationManager.shared.requestLocation()
        LocationManager.shared.delegate = self

        setupUI()
        
        setupCustomBackButton()
        setupTransparentNavigationBar()
    }
    
    // MARK: - Setup UI
    private func setupUI() {
        view.addSubview(mapView)
    }
    
    // MARK: Calculate location - to
    func builderRoute(to destination: CLLocationCoordinate2D) {
        guard let currentLocation = currentLocation else {
            print("Текущая локация недоступна")
            return
        }

        // Создаем плейсмарки для источника и назначения
        let sourcePlacemark = MKPlacemark(coordinate: currentLocation)
        let destinationPlacemark = MKPlacemark(coordinate: destination)

        // Настраиваем запрос маршрута
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: sourcePlacemark)
        request.destination = MKMapItem(placemark: destinationPlacemark)
        request.transportType = .automobile
        request.requestsAlternateRoutes = false

        // Создаем объект для расчета маршрута
        let directions = MKDirections(request: request)
        directions.calculate { [weak self] response, error in
            if let error = error {
                print("Ошибка при расчете маршрута: \(error.localizedDescription)")
                return
            }

            guard let route = response?.routes.first else {
                print("Маршрут не найден")
                return
            }

            // Удаляем предыдущие оверлеи и добавляем новый маршрут
            if let overlays = self?.mapView.overlays {
                self?.mapView.removeOverlays(overlays)
            }
            self?.mapView.addOverlay(route.polyline)

            // Устанавливаем видимую область карты с padding
            self?.mapView.setVisibleMapRect(
                route.polyline.boundingMapRect,
                edgePadding: UIEdgeInsets(top: 50, left: 20, bottom: 50, right: 20),
                animated: true
            )
        }
    }

    
//    func geocodeAddressString(_ addressString: String) {
//        let geocoder = CLGeocoder()
//        geocoder.geocodeAddressString(addressString) { [weak self] placemarks, error in
//            if let placeMark = placemarks?.first?.location?.coordinate {
//                self?.builderRoute(to: placeMark)
//            } else {
//                guard let error else { return }
//                print(error.localizedDescription)
//            }
//        }
//    }
    
//    func buildRoute(to latitude: Double, longitude: Double) {
//        print(latitude)
//        let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
//        builderRoute(to: coordinate)
//    }
    
    // MARK: - Navigation
    private func setupCustomBackButton() {
        let backButton = UIBarButtonItem(
            image: UIImage(named: "btn-back")?.withRenderingMode(.alwaysOriginal),
            style: .plain,
            target: self,
            action: #selector(backButtonTapped)
        )
        
        // Устанавливаем кнопки
        navigationItem.leftBarButtonItem = backButton
        
        // Скрываем стандартную кнопку назад
        navigationItem.hidesBackButton = true
    }
        
    private func setupTransparentNavigationBar() {
        let appearance = UINavigationBarAppearance()
        
        // Для обычного состояния - прозрачный
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = .clear
        appearance.backgroundEffect = nil
        appearance.shadowColor = .clear // Убираем разделительную линию
        
        // Для скролла - тоже прозрачный
        let scrollingAppearance = UINavigationBarAppearance()
        scrollingAppearance.configureWithTransparentBackground()
        scrollingAppearance.backgroundColor = .clear
        scrollingAppearance.backgroundEffect = nil
        scrollingAppearance.shadowColor = .clear
        
        // Применяем настройки
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = scrollingAppearance
        navigationController?.navigationBar.compactAppearance = appearance
        
        // Дополнительные настройки
        navigationController?.navigationBar.isTranslucent = true
    }
    
    // MARK: - Actions
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}

extension MapPlaceController: LocationManagerDelegate {
    func didUpdateLocation(_ location: CLLocationCoordinate2D) {
        self.currentLocation = location
        
        let region = MKCoordinateRegion(center: location, latitudinalMeters: 5000, longitudinalMeters: 5000)
        mapView.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = "My Location"
        mapView.addAnnotation(annotation)
        
        // Теперь текущая локация есть, можно строить маршрут
        if let destination = pendingDestination {
            builderRoute(to: destination)
            pendingDestination = nil
        }
    }
    
    func didFailWithError(_ error: any Error) {
        print("Error: \(error.localizedDescription)")
    }
}

extension MapPlaceController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: any MKOverlay) -> MKOverlayRenderer {
        
        if let polyline = overlay as? MKPolyline {
            let renderer = MKPolylineRenderer(polyline: polyline)
            renderer.strokeColor = .blue
            renderer.lineWidth = 3
            return renderer
        }
        
        return MKOverlayRenderer()
    }
}
