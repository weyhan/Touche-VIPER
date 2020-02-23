//
//  MapWireFrame.swift
//  Touche-VIPER
//
//  Created by weyhan.
//  Copyright © 2020 eccentricdeveloper. All rights reserved.
//

import UIKit

public class MapWireFrame: MapWireFrameProtocol {

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

}
