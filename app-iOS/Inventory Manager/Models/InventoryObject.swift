//
//  InventoryRefactor.swift
//  InventoryManager
//
//  Created by Ryan Mackin on 1/19/21.
//

import Foundation

struct Inventory: Codable {
    var device: Device
    var holder: Holder
    var locations: [Location]
}

class InventoryObject: ObservableObject {
    @Published var inventoryList: [Inventory]
    @Published var isLoading: Bool
    
    init() {
        self.inventoryList = []
        self.isLoading = true
    }
    
    /**
     Clears the current data stored by this observable object. This is executed upon user logout.
     */
    func clear() {
        self.inventoryList = []
        self.isLoading = true
    }
    
    /**
     Fetches all inventory records from the CA Inventory Manager server. Uses the provided apiKey to authorize this action.
     */
    func fetchInventory(apiKey: String?) {
        guard let apiKey = apiKey else { return }

        let http = HttpClient()
        http.GET(url: "\(String.production)/\(apiKey)/inventory") { (err: Error?, data: Data?) in
            guard data != nil else {
                // Failure; a server or client error occurred
                print("Server or client error has occurred!")
                self.isLoading = false
                
                // TODO; handle this.... stop spinner and display an error message...
                // An error occured while processing your request... Please ensure that <app name> is updated or our servers may be down.
                return
            }

            if let data = try? JSONDecoder().decode([Inventory].self, from: data!) {
                DispatchQueue.main.async { [self] in
                    self.inventoryList = data
                    self.isLoading = false
                }
            } else {
                print("An unknown error has occurred.")
                self.inventoryList = []
                self.isLoading = false
            }
        }
    }
    
    /**
     Deletes the inventory record specified by the provided serial number. Uses the provided apiKey to authorize this action.
     */
    func deleteInventory(apiKey: String?, serialNumber: String) {
        guard let apiKey = apiKey else { return }
        
        // Server update
        let http = HttpClient()
        http.POST(url: "\(String.production)/\(apiKey)/unregister/device/\(serialNumber)", body: nil) { (err: Error?, data: Data?) in
            guard data != nil else {
                // Failure; a server or client error occurred
                print("Server or client error has occurred!")
                return
            }

            if let result = try? JSONDecoder().decode(Bool.self, from: data!) {
                if result {
                    DispatchQueue.main.async { [self] in
                        // Local update
                        let inventoryList = self.inventoryList.filter { $0.device.serialNumber !=  serialNumber }
                        self.inventoryList = inventoryList
                    }
                }
            }
        }
    }
}










let INVENTORY: Inventory = Inventory(device: Device(serialNumber: "OSRS1SC00LL0L", modelName: "MacBook Pro", modelIdentifier: "MacBookPro15,1", modelNumber: "A1990", hardwareUUID: "43AF66C2-6CFE-50B4-A2C5-19F197144788"), holder: Holder(name: "Ryan Mackin", email: "mackin9707@gmail.com", phone: "240-454-1665"), locations: [Location(timestamp: "2020-12-14T17:11:47.000Z", status: "authorized", street: "12108 Tracy Ct", city: "Monrovia", state: "MD", zip: "21770", country: "US", latitude: "39.243691909748364", longitude: "-77.2800294466626"), Location(timestamp: "2020-12-14T17:11:47.000Z", status: "authorized", street: "23407 Winemiller Way", city: "Clarksburg", state: "MD", zip: "20871", country: "US", latitude: "39.243691909748364", longitude: "-77.2800294466626")])

let INVENTORY_LIST: [Inventory] = [
    Inventory(device: Device(serialNumber: "OSRS1SC00LL0L", modelName: "MacBook Pro", modelIdentifier: "MacBookPro15,1", modelNumber: "A1990", hardwareUUID: "43AF66C2-6CFE-50B4-A2C5-19F197144788"), holder: Holder(name: "Ryan Mackin", email: "mackin9707@gmail.com", phone: "240-454-1665"), locations: [Location(timestamp: "2020-12-14T17:11:47.000Z", status: "authorized", street: "12108 Tracy Ct", city: "Monrovia", state: "MD", zip: "21770", country: "US", latitude: "39.243691909748364", longitude: "-77.2800294466626")]),
    Inventory(device: Device(serialNumber: "C02YRALKLVCG", modelName: "MacBook Pro", modelIdentifier: "MacBookPro15,1", modelNumber: "A1990", hardwareUUID: "43AF66C2-6CFE-50B4-A2C5-19F197144788"), holder: Holder(name: "Sherlly Dolmuz", email: "sherllyv@me.com", phone: "240-589-9119"), locations: [Location(timestamp: "2020-12-14T17:11:47.000Z", status: "authorized", street: "23407 Winemiller Way", city: "Clarksburg", state: "MD", zip: "20871", country: "US", latitude: "39.243691909748364", longitude: "-77.2800294466626")])
]
