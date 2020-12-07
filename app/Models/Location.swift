//
//  LocationInfo.swift
//  Inventory Tracker
//
//  Created by Ryan Mackin on 10/28/20.
//

import Foundation
import CoreLocation


class Location {
    static let shared = Location()
    
    private init() {}
    
    // Singleton data
    
    var timestamp: String?
    
    var coordinate: CLLocationCoordinate2D?
    
    var status: String?

    var street: String?
    var city: String?
    var state: String?
    var zip: String?
    var country: String?
    
    func getInfo() -> Data? {
        var info = [String: String]()
        
        info["timestamp"] = timestamp
        info["street"] = street
        info["city"] = city
        info["state"] = state
        info["zip"] = zip
        info["country"] = country
        if let coordinate = coordinate {
            info["latitude"] = String(coordinate.latitude)
            info["longitude"] = String(coordinate.longitude)
        }
        info["status"] = status
        
        do {
            return try JSONSerialization.data(withJSONObject: info, options: .prettyPrinted)
        } catch let err {
            print(err.localizedDescription)
            return nil
        }
    }
    
    func clear() {
        timestamp = nil
        coordinate = nil
        status = nil
        street = nil
        city = nil
        state = nil
        zip = nil
        country = nil
    }
}
