//
//  ConfigureGeofenceInteractor.swift
//  Touche-VIPER
//
//  Created by weyhan.
//  Copyright © 2020 eccentricdeveloper. All rights reserved.
//

import Foundation
import MapKit

class ConfigureGeofenceInteractor: ConfigureGeofenceInteractorInputProtocol {

    // MARK: - Properties
    var editingGeofence: Geofence?
    var region: MKCoordinateRegion?
    var delegate: ConfigureGeofenceDelegate?

    weak var presenter: ConfigureGeofenceInteractorOutputProtocol?

    // MARK: - ConfigureGeofenceInteractorInputProtocol

    func setupFields() {
        if let geofence = editingGeofence {
            presenter?.set(ssid: geofence.ssid)
            presenter?.set(location: geofence.location)
            presenter?.set(radius: String(format: "%.0f", geofence.radius))
            presenter?.set(mode: .edit)

        } else {
            presenter?.set(ssid: nil)
            presenter?.set(location: nil)
            presenter?.set(radius: String(format: "%.0f", 20.0))
            presenter?.set(mode: .add)
        }

        presenter?.set(region: region)
    }

    func didAdd(geofence: Geofence) {
        delegate?.didAdd(geofence: geofence)
    }

    func didSave(geofence: Geofence) {
        delegate?.didSave(newGeofence: geofence, oldGeofence: editingGeofence!)
    }

}
