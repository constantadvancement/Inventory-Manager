//
//  Inventory.swift
//  InventoryManager
//
//  Created by Ryan Mackin on 12/11/20.
//

import Foundation

struct Inventory: Codable {
    var device: Device
    var holder: Holder
    var location: Location
}

let INVENTORY: Inventory = Inventory(device: Device(serialNumber: "C02YRALKLVCG", modelName: "MacBook Pro", modelIdentifier: "MacBookPro15,1", modelNumber: "A1990", hardwareUUID: "43AF66C2-6CFE-50B4-A2C5-19F197144788"), holder: Holder(name: "Ryan Mackin"), location: Location(timestamp: "2020-12-14T17:11:47.000Z", status: "authorized", street: "23407 Winemiller Way", city: "Clarksburg", state: "MD", zip: "20871", country: "US", latitude: "39.243691909748364", longitude: "-77.2800294466626"))

let INVENTORY_LIST: [Inventory] = []
