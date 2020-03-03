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

            view.presenter = presenter
            presenter.view = view
            presenter.wireFrame = MapWireFrame()
            presenter.interactor = MapInteractor()

            return navigationController
        }

        return UIViewController()
    }

    // MARK: - MapWireFrameProtocol

    func presentAddGeofenceScreen(from view: MapViewProtocol, region: MKCoordinateRegion) {
        guard let sourceView = view as? MapView else { return }

        let navigationController = ConfigureGeofenceWireFrame.createGeofenceModule(region: region, geofences: view.geofences)

        if let addGeofenceView = navigationController.children.first as? ConfigureGeofenceView {
            addGeofenceView.modalPresentationStyle = .overCurrentContext

            sourceView.present(navigationController, animated: true)
        }
    }

}
