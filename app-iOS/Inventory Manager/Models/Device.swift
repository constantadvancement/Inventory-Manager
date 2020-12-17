//
//  Device.swift
//  InventoryManager
//
//  Created by Ryan Mackin on 12/11/20.
//

import Foundation

struct Device: Codable {
    var serialNumber: String
    var modelName: String
    var modelIdentifier: String
    var modelNumber: String
    var hardwareUUID: String
}
