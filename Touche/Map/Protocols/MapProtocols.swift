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
    func showGeofence(region: MKCoordinateRegion)
}

protocol MapInteractorInputProtocol {

}

protocol MapInteractorOutputProtocol: class {
    func centerMapAtUserLocation(on mapView: MKMapView)
    
}

protocol MapWireFrameProtocol {
    func presentGeofenceScreen(from view: MapViewProtocol, region: MKCoordinateRegion)
}
