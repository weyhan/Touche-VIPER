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

}

protocol MapPresenterProtocol: class {

}

protocol MapInteractorInputProtocol {

}

protocol MapInteractorOutputProtocol: class {
    func centerMapAtUserLocation(on mapView: MKMapView)
}

protocol MapWireFrameProtocol {

}
