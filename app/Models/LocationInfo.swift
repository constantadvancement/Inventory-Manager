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
    
    func getInfo() -> Data? {
        var info = [String: String]()
        
        info["Timestamp"] = timestamp
        info["Street"] = street
        info["City"] = city
        info["State"] = state
        info["Zip"] = zip
        info["Country"] = country
        
        do {
            return try JSONSerialization.data(withJSONObject: info, options: .prettyPrinted)
        } catch let err {
            print(err.localizedDescription)
            return nil
        }
    }
}
