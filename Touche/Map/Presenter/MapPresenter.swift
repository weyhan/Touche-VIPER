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
    var interactor: (MapInteractorInputProtocol & ConfigureGeofenceDelegate)?
    var wireFrame: MapWireFrameProtocol?

    // MARK: - MapPresenterProtocol

    func viewDidLoad() {
        interactor?.retrieveGeofences()
    }

    func centerMapAtUserLocation(on mapView: MKMapView) {
        mapView.centerMapAtUserLocation(latitude: 5000, longitude: 5000)
    }

    func annotateMap(withGeofences geofences: [Geofence]) {
        geofences.forEach {
            view?.add(annotation: $0)
        }
    }

    func showAddGeofence(region: MKCoordinateRegion) {
        wireFrame?.presentAddGeofenceScreen(from: view!, delegate: interactor!, region: region)
    }

    func remove(geofence: Geofence) {
        interactor?.remove(geofence: geofence)
    }

    // MARK: - MapInteractorOutputProtocol

    func didRetrieve(geofences: [Geofence]) {
        annotateMap(withGeofences: geofences)
    }

    func add(geofence: Geofence) {
        view?.add(annotation: geofence)
    }

    func addGeofenceButton(isEnabled: Bool) {
        view?.addGeofenceButton(isEnabled: isEnabled)
    }

}
