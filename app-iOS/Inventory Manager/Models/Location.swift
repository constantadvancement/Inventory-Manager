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
    var street: String?
    var city: String?
    var state: String?
    var zip: String?
    var country: String?
    
    var address: String {
        if let street = street, let city = city, let state = state, let zip = zip, let country = country {
            return String("\(street), \(city), \(state) \(zip), \(country)")
        } else {
            return "Unknown Address"
        }
    }
    
    // Geolocation
    var latitude: String?
    var longitude: String?

    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(
            latitude: Double(latitude ?? "0.0") ?? 0.0,
            longitude: Double(longitude ?? "0.0") ?? 0.0
        )
    }
}
