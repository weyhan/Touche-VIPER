//
//  GeofencePresenter.swift
//  Touche-VIPER
//
//  Created by weyhan.
//  Copyright © 2020 eccentricdeveloper. All rights reserved.
//

import Foundation
import MapKit

class GeofencePresenter: GeofencePresenterProtocol, GeofenceInteractorOutputProtocol {

    // MARK: - Properties

    weak var view: GeofenceViewProtocol?
    var interactor: GeofenceInteractorInputProtocol?
    var wireFrame: GeofenceWireFrameProtocol?
    var region: MKCoordinateRegion?

    // MARK: - GeofencePresenterProtocol

    func viewDidLoad() {
        view?.region = region
        view?.radius = String(format: "%.0f", 20.0)
    }

    func cancelAddGeofence() {
        if let geofenceView = view as? UIViewController {
            geofenceView.dismiss(animated: true)
        }
    }

    // MARK: - GeofenceInteractorOutputProtocol

    func add(geofence: Geofence) {
        guard let view = view as? GeofenceView else { return }

        var geofences = view.geofences
        geofences.append(geofence)
        interactor?.save(geofences: geofences)
        view.dismiss(animated: true)
    }
}
