//
//  MapPresenter.swift
//  Touche-VIPER
//
//  Created by weyhan.
//  Copyright © 2020 eccentricdeveloper. All rights reserved.
//

import Foundation

class MapPresenter: MapPresenterProtocol, MapInteractorOutputProtocol {

    // MARK: - Properties

    weak var view: MapViewProtocol?
    var interactor: MapInteractorInputProtocol?
    var wireFrame: MapWireFrameProtocol?

    // MARK: - MapPresenterProtocol

    // MARK: - MapInteractorOutputProtocol
    func centerMapAtUserLocation() {
        view?.centerMapAtUserLocation(latitude: 5000, longitude: 5000)
    }
}
