//
//  GeofenceWireFrame.swift
//  Touche-VIPER
//
//  Created by weyhan.
//  Copyright © 2020 eccentricdeveloper. All rights reserved.
//

import UIKit
import MapKit

public class GeofenceWireFrame: GeofenceWireFrameProtocol {

    // MARK: - Properties

    weak var navigationController: UINavigationController?

    // MARK: - Factory

    class func createGeofenceModule(region: MKCoordinateRegion) -> UIViewController {
        let navigationController = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(identifier: "AddGeofenceNavigationController")

        if let view = navigationController.children.first as? GeofenceView {
            let presenter = GeofencePresenter()

            view.presenter = presenter
            presenter.view = view
            presenter.wireFrame = GeofenceWireFrame()
            presenter.interactor = GeofenceInteractor()
            presenter.region = region

            return navigationController
        }

        return UIViewController()
    }

    // MARK: - GeofenceWireFrameProtocol

}
