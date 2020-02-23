//
//  MapView.swift
//  Touche-VIPER
//
//  Created by weyhan.
//  Copyright © 2020 eccentricdeveloper. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapView: UIViewController, MapViewProtocol {

    // MARK: - Properties
    @IBOutlet weak var mapView: MKMapView!

    var presenter: (MapPresenterProtocol & MapInteractorOutputProtocol)?

    var locationManager = CLLocationManager()

    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager.requestAlwaysAuthorization()
        mapView.showsUserLocation = true
    }

    override func viewDidAppear(_ animated: Bool) {
        presenter?.centerMapAtUserLocation()
    }

    func centerMapAtUserLocation(latitude: Double, longitude: Double) {
        guard let coordinate = mapView.userLocation.location?.coordinate else { return }
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: latitude, longitudinalMeters: longitude)
        mapView.setRegion(region, animated: true)
    }

    // MARK: - MapViewProtocol
}
