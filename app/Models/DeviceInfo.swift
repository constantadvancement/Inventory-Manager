//
//  DeviceInfo.swift
//  Inventory Tracker
//
//  Created by Ryan Mackin on 10/28/20.
//

import Cocoa

class DeviceInfo {
    static let shared = DeviceInfo()
    
    private init() {}
    
    // Singleton data
    
    var modelName: String?
    var modelIdentifier: String?
    var modelNumber: String?
    var serialNumber: String?
    var hardwareUUID: String?
    
    // Singleton functions
    
    func getInfo() -> Data? {
        var info = [String: String]()
        
        info["Model Name"] = modelName
        info["Model Identifier"] = modelIdentifier
        info["Model Number"] = modelNumber
        info["Serial Number"] = serialNumber
        info["Hardware UUID"] = hardwareUUID
        
        do {
            return try JSONSerialization.data(withJSONObject: info, options: .prettyPrinted)
        } catch let err {
            print(err.localizedDescription)
            return nil
        }
    }
}
