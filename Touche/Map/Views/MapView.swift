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

    @IBOutlet weak var addGeofenceButton: UIBarButtonItem!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var regionLabel: UILabel!
    @IBOutlet weak var ssidLabel: UILabel!
    
    var presenter: (MapPresenterProtocol & MapInteractorOutputProtocol)?

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()

        mapView.delegate = self
        presenter?.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        presenter?.viewDidAppear(with: mapView)
    }

    override func viewDidDisappear(_ animated: Bool) {
        presenter?.viewDidDisappear()
    }

    @IBAction func centerMapAtUserLocation(latitude: Double, longitude: Double) {
        presenter?.centerMapAtUserLocation(on: mapView)
    }

    @IBAction func addGeofence(_ sender: Any) {
        presenter?.showAddGeofence(region: mapView.region)
    }

    func removeRadiusOverlay(forGeofence geofence: Geofence) {
        for overlay in mapView.overlays {
            guard let overlayCircle = overlay as? MKCircle else { continue }
            let coordinate = overlayCircle.coordinate
            if coordinate.latitude == geofence.coordinate.latitude &&
                coordinate.longitude == geofence.coordinate.longitude &&
                overlayCircle.radius == geofence.radius {

                mapView.removeOverlay(overlayCircle)
                break
            }
        }
    }

    // MARK: - MapViewProtocol

    func addGeofenceButton(isEnabled: Bool){
        addGeofenceButton.isEnabled = isEnabled
    }

    func remove(geofence: Geofence) {
        mapView.removeAnnotation(geofence)
        removeRadiusOverlay(forGeofence: geofence)
        presenter?.remove(geofence: geofence)
    }

    func add(annotation geofence: Geofence) {
        mapView.addAnnotation(geofence)
        mapView.addOverlay(MKCircle(center: geofence.coordinate, radius: geofence.radius))
    }

    func edit(annotation geofence: Geofence) {
        presenter?.edit(region: mapView.region, geofence: geofence)
    }

    func update(region: String) {
        regionLabel.text = region
    }

    func update(ssid: String) {
        ssidLabel.text = ssid
    }

    func update(region: String, ssid: String) {
        regionLabel.text = region
        ssidLabel.text = ssid
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
                let removeButton = MapPinCalloutButton(type: .custom)
                removeButton.action = .remove
                removeButton.frame = CGRect(x: 0, y: 0, width: 23, height: 23)
                removeButton.setImage(UIImage(named: "RemoveButton")!, for: .normal)
                annotationView.leftCalloutAccessoryView = removeButton
                let editButton = MapPinCalloutButton(type: .custom)
                editButton.action = .edit
                editButton.frame = CGRect(x: 0, y: 0, width: 23, height: 23)
                editButton.setImage(UIImage(named: "EditButton"), for: .normal)
                annotationView.rightCalloutAccessoryView = editButton
            }

            annotationView.image = UIImage(named: "MapPin")

            return annotationView
        }

        return nil
    }

    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
      if overlay is MKCircle {
        let circleRenderer = MKCircleRenderer(overlay: overlay)
        circleRenderer.lineWidth = 2.0
        circleRenderer.strokeColor = UIColor.systemTeal.withAlphaComponent(0.5)
        circleRenderer.fillColor = UIColor.systemTeal.withAlphaComponent(0.1)
        return circleRenderer
      }
      return MKOverlayRenderer(overlay: overlay)
    }

    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
      let geofence = view.annotation as! Geofence
        if let mapButton = control as? MapPinCalloutButton, let action = mapButton.action {
            switch action {
            case .edit:
                edit(annotation: geofence)

            case .remove:
                remove(geofence: geofence)
            }
        }
    }
}
