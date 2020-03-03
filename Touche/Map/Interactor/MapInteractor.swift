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

    // MARK: - MapInteractorInputProtocol

    func retrieveGeofences() {
        let savedGeofences = Geofence.allGeofences()
        if savedGeofences.count != 0 {
            presenter?.didRetrieve(geofences: savedGeofences)
        }
    }

    func save(geofences: [Geofence]) {
        Geofence.save(geofences: geofences)
    }

}
