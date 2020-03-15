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

enum AddEditMode {
    case add
    case edit
}

protocol ConfigureGeofenceDelegate: class {
    func didAdd(geofence: Geofence)
    func didSave(newGeofence: Geofence, oldGeofence: Geofence)
}

protocol ConfigureGeofenceViewProtocol: class {
    var region: MKCoordinateRegion? { get set }

    func setAddButton(state: FieldState)
    func set(ssid: String?)
    func set(location: String?)
    func set(radius: String?)
    func set(mode: AddEditMode)
}

protocol ConfigureGeofencePresenterProtocol: class {
    func viewDidLoad()
    func cancelConfigureGeofence()
    func textFieldEditingChanged(location: String?, radius: String?, ssid: String?)
    func radiusTextField(shouldChange text: String?, range: NSRange, string: String) -> Bool
    func add(geofence: Geofence)
    func save(geofence: Geofence)
}

protocol ConfigureGeofenceInteractorInputProtocol {
    var delegate: ConfigureGeofenceDelegate? { get set }
    var editingGeofence: Geofence? { get set }
    var region: MKCoordinateRegion? { get set }

    func setupFields()
    func didAdd(geofence: Geofence)
    func didSave(geofence: Geofence)
}

protocol ConfigureGeofenceInteractorOutputProtocol: class {
    func set(ssid: String?)
    func set(location: String?)
    func set(radius: String?)
    func set(region: MKCoordinateRegion?)
    func set(mode: AddEditMode)
}

protocol ConfigureGeofenceWireFrameProtocol {
    static func createGeofenceModule(with: ConfigureGeofenceDelegate, region: MKCoordinateRegion) -> UIViewController
    static func createGeofenceModule(with: ConfigureGeofenceDelegate, region: MKCoordinateRegion, geofence: Geofence?) -> UIViewController
}
