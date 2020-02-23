//
//  MapKit.swift
//  Touche-VIPER
//
//  Created by weyhan.
//  Copyright © 2020 eccentricdeveloper. All rights reserved.
//

import MapKit

extension MKMapView {
    func centerMapAtUserLocation(latitude: Double, longitude: Double) {
        guard let coordinate = userLocation.location?.coordinate else { return }
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: latitude, longitudinalMeters: longitude)
        setRegion(region, animated: true)
    }
}

