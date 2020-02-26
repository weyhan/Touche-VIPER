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
    var radius: String? { get set }
    var region: MKCoordinateRegion? { get set }
}

protocol GeofencePresenterProtocol: class {
    var region: MKCoordinateRegion? { get set }

    func viewDidLoad()
}

protocol GeofenceInteractorInputProtocol {

}

protocol GeofenceInteractorOutputProtocol: class {

}

protocol GeofenceWireFrameProtocol {
    static func createGeofenceModule(region: MKCoordinateRegion) -> UIViewController
}
