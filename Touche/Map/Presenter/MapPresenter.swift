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

    func viewDidLoad() {
        interactor?.retrieveGeofences()
    }

    func showAddGeofence(region: MKCoordinateRegion) {
        wireFrame?.presentAddGeofenceScreen(from: view!, region: region)
    }

    // MARK: - MapInteractorOutputProtocol

    func centerMapAtUserLocation(on mapView: MKMapView) {
        mapView.centerMapAtUserLocation(latitude: 5000, longitude: 5000)
    }

    func didRetrieve(geofences: [Geofence]) {
        annotateMap(withGeofences: geofences)
    }

    func addGeofenceButton(isEnabled: Bool) {
        view?.addGeofenceButton(isEnabled: isEnabled)
    }

    func annotateMap(withGeofences geofences: [Geofence]) {
        view?.geofences.removeAll()
        geofences.forEach {
            view?.add(annotation: $0)
        }
    }

    func remove(geofence: Geofence) {
        view?.remove(geofence: geofence)
    }

    func save(geofences: [Geofence]) {
        interactor?.save(geofences: geofences)
    }

}

extension MapPresenter: ConfigureGeofenceDelegate {
    func didAdd(geofence: Geofence) {
        view?.add(annotation: geofence)
    }
}
