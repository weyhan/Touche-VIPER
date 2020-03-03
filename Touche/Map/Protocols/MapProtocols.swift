//
//  MapProtocols.swift
//  Touche-VIPER
//
//  Created by weyhan.
//  Copyright © 2020 eccentricdeveloper. All rights reserved.
//

import Foundation
import MapKit

protocol MapViewProtocol: class {
    var geofences: [Geofence] { get set }
}

protocol MapPresenterProtocol: class {
    func showAddGeofence(region: MKCoordinateRegion)
}

protocol MapInteractorInputProtocol {

}

protocol MapInteractorOutputProtocol: class {
    func centerMapAtUserLocation(on mapView: MKMapView)
    
}

protocol MapWireFrameProtocol {
    func presentAddGeofenceScreen(from view: MapViewProtocol, region: MKCoordinateRegion)
}
