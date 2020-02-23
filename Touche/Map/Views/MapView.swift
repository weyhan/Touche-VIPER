//
//  MapView.swift
//  Touche-VIPER
//
//  Created by weyhan.
//  Copyright © 2020 eccentricdeveloper. All rights reserved.
//

import UIKit
import MapKit

class MapView: UIViewController, MapViewProtocol {

    // MARK: - Properties
    @IBOutlet weak var mapView: MKMapView!

    var presenter: MapPresenterProtocol?

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - MapViewProtocol
}
