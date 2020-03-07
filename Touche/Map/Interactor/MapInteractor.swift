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

    weak var presenter: MapInteractorOutputProtocol?
    let maxGeofence = 20    // iOS imposed number of geofence allowed per app

    // MARK: - MapInteractorInputProtocol

    func retrieveGeofences() {
        let savedGeofences = Geofence.allGeofences()
        if savedGeofences.count != 0 {
            presenter?.didRetrieve(geofences: savedGeofences)

            // Enable add button if number of geofence is below the iOS imposed limit
            presenter?.addGeofenceButton(isEnabled: savedGeofences.count < maxGeofence)
        }
    }

    func save(geofences: [Geofence]) {
        Geofence.save(geofences: geofences)
        presenter?.addGeofenceButton(isEnabled: geofences.count < maxGeofence)
    }

}
