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

    // MARK: - ConfigureGeofenceWireFrameProtocol

    class func createGeofenceModule(with delegate: ConfigureGeofenceDelegate, region: MKCoordinateRegion) -> UIViewController {
        return createGeofenceModule(with: delegate, region: region, geofence: nil)
    }

    class func createGeofenceModule(with delegate: ConfigureGeofenceDelegate, region: MKCoordinateRegion, geofence: Geofence?) -> UIViewController {
        let navigationController = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(identifier: "ConfigureGeofenceNavigationController")

        if let view = navigationController.children.first as? ConfigureGeofenceView {
            let presenter = ConfigureGeofencePresenter()
            let interactor = ConfigureGeofenceInteractor()

            view.presenter = presenter
            presenter.view = view
            presenter.wireFrame = ConfigureGeofenceWireFrame()
            presenter.interactor = interactor

            let shrinkenSpan = MKCoordinateSpan(latitudeDelta: region.span.latitudeDelta / 2.7, longitudeDelta: region.span.longitudeDelta / 2.7)
            let shrinkedRegion = MKCoordinateRegion.init(center: region.center, span: shrinkenSpan)
            interactor.region = shrinkedRegion
            interactor.presenter = presenter
            interactor.editingGeofence = geofence
            interactor.delegate = delegate

            return navigationController
        }

        return UIViewController()
    }

}
