//
//  MapProtocols.swift
//  Touche-VIPER
//
//  Created by weyhan.
//  Copyright © 2020 eccentricdeveloper. All rights reserved.
//

import Foundation
import MapKit

protocol MapViewProtocol: class {
    var geofences: [Geofence] { get set }

    func addGeofenceButton(isEnabled: Bool) 
    func add(annotation: Geofence)
    func remove(geofence: Geofence)
}

protocol MapPresenterProtocol: class {
    func viewDidLoad()
    func annotateMap(withGeofences geofences: [Geofence])
    func showAddGeofence(region: MKCoordinateRegion)
    func remove(geofence: Geofence)
    func save(geofences: [Geofence])
}

protocol MapInteractorInputProtocol {
    func retrieveGeofences()
    func save(geofences: [Geofence])
}

protocol MapInteractorOutputProtocol: class {
    func didRetrieve(geofences: [Geofence])
    func addGeofenceButton(isEnabled: Bool)
    func centerMapAtUserLocation(on mapView: MKMapView)
}

protocol MapWireFrameProtocol {
    func presentAddGeofenceScreen(from view: MapViewProtocol, region: MKCoordinateRegion)
}
