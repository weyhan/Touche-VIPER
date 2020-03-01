//
//  GeofenceInteractor.swift
//  Touche-VIPER
//
//  Created by weyhan.
//  Copyright © 2020 eccentricdeveloper. All rights reserved.
//

import Foundation

class GeofenceInteractor: GeofenceInteractorInputProtocol {

    // MARK: - Properties

    weak var presenter: GeofenceInteractorOutputProtocol?

    // MARK: - GeofenceInteractorInputProtocol

    func save(geofences: [Geofence]) {
        let encoder = JSONEncoder()
        do {
          let data = try encoder.encode(geofences)
          UserDefaults.standard.set(data, forKey: PreferencesKeys.geofences)
        } catch {
          print("error encoding geotifications")
        }
    }
}
