//
//  ConfigureGeofenceProtocols.swift
//  Touche-VIPER
//
//  Created by weyhan.
//  Copyright © 2020 eccentricdeveloper. All rights reserved.
//

import Foundation
import MapKit

enum FieldState {
    case enabled
    case disabled
}

protocol ConfigureGeofenceDelegate: class {
    func didAdd(geofence: Geofence)
}

protocol ConfigureGeofenceViewProtocol: class {
    var geofences: [Geofence] { get set }
    var radius: String? { get set }
    var region: MKCoordinateRegion? { get set }

    func setAddButton(state: FieldState)
}

protocol ConfigureGeofencePresenterProtocol: class {
    var region: MKCoordinateRegion? { get set }
    var delegate: ConfigureGeofenceDelegate? { get set }

    func viewDidLoad()
    func cancelConfigureGeofence()
    func textFieldEditingChanged(location: String?, radius: String?)
nce/Protocols/AddGeofenceProtocols.swift
    func radiusTextField(shouldChange text: String?, range: NSRange, string: String) -> Bool
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
