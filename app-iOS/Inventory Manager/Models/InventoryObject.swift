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
    
    init() {
        self.inventoryList = []
    }
    
    // Fetches all inventory records from the CA Inventory Manager server
    func fetchInventory() {
        let http = HttpClient()
        http.GET(url: "http://localhost:3000/inventory") { (err: Error?, data: Data?) in
            guard data != nil else {
                // Failure; a server or client error occurred
                print("Server or client error has occurred!")
                
                // TODO; handle this.... stop spinner and display an error message...
                // An error occured while processing your request... Please ensure that <app name> is updated or our servers may be down.
                return
            }

            if let data = try? JSONDecoder().decode([Inventory].self, from: data!) {
                DispatchQueue.main.async { [self] in
                    self.inventoryList = data
                    print(data)
                }
            } else {
                // TODO; failed to decode... stop spinner and display an error message...
                print("Failed to decode...")
            }
        }
    }
    
    // Deletes the inventory record specified by the provided serial number
    func deleteInventory(serialNumber: String) {
        let inventoryList = self.inventoryList.filter { $0.device.serialNumber !=  serialNumber }
        self.inventoryList = inventoryList
        
        // TODO server side delete http call
    }
}
