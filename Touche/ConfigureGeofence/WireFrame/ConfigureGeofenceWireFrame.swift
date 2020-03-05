//
//  ConfigureGeofenceWireFrame.swift
//  Touche-VIPER
//
//  Created by weyhan.
//  Copyright © 2020 eccentricdeveloper. All rights reserved.
//

import UIKit
import MapKit

public class ConfigureGeofenceWireFrame: ConfigureGeofenceWireFrameProtocol {

    // MARK: - Properties

    weak var navigationController: UINavigationController?

    // MARK: - Factory

    class func createGeofenceModule(with delegate: ConfigureGeofenceDelegate, region: MKCoordinateRegion, geofences: [Geofence]) -> UIViewController {
        let navigationController = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(identifier: "ConfigureGeofenceNavigationController")

        if let view = navigationController.children.first as? ConfigureGeofenceView {
            let presenter = ConfigureGeofencePresenter()

            view.presenter = presenter
            view.geofences = geofences
            presenter.view = view
            presenter.wireFrame = ConfigureGeofenceWireFrame()
            presenter.interactor = ConfigureGeofenceInteractor()

            let shrinkenSpan = MKCoordinateSpan(latitudeDelta: region.span.latitudeDelta / 2.7, longitudeDelta: region.span.longitudeDelta / 2.7)
            let shrinkedRegion = MKCoordinateRegion.init(center: region.center, span: shrinkenSpan)
            presenter.region = shrinkedRegion

            presenter.delegate = delegate

            return navigationController
        }

        return UIViewController()
    }

    // MARK: - ConfigureGeofenceWireFrameProtocol

}
