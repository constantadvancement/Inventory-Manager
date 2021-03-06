//
//  DeviceInfo.swift
//  Inventory Tracker
//
//  Created by Ryan Mackin on 10/28/20.
//

import Cocoa

class Device {
    static let shared = Device()
    
    private init() {}
    
    var modelName: String?
    var modelIdentifier: String?
    var modelNumber: String?
    var serialNumber: String?
    var hardwareUUID: String?
    
    func getInfo() -> Data? {
        var info = [String: String]()
        
        info["modelName"] = modelName
        info["modelIdentifier"] = modelIdentifier
        info["modelNumber"] = modelNumber
        info["serialNumber"] = serialNumber
        info["hardwareUUID"] = hardwareUUID
        
        do {
            return try JSONSerialization.data(withJSONObject: info, options: .prettyPrinted)
        } catch let err {
            print(err.localizedDescription)
            return nil
        }
    }
}
