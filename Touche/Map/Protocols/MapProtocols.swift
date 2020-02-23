//
//  MapProtocols.swift
//  Touche-VIPER
//
//  Created by weyhan.
//  Copyright © 2020 eccentricdeveloper. All rights reserved.
//

import Foundation

protocol MapViewProtocol: class {
    func centerMapAtUserLocation(latitude: Double, longitude: Double)
}

protocol MapPresenterProtocol: class {

}

protocol MapInteractorInputProtocol {

}

protocol MapInteractorOutputProtocol: class {
    func centerMapAtUserLocation()
}

protocol MapWireFrameProtocol {

}
