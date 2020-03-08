//
//  MapProtocols.swift
//  Touche-VIPER
//
//  Created by weyhan.
//  Copyright © 2020 eccentricdeveloper. All rights reserved.
//

import Foundation
import MapKit

protocol MapDelegate {
    func locationUpdated(location: CLLocation)
}

protocol MapViewProtocol: class {
    func addGeofenceButton(isEnabled: Bool) 
    func add(annotation: Geofence)
    func remove(geofence: Geofence)
    func update(region: String)
}

protocol MapPresenterProtocol: class {
    func viewDidLoad()
    func viewDidAppear(with mapView: MKMapView)
    func viewDidDisappear()
    func centerMapAtUserLocation(on mapView: MKMapView)
    func annotateMap(withGeofences geofences: [Geofence])
    func showAddGeofence(region: MKCoordinateRegion)
    func remove(geofence: Geofence)
}

protocol MapInteractorInputProtocol {
    func retrieveGeofences()
    func requestForLocationService()
    func remove(geofence: Geofence)
    func startMonitoring(geofence: Geofence)
    func stopMonitoring(geofence: Geofence)
    func startUpdatingLocation()
    func stopUpdatingLocation()
}

protocol MapInteractorOutputProtocol: class {
    func didRetrieve(geofences: [Geofence])
    func add(geofence: Geofence)
    func addGeofenceButton(isEnabled: Bool)
    func update(region: String)
}

protocol MapWireFrameProtocol {
    func presentAddGeofenceScreen(from view: MapViewProtocol, delegate: ConfigureGeofenceDelegate, region: MKCoordinateRegion)
}
