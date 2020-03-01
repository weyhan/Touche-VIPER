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
    @IBOutlet weak var location: UITextField!
    @IBOutlet weak var radiusTextField: RadiusTextField!

    var presenter: (GeofencePresenterProtocol & GeofenceInteractorOutputProtocol)?
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
        geofences.append(geofence)
        presenter?.add(geofence: geofence)
    }

    @IBAction func cancelAddGeofence(_ sender: UIBarButtonItem) {
        presenter?.cancelAddGeofence()
    }

    // MARK: - GeofenceViewProtocol
}
