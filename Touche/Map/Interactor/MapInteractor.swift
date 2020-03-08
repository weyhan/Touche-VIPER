//
//  MapInteractor.swift
//  Touche-VIPER
//
//  Created by weyhan.
//  Copyright © 2020 eccentricdeveloper. All rights reserved.
//

import Foundation
import CoreLocation

class MapInteractor: MapInteractorInputProtocol {

    // MARK: - Properties

    var locationService = LocationService()
    var geofences = Geofence.allGeofences()

    weak var presenter: MapInteractorOutputProtocol?
    let maxGeofence = 20    // iOS imposed number of geofence allowed per app

    // MARK: - Class Methods

    func findGeofence(withId id: String) -> Geofence? {
        for geofence in geofences {
            if geofence.identifier == id {
                return geofence
            }
        }

        return nil
    }

    func updateRegionDisplay(withCurrentCoordinate coordinate: CLLocationCoordinate2D) {
        let inGeofences = geofences.filter {
            let region = CLCircularRegion(center: $0.coordinate, radius: $0.radius, identifier: $0.identifier)
            return region.contains(coordinate)
        }

        let name = inGeofences.first?.location ?? "-"
        presenter?.update(region: name)
    }

    // MARK: - MapInteractorInputProtocol

    func retrieveGeofences() {
        if geofences.count != 0 {
            presenter?.didRetrieve(geofences: geofences)

            // Enable add button if number of geofence is below the iOS imposed limit
            presenter?.addGeofenceButton(isEnabled: geofences.count < maxGeofence)
        }
    }

    func saveGeofences() {
        Geofence.save(geofences: geofences)
        presenter?.addGeofenceButton(isEnabled: geofences.count < maxGeofence)
    }

    func remove(geofence: Geofence) {
        guard let index = geofences.firstIndex(of: geofence) else { return }
        geofences.remove(at: index)
        saveGeofences()

        stopMonitoring(geofence: geofence)

        guard let coordinate = locationService.location?.coordinate else { return }
        updateRegionDisplay(withCurrentCoordinate: coordinate)
    }

    func requestForLocationService() {
        locationService.requestAlwaysAuthorization()

        geofences.forEach { startMonitoring(geofence: $0) }
    }

    func startMonitoring(geofence: Geofence) {
        locationService.startMonitoring(geofence: geofence)
    }

    func stopMonitoring(geofence: Geofence) {
        locationService.stopMonitoring(geofence: geofence)
    }

    func startUpdatingLocation() {
        locationService.startUpdatingLocation()
    }

    func stopUpdatingLocation() {
        locationService.stopUpdatingLocation()
    }
}

extension MapInteractor: ConfigureGeofenceDelegate {

    func didAdd(geofence: Geofence) {
        geofences.append(geofence)
        saveGeofences()
        presenter?.add(geofence: geofence)
        startMonitoring(geofence: geofence)
    }

}

extension MapInteractor: MapDelegate {

    func locationUpdated(location: CLLocation) {
        updateRegionDisplay(withCurrentCoordinate: location.coordinate)
    }

}
