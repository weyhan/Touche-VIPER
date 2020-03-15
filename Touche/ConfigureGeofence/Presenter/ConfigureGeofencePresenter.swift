//
//  ConfigureGeofencePresenter.swift
//  Touche-VIPER
//
//  Created by weyhan.
//  Copyright © 2020 eccentricdeveloper. All rights reserved.
//

import Foundation
import MapKit

class ConfigureGeofencePresenter: ConfigureGeofencePresenterProtocol, ConfigureGeofenceInteractorOutputProtocol {

    // MARK: - Properties

    weak var view: ConfigureGeofenceViewProtocol?
    var interactor: ConfigureGeofenceInteractorInputProtocol?
    var wireFrame: ConfigureGeofenceWireFrameProtocol?

    // MARK: - ConfigureGeofencePresenterProtocol

    func viewDidLoad() {
        interactor?.setupFields()
    }

    func cancelConfigureGeofence() {
        if let configureGeofenceView = view as? UIViewController {
            configureGeofenceView.dismiss(animated: true)
        }
    }

    func textFieldEditingChanged(location: String?, radius: String?, ssid: String?) {
        guard let location = location, location != "", let radius = radius, radius != "", let ssid = ssid, ssid != "" else {
            view?.setAddButton(state: .disabled)
            return
        }

        view?.setAddButton(state: .enabled)
    }

    func radiusTextField(shouldChange text: String?, range: NSRange, string: String) -> Bool {
        if let text = text, text.count != 0, let projectedTextRange = Range(range, in: text), string.count != 0 {
            var projectedText = text

            if range.length == 0 {
                projectedText.insert(contentsOf: string, at: projectedText.index(projectedText.startIndex, offsetBy: range.location))

            } else {
                projectedText.replaceSubrange(projectedTextRange, with: string)
            }

            do {
                let regex = try NSRegularExpression(pattern: "\\A(\\d+[.,]{0,1}\\d{0,2})\\z", options: [])
                let results = regex.matches(in: projectedText, options: [], range: NSRange(location: 0, length: projectedText.count))

                return !results.isEmpty

            } catch let error {
                print("invalid regex: \(error.localizedDescription)")
            }
        }
        return true
    }

    func add(geofence: Geofence) {
        guard let view = view as? UIViewController else { return }
        view.dismiss(animated: true)

        interactor?.didAdd(geofence: geofence)
    }

    func save(geofence: Geofence) {
        guard let view = view as? UIViewController else { return }
        view.dismiss(animated: true)

        interactor?.didSave(geofence: geofence)
    }

    // MARK: - ConfigureGeofenceInteractorOutputProtocol

    func set(ssid: String?) {
        view?.set(ssid: ssid)
    }

    func set(location: String?) {
        view?.set(location: location)
    }

    func set(radius: String?) {
        view?.set(radius: radius)
    }

    func set(region: MKCoordinateRegion?) {
        view?.region = region
    }

    func set(mode: AddEditMode) {
        view?.set(mode: mode)
    }
}
