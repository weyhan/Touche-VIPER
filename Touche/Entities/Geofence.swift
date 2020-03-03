//
//  Geofence.swift
//  Touche-VIPER
//
//  Created by weyhan.
//  Copyright © 2020 eccentricdeveloper. All rights reserved.
//

import Foundation
import MapKit
import CoreLocation

struct PreferencesKeys {
    static let geofences = "geofences"
}

class Geofence: NSObject, Codable, MKAnnotation {

    enum CodingKeys: String, CodingKey {
        case latitude, longitude, radius, identifier, location, ssid
    }

    var coordinate: CLLocationCoordinate2D
    var radius: CLLocationDistance
    var identifier: String
    var location: String
    var ssid: String

    var title: String? { location }
    var subtitle: String? { "Radious: \(radius)m" }

    init(coordinate: CLLocationCoordinate2D, radius: CLLocationDistance, identifier: String, location: String, ssid: String) {
        self.coordinate = coordinate
        self.radius = radius
        self.identifier = identifier
        self.location = location
        self.ssid = ssid
    }

    // MARK: - Codable
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let latitude = try values.decode(Double.self, forKey: .latitude)
        let longitude = try values.decode(Double.self, forKey: .longitude)
        coordinate = CLLocationCoordinate2DMake(latitude, longitude)
        radius = try values.decode(Double.self, forKey: .radius)
        identifier = try values.decode(String.self, forKey: .identifier)
        location = try values.decode(String.self, forKey: .location)
        ssid = try values.decode(String.self, forKey: .ssid)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(coordinate.latitude, forKey: .latitude)
        try container.encode(coordinate.longitude, forKey: .longitude)
        try container.encode(radius, forKey: .radius)
        try container.encode(identifier, forKey: .identifier)
        try container.encode(location, forKey: .location)
        try container.encode(ssid, forKey: .ssid)
    }
}

extension Geofence {
    public class func allGeofences() -> [Geofence] {
        guard let savedGeofences = UserDefaults.standard.data(forKey: PreferencesKeys.geofences) else { return [] }
        let decoder = JSONDecoder()
        if let savedGeofences = try? decoder.decode(Array.self, from: savedGeofences) as [Geofence] {
            return savedGeofences
        }
        return []
    }

    public class func save(geofences: [Geofence]) {
        let encoder = JSONEncoder()
        do {
          let data = try encoder.encode(geofences)
          UserDefaults.standard.set(data, forKey: PreferencesKeys.geofences)

        } catch {
          print("error encoding geofences")
        }
    }
}
