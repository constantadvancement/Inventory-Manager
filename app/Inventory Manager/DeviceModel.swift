//
//  DeviceModel.swift
//  Inventory Tracker
//
//  Created by Ryan Mackin on 10/27/20.
//

import Cocoa

class Device {
    public var modelName: String?
    var modelIdentifier: String?
    var modelNumber: String?
    var serialNumber: String?
    var hardwareUUID: String?
    
    init() {
        if let modelName = getModelName() {
            self.modelName = modelName
        }
    }
    
    func getModelName() -> String? {
        guard let modelInfo = Host.current().localizedName else { return nil }
        var modelSubstring = modelInfo.split(separator: " ")
        // removes this device's user from the `modelInfo` string (e.g. "<User>'s MacBook Pro" -> "Mackbook Pro")
        modelSubstring.removeFirst()
        let modelName = modelSubstring.joined(separator: " ")
        return modelName
    }
}
