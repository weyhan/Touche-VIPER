//
//  ConfigureGeofenceView.swift
//  Touche-VIPER
//
//  Created by weyhan.
//  Copyright © 2020 eccentricdeveloper. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class ConfigureGeofenceView: UITableViewController, ConfigureGeofenceViewProtocol {

    // MARK: - Properties

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var location: UITextField!
    @IBOutlet weak var radiusTextField: RadiusTextField!

    var presenter: (ConfigureGeofencePresenterProtocol & ConfigureGeofenceInteractorOutputProtocol)?
    var radius: String?
    var region: MKCoordinateRegion?
    var geofences = [Geofence]()

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()

        mapView.region = region!
        radiusTextField.text = radius
    }

    @IBAction func addGeofence(_ sender: UIBarButtonItem) {
        let coordinate = mapView.centerCoordinate
        let radius = Double(radiusTextField.text!) ?? 0
        let identifier = UUID().uuidString
        let location = self.location.text!.trimmingCharacters(in: .whitespacesAndNewlines)

        let geofence = Geofence(coordinate: coordinate, radius: radius, identifier: identifier, location: location, ssid: "")
        presenter?.add(geofence: geofence)
    }

    @IBAction func cancelConfigureGeofence(_ sender: UIBarButtonItem) {
        presenter?.cancelConfigureGeofence()
    }

    // MARK: - ConfigureGeofenceViewProtocol

}
