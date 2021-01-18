//
//  Location.swift
//  InventoryManager
//
//  Created by Ryan Mackin on 12/11/20.
//

import Foundation
import MapKit

struct Location: Codable {
    var timestamp: String
    var status: String
    
    // Address
    var street: String
    var city: String
    var state: String
    var zip: String
    var country: String
    
    var address: String {
        String("\(street), \(city), \(state) \(zip), \(country)")
    }
    
    // Geolocation
    var latitude: String
    var longitude: String

    // TODO better handle if cast is unsuccessful (invalid coordinates... some coordinate error map view?)
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(
            latitude: Double(latitude) ?? 0.0,
            longitude: Double(longitude) ?? 0.0
        )
    }
}
