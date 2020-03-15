//
//  MapWireFrame.swift
//  Touche-VIPER
//
//  Created by weyhan.
//  Copyright © 2020 eccentricdeveloper. All rights reserved.
//

import UIKit
import MapKit

public class MapWireFrame: MapWireFrameProtocol {

    // MARK: - Properties

    // MARK: - Factory

    class func createMapModule() -> UIViewController {
        let navigationController = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(identifier: "MapNavigationController")

        if let view = navigationController.children.first as? MapView {
            let presenter = MapPresenter()
            let interactor = MapInteractor()
            let locationService = LocationService()

            view.presenter = presenter
            interactor.presenter = presenter
            locationService.delegate = interactor
            interactor.locationService = locationService
            presenter.view = view
            presenter.wireFrame = MapWireFrame()
            presenter.interactor = interactor

            return navigationController
        }

        return UIViewController()
    }

    // MARK: - MapWireFrameProtocol

    func presentAddGeofenceScreen(from view: MapViewProtocol, delegate: ConfigureGeofenceDelegate, region: MKCoordinateRegion) {
        guard let sourceView = view as? MapView else { return }

        let navigationController = ConfigureGeofenceWireFrame.createGeofenceModule(with: delegate, region: region)

        if let addGeofenceView = navigationController.children.first as? ConfigureGeofenceView {
            addGeofenceView.modalPresentationStyle = .overCurrentContext

            sourceView.present(navigationController, animated: true)
        }
    }

    func presentEditGeofenceScreen(from view: MapViewProtocol, delegate: ConfigureGeofenceDelegate, region: MKCoordinateRegion, geofence: Geofence) {
        guard let sourceView = view as? MapView else { return }

        let navigationController = ConfigureGeofenceWireFrame.createGeofenceModule(with: delegate, region: region, geofence: geofence)

        if let editGeofenceView = navigationController.children.first as? ConfigureGeofenceView {
            editGeofenceView.modalPresentationStyle = .overCurrentContext

            sourceView.present(navigationController, animated: true)
        }
    }
}
