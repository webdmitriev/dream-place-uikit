//
//  MapController.swift
//  dream-place-uikit
//
//  Created by Олег Дмитриев on 14.09.2025.
//

import UIKit
import CoreLocation
import MapKit

class RouteAnnotation: MKPointAnnotation {
    enum `Type` {
        case source
        case destination
    }
    
    let type: Type
    
    init(coordinate: CLLocationCoordinate2D, type: Type) {
        self.type = type
        super.init()
        self.coordinate = coordinate
        
        switch type {
        case .source:
            self.title = "I'm here"
        case .destination:
            self.title = "Destination"
        }
    }
}

final class MapController: UIViewController {
    
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
        let sourceMapItem = MKMapItem(placemark: MKPlacemark(coordinate: currentLocation))
        sourceMapItem.name = "I'm here"
        
        let destinationMapItem = MKMapItem(placemark: MKPlacemark(coordinate: destination))
        destinationMapItem.name = "Destination"
        

        // Настраиваем запрос маршрута
        let request = MKDirections.Request()
        request.source = sourceMapItem
        request.destination = destinationMapItem
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

            DispatchQueue.main.async { [weak self] in
                self?.mapView.removeOverlays(self?.mapView.overlays ?? [])
                
                self?.mapView.removeAnnotations(self?.mapView.annotations ?? [])
                
                self?.mapView.addOverlay(route.polyline)
                
                let sourceAnnotation = RouteAnnotation(coordinate: currentLocation, type: .source)
                let destinationAnnotation = RouteAnnotation(coordinate: destination, type: .destination)
                self?.mapView.addAnnotations([sourceAnnotation, destinationAnnotation])
                
                self?.mapView.setVisibleMapRect(
                    route.polyline.boundingMapRect,
                    edgePadding: UIEdgeInsets(top: 50, left: 20, bottom: 50, right: 20),
                    animated: true
                )
            }
        }
    }

    // address string
    func geocodeAddressString(_ addressString: String) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(addressString) { [weak self] placemarks, error in
            if let placeMark = placemarks?.first?.location?.coordinate {
                self?.builderRoute(to: placeMark)
            } else {
                guard let error else { return }
                print(error.localizedDescription)
            }
        }
    }
    
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

extension MapController: LocationManagerDelegate {
    func didUpdateLocation(_ location: CLLocationCoordinate2D) {
        self.currentLocation = location
        
        let region = MKCoordinateRegion(center: location, latitudinalMeters: 5000, longitudinalMeters: 5000)
        mapView.setRegion(region, animated: true)
        mapView.mapType = .hybridFlyover
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = "My Location"
        mapView.addAnnotation(annotation)
        
        if let destination = pendingDestination {
            builderRoute(to: destination)
            pendingDestination = nil
        }
    }
    
    func didFailWithError(_ error: any Error) {
        print("Error: \(error.localizedDescription)")
    }
}

extension MapController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        // Не обрабатываем пользовательскую аннотацию (где находится пользователь)
        guard !(annotation is MKUserLocation) else { return nil }

        // Определяем тип аннотации
        guard let routeAnnotation = annotation as? RouteAnnotation else { return nil }

        let identifier = "RouteAnnotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)

        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true // всплывающее окно
        } else {
            annotationView?.annotation = annotation
        }

        // Устанавливаем кастомную иконку 9,59319° С, 123,78396° В
        let imageName: String
        switch routeAnnotation.type {
        case .source:
            imageName = "icon-current-location"
        case .destination:
            imageName = "icon-destination"
        }

        if let image = UIImage(named: imageName) {
            annotationView?.image = image
            annotationView?.layer.shadowColor = UIColor.black.cgColor
            annotationView?.layer.shadowOffset = CGSize(width: 0, height: 2)
            annotationView?.layer.shadowOpacity = 0.3
            annotationView?.layer.shadowRadius = 3
        }

        // Убираем стандартный значок
        annotationView?.rightCalloutAccessoryView = nil

        return annotationView
    }
    
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
