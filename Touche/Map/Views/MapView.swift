//
//  MapView.swift
//  Touche-VIPER
//
//  Created by weyhan.
//  Copyright © 2020 eccentricdeveloper. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapView: UIViewController, MapViewProtocol {

    // MARK: - Properties

    @IBOutlet weak var mapView: MKMapView!

    var presenter: (MapPresenterProtocol & MapInteractorOutputProtocol)?

    var locationManager = CLLocationManager()
    var geofences = [Geofence]()

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self

        presenter?.viewDidLoad()

        locationManager.requestAlwaysAuthorization()
        mapView.showsUserLocation = true
    }

    override func viewDidAppear(_ animated: Bool) {
        presenter?.centerMapAtUserLocation(on: mapView)
    }

    @IBAction func centerMapAtUserLocation(latitude: Double, longitude: Double) {
        presenter?.centerMapAtUserLocation(on: mapView)
    }

    @IBAction func addGeofence(_ sender: Any) {
        presenter?.showAddGeofence(region: mapView.region)
    }

    // MARK: - MapViewProtocol

    func remove(geofence: Geofence) {
        guard let index = geofences.firstIndex(of: geofence) else { return }
        geofences.remove(at: index)
        mapView.removeAnnotation(geofence)

        presenter?.save(geofences: geofences)
    }

    func add(annotation geofence: Geofence) {
        geofences.append(geofence)
        mapView.addAnnotation(geofence)
    }

}

// MARK: - MKMapViewDelegate

extension MapView: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "mapPin"
        if annotation is Geofence {
            var annotationView: MKAnnotationView
            if let view = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) {
                annotationView = view
                view.annotation = annotation

            } else {
                annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                annotationView.canShowCallout = true
                let removeButton = UIButton(type: .custom)
                removeButton.frame = CGRect(x: 0, y: 0, width: 23, height: 23)
                removeButton.setImage(UIImage(named: "RemoveButton")!, for: .normal)
                annotationView.leftCalloutAccessoryView = removeButton
            }

            annotationView.image = UIImage(named: "MapPin")

            return annotationView
        }

        return nil
    }

    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
      // Delete geofence
      let geofence = view.annotation as! Geofence
        remove(geofence: geofence)
    }
}
