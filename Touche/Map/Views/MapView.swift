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
        presenter?.centerMapAtUserLocation(on: mapView)
    }

    @IBAction func centerMapAtUserLocation(latitude: Double, longitude: Double) {
        presenter?.centerMapAtUserLocation(on: mapView)
    }

    // MARK: - MapViewProtocol
}
