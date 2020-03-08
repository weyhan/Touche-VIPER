//
//  LocationService.swift
//  Touche-VIPER
//
//  Created by weyhan.
//  Copyright © 2020 eccentricdeveloper. All rights reserved.
//

import Foundation
import CoreLocation

enum tripDirection {
    case enter
    case exit
}

class LocationService: NSObject {

    private var locationManager = CLLocationManager()
    var delegate: MapDelegate!

    var location: CLLocation? {
        return locationManager.location
    }

    override init() {
        super.init()

        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        locationManager.pausesLocationUpdatesAutomatically = true
    }

    func requestAlwaysAuthorization() {
        locationManager.requestAlwaysAuthorization()
    }

    func startMonitoring(geofence: Geofence) {
        if !CLLocationManager.isMonitoringAvailable(for: CLCircularRegion.self) {
            return
        }

        let fenceRegion = CLCircularRegion(center: geofence.coordinate, radius: geofence.radius, identifier: geofence.identifier)
        fenceRegion.notifyOnEntry = true
        fenceRegion.notifyOnExit = true
        locationManager.startMonitoring(for: fenceRegion)
    }

    func stopMonitoring(geofence: Geofence) {
        locationManager.monitoredRegions.forEach {
            guard let circularRegion = $0 as? CLCircularRegion, circularRegion.identifier == geofence.identifier else { return }
            locationManager.stopMonitoring(for: circularRegion)
        }
    }

    func startUpdatingLocation() {
        locationManager.startUpdatingLocation()
    }

    func stopUpdatingLocation() {
        locationManager.stopUpdatingLocation()
    }
}

extension LocationService: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        delegate.locationUpdated(location: location)
    }

}
