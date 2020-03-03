//
//  ConfigureGeofenceInteractor.swift
//  Touche-VIPER
//
//  Created by weyhan.
//  Copyright © 2020 eccentricdeveloper. All rights reserved.
//

import Foundation

class ConfigureGeofenceInteractor: ConfigureGeofenceInteractorInputProtocol {

    // MARK: - Properties

    weak var presenter: ConfigureGeofenceInteractorOutputProtocol?

    // MARK: - ConfigureGeofenceInteractorInputProtocol

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
