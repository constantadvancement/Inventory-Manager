//
//  LocationInfo.swift
//  Inventory Tracker
//
//  Created by Ryan Mackin on 10/28/20.
//

import Foundation

class LocationInfo {
    static let shared = LocationInfo()
    
    private init() {}
    
    // Singleton data
    
    var timestamp: String?
    var street: String?
    var city: String?
    var state: String?
    var zip: String?
    var country: String?
    
    func getInfo() -> [String: String] {
        var info = [String: String]()
        
        info["Timestamp"] = timestamp
        info["Street"] = street
        info["City"] = city
        info["State"] = state
        info["Zip"] = zip
        info["Country"] = country
        
        return info
    }
}
