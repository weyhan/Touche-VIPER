//
//  ConfigureGeofenceProtocols.swift
//  Touche-VIPER
//
//  Created by weyhan.
//  Copyright © 2020 eccentricdeveloper. All rights reserved.
//

import Foundation
import MapKit

protocol ConfigureGeofenceDelegate: class {
    func didAdd(geofence: Geofence)
}

protocol ConfigureGeofenceViewProtocol: class {
    var geofences: [Geofence] { get set }
    var radius: String? { get set }
    var region: MKCoordinateRegion? { get set }
}

protocol ConfigureGeofencePresenterProtocol: class {
    var region: MKCoordinateRegion? { get set }
    var delegate: ConfigureGeofenceDelegate? { get set }

    func viewDidLoad()
    func cancelConfigureGeofence()
}

protocol ConfigureGeofenceInteractorInputProtocol {
    func save(geofences: [Geofence])
}

protocol ConfigureGeofenceInteractorOutputProtocol: class {
    func add(geofence: Geofence)
}

protocol ConfigureGeofenceWireFrameProtocol {
    static func createGeofenceModule(with: ConfigureGeofenceDelegate, region: MKCoordinateRegion, geofences: [Geofence]) -> UIViewController
}
