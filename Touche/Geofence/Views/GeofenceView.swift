//
//  GeofenceView.swift
//  Touche-VIPER
//
//  Created by weyhan.
//  Copyright © 2020 eccentricdeveloper. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class GeofenceView: UITableViewController, GeofenceViewProtocol {

    // MARK: - Properties

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var radiusTextField: RadiusTextField!

    var presenter: GeofencePresenterProtocol?
    var radius: String?
    var region: MKCoordinateRegion?

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()

        mapView.region = region!
        radiusTextField.text = radius
    }

    // MARK: - GeofenceViewProtocol

}
