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

    @IBOutlet weak var addButton: UIBarButtonItem!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var ssidTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var radiusTextField: RadiusTextField!

    var presenter: (ConfigureGeofencePresenterProtocol & ConfigureGeofenceInteractorOutputProtocol)?
    var region: MKCoordinateRegion?
    var viewMode: AddEditMode = .add

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()

        mapView.region = region!

        radiusTextField.delegate = self

        addButton.isEnabled = false
        locationTextField.addTarget(self, action: #selector(textFieldEditingChange(_:)), for: .editingChanged)
        radiusTextField.addTarget(self, action: #selector(textFieldEditingChange(_:)), for: .editingChanged)
        ssidTextField.addTarget(self, action: #selector(textFieldEditingChange(_:)), for: .editingChanged)
    }

    @IBAction func addGeofence(_ sender: UIBarButtonItem) {
        let coordinate = mapView.centerCoordinate
        let radius = Double(radiusTextField.text!) ?? 0
        let identifier = UUID().uuidString
        let location = self.locationTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let ssid = ssidTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)

        let geofence = Geofence(coordinate: coordinate, radius: radius, identifier: identifier, location: location, ssid: ssid)
        presenter?.add(geofence: geofence)
    }

    @IBAction func saveGeofence(_ sender: Any) {
        let coordinate = mapView.centerCoordinate
        let radius = Double(radiusTextField.text!) ?? 0
        let identifier = ""
        let location = self.locationTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let ssid = ssidTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)

        let geofence = Geofence(coordinate: coordinate, radius: radius, identifier: identifier, location: location, ssid: ssid)
        presenter?.save(geofence: geofence)
    }

    @IBAction func cancelConfigureGeofence(_ sender: UIBarButtonItem) {
        presenter?.cancelConfigureGeofence()
    }

    // MARK: - Target selectors

    @objc func textFieldEditingChange(_ textField: UITextField) {
        presenter?.textFieldEditingChanged(location: locationTextField.text, radius: radiusTextField.text, ssid: ssidTextField.text)
    }

    // MARK: - ConfigureGeofenceViewProtocol

    func setAddButton(state: FieldState) {
        switch viewMode {
        case .add:
            addButton.isEnabled = (state == .enabled)

        case .edit:
            saveButton.isEnabled = (state == .enabled)
        }
    }

    func set(ssid: String?) {
        ssidTextField.text = ssid
    }

    func set(location: String?) {
        locationTextField.text = location
    }

    func set(radius: String?) {
        radiusTextField.text = radius
    }

    func set(mode: AddEditMode) {
        viewMode = mode

        switch mode {
        case .add:
            saveButton.isEnabled = false
            saveButton.title = nil

        case .edit:
            addButton.isEnabled = false
            addButton.title = nil
        }
    }
}

// MARK: - UITextFieldDelegate

extension ConfigureGeofenceView: UITextFieldDelegate {

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let presenter = presenter, let text = textField.text else {
            return true
        }

        if textField is RadiusTextField {
            return presenter.radiusTextField(shouldChange: text, range: range, string: string)
        }

        return true
    }

}
