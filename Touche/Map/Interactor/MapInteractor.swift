//
//  MapInteractor.swift
//  Touche-VIPER
//
//  Created by weyhan.
//  Copyright © 2020 eccentricdeveloper. All rights reserved.
//

import Foundation
import CoreLocation
import Network

let endash = "–"

class MapInteractor: MapInteractorInputProtocol {

    // MARK: - Properties

    var locationService = LocationService()
    var wifiMonitor = NWPathMonitor(requiredInterfaceType: .wifi)

    var geofences = Geofence.allGeofences()

    weak var presenter: MapInteractorOutputProtocol?
    let maxGeofence = 20    // iOS imposed number of geofence allowed per app

    // MARK: - Class Methods

    fileprivate func findGeofence(withId id: String) -> Geofence? {
        for geofence in geofences {
            if geofence.identifier == id {
                return geofence
            }
        }

        return nil
    }

    // MARK: Startup routines

    fileprivate func retrieveGeofences() {
        if geofences.count != 0 {
            presenter?.didRetrieve(geofences: geofences)

            // Enable add button if number of geofence is below the iOS imposed limit
            presenter?.addGeofenceButton(isEnabled: geofences.count < maxGeofence)
        }
    }

    fileprivate func monitorWiFi() {
        wifiMonitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                self?.handleNetworkChanged()
            }
        }

        wifiMonitor.start(queue: DispatchQueue(label: "WiFiMonitor"))
    }

    // MARK: Location and network handlers

    fileprivate func handleLocationChanged(withCurrentCoordinate coordinate: CLLocationCoordinate2D) {
        let currentSsid = getWiFiSsid()

        let inGeofences = geofences.first {
            let region = CLCircularRegion(center: $0.coordinate, radius: $0.radius, identifier: $0.identifier)
            return region.contains(coordinate) || isSame(ssid1: currentSsid, ssid2: $0.ssid)
        }

        updateRegionDisplay(geofence: inGeofences, ssid: currentSsid)
    }

    fileprivate func handleNetworkChanged() {
        let currentSsid = getWiFiSsid()

        if let coordinate = locationService.location?.coordinate {
            handleLocationChanged(withCurrentCoordinate: coordinate)

        } else {
            // Update in/out region with WiFi connection alone if location data could not be obtained
            let inGeofences = geofences.first {
                return isSame(ssid1: currentSsid, ssid2: $0.ssid)
            }
            updateRegionDisplay(geofence: inGeofences, ssid: currentSsid)
        }
    }

    fileprivate func isSame(ssid1: String?, ssid2: String?) -> Bool {
        guard let ssid1 = ssid1, let ssid2 = ssid2 else { return false }
        return ssid1 == ssid2
    }

    fileprivate func updateRegionDisplay(geofence: Geofence?, ssid: String?) {
        let name = geofence?.location ?? endash
        let ssid = ssid ?? endash
        presenter?.update(region: name, ssid: ssid)
    }

    // MARK: - MapInteractorInputProtocol

    func startup() {
        retrieveGeofences()
        monitorWiFi()
    }

    func shutdown() {
        wifiMonitor.cancel()
    }

    func saveGeofences() {
        Geofence.save(geofences: geofences)
        presenter?.addGeofenceButton(isEnabled: geofences.count < maxGeofence)
    }

    func remove(geofence: Geofence) {
        guard let index = geofences.firstIndex(of: geofence) else { return }
        geofences.remove(at: index)
        saveGeofences()

        stopMonitoring(geofence: geofence)

        guard let coordinate = locationService.location?.coordinate else { return }
        handleLocationChanged(withCurrentCoordinate: coordinate)
    }

    func requestForLocationService() {
        locationService.requestAlwaysAuthorization()

        geofences.forEach { startMonitoring(geofence: $0) }
    }

    func startMonitoring(geofence: Geofence) {
        locationService.startMonitoring(geofence: geofence)
    }

    func stopMonitoring(geofence: Geofence) {
        locationService.stopMonitoring(geofence: geofence)
    }

    func startUpdatingLocation() {
        locationService.startUpdatingLocation()
    }

    func stopUpdatingLocation() {
        locationService.stopUpdatingLocation()
    }
}

// MARK: - ConfigureGeofenceDelegate

extension MapInteractor: ConfigureGeofenceDelegate {

    func didAdd(geofence: Geofence) {
        geofences.append(geofence)
        saveGeofences()
        presenter?.add(geofence: geofence)
        startMonitoring(geofence: geofence)
    }

}

// MARK: - MapDelegate

extension MapInteractor: MapDelegate {

    func locationUpdated(location: CLLocation) {
        handleLocationChanged(withCurrentCoordinate: location.coordinate)
    }

}
