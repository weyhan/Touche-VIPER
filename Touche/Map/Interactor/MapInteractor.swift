//
//  MapInteractor.swift
//  Touche-VIPER
//
//  Created by weyhan.
//  Copyright © 2020 eccentricdeveloper. All rights reserved.
//

import Foundation

class MapInteractor: MapInteractorInputProtocol {

    // MARK: - Properties

    var geofences = Geofence.allGeofences()

    weak var presenter: MapInteractorOutputProtocol?
    let maxGeofence = 20    // iOS imposed number of geofence allowed per app

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
    }

}

extension MapInteractor: ConfigureGeofenceDelegate {

    func didAdd(geofence: Geofence) {
        geofences.append(geofence)
        saveGeofences()
        presenter?.add(geofence: geofence)
    }

}
