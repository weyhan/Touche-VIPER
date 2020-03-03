//
//  ConfigureGeofencePresenter.swift
//  Touche-VIPER
//
//  Created by weyhan.
//  Copyright © 2020 eccentricdeveloper. All rights reserved.
//

import Foundation
import MapKit

class ConfigureGeofencePresenter: ConfigureGeofencePresenterProtocol, ConfigureGeofenceInteractorOutputProtocol {

    // MARK: - Properties

    weak var view: ConfigureGeofenceViewProtocol?
    var interactor: ConfigureGeofenceInteractorInputProtocol?
    var wireFrame: ConfigureGeofenceWireFrameProtocol?
    var region: MKCoordinateRegion?
    var delegate: ConfigureGeofenceDelegate?

    // MARK: - ConfigureGeofencePresenterProtocol

    func viewDidLoad() {
        view?.region = region
        view?.radius = String(format: "%.0f", 20.0)
    }

    func cancelConfigureGeofence() {
        if let configureGeofenceView = view as? UIViewController {
            configureGeofenceView.dismiss(animated: true)
        }
    }

    // MARK: - ConfigureGeofenceInteractorOutputProtocol

    func add(geofence: Geofence) {
        guard let view = view as? ConfigureGeofenceView else { return }

        var geofences = view.geofences
        geofences.append(geofence)
        interactor?.save(geofences: geofences)
        view.dismiss(animated: true)

        delegate?.didAdd(geofence: geofence)
    }
}
