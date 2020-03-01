//
//  MapPresenter.swift
//  Touche-VIPER
//
//  Created by weyhan.
//  Copyright © 2020 eccentricdeveloper. All rights reserved.
//

import Foundation
import MapKit

class MapPresenter: MapPresenterProtocol, MapInteractorOutputProtocol {

    // MARK: - Properties

    weak var view: MapViewProtocol?
    var interactor: MapInteractorInputProtocol?
    var wireFrame: MapWireFrameProtocol?

    // MARK: - MapPresenterProtocol

    func showGeofence(region: MKCoordinateRegion) {
        wireFrame?.presentGeofenceScreen(from: view!, region: region)
    }

    // MARK: - MapInteractorOutputProtocol

    func centerMapAtUserLocation(on mapView: MKMapView) {
        mapView.centerMapAtUserLocation(latitude: 5000, longitude: 5000)
    }

    func didRetrieveGeofences(geofences: [Geofence]) {

    }
}
