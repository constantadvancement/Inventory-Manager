//
//  Location.swift
//  InventoryManager
//
//  Created by Ryan Mackin on 12/11/20.
//

import Foundation

struct Location: Codable {
    var timestamp: String
    var status: String
    
    // Address
    var street: String
    var city: String
    var state: String
    var zip: String
    var country: String
    
    // Geolocation
    var latitude: String
    var longitude: String
}
