//
//  GeofenceProtocols.swift
//  Touche-VIPER
//
//  Created by weyhan.
//  Copyright © 2020 eccentricdeveloper. All rights reserved.
//

import Foundation
import MapKit

protocol GeofenceViewProtocol: class {
    var geofences: [Geofence] { get set }
    var radius: String? { get set }
    var region: MKCoordinateRegion? { get set }
}

protocol GeofencePresenterProtocol: class {
    var region: MKCoordinateRegion? { get set }

    func viewDidLoad()
    func cancelAddGeofence()
}

protocol GeofenceInteractorInputProtocol {
    func save(geofences: [Geofence])
}

protocol GeofenceInteractorOutputProtocol: class {
    func add(geofence: Geofence)
}

protocol GeofenceWireFrameProtocol {
    static func createGeofenceModule(region: MKCoordinateRegion, geofences: [Geofence]) -> UIViewController
}
