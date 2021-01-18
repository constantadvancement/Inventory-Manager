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
    var locations: [Location]
}
















let INVENTORY: Inventory = Inventory(device: Device(serialNumber: "OSRS1SC00LL0L", modelName: "MacBook Pro", modelIdentifier: "MacBookPro15,1", modelNumber: "A1990", hardwareUUID: "43AF66C2-6CFE-50B4-A2C5-19F197144788"), holder: Holder(name: "Ryan Mackin", email: "mackin9707@gmail.com", phone: "240-454-1665"), locations: [Location(timestamp: "2020-12-14T17:11:47.000Z", status: "authorized", street: "12108 Tracy Ct", city: "Monrovia", state: "MD", zip: "21770", country: "US", latitude: "39.243691909748364", longitude: "-77.2800294466626"), Location(timestamp: "2020-12-14T17:11:47.000Z", status: "authorized", street: "23407 Winemiller Way", city: "Clarksburg", state: "MD", zip: "20871", country: "US", latitude: "39.243691909748364", longitude: "-77.2800294466626")])

let INVENTORY_LIST: [Inventory] = [
    Inventory(device: Device(serialNumber: "OSRS1SC00LL0L", modelName: "MacBook Pro", modelIdentifier: "MacBookPro15,1", modelNumber: "A1990", hardwareUUID: "43AF66C2-6CFE-50B4-A2C5-19F197144788"), holder: Holder(name: "Ryan Mackin", email: "mackin9707@gmail.com", phone: "240-454-1665"), locations: [Location(timestamp: "2020-12-14T17:11:47.000Z", status: "authorized", street: "12108 Tracy Ct", city: "Monrovia", state: "MD", zip: "21770", country: "US", latitude: "39.243691909748364", longitude: "-77.2800294466626")]),
    Inventory(device: Device(serialNumber: "C02YRALKLVCG", modelName: "MacBook Pro", modelIdentifier: "MacBookPro15,1", modelNumber: "A1990", hardwareUUID: "43AF66C2-6CFE-50B4-A2C5-19F197144788"), holder: Holder(name: "Sherlly Dolmuz", email: "sherllyv@me.com", phone: "240-589-9119"), locations: [Location(timestamp: "2020-12-14T17:11:47.000Z", status: "authorized", street: "23407 Winemiller Way", city: "Clarksburg", state: "MD", zip: "20871", country: "US", latitude: "39.243691909748364", longitude: "-77.2800294466626")])
]
