//
//  Inventory_ManagerApp.swift
//  Inventory Manager
//
//  Created by Ryan Mackin on 12/11/20.
//

import SwiftUI

@main
struct Inventory_ManagerApp: App {
    
    @StateObject var userObject = UserObject()
    @StateObject var inventoryObject = InventoryObject()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(userObject)
                .environmentObject(inventoryObject)
                .onAppear {
                    // App configuration
                    UIApplication.shared.addTapGestureRecognizer()
                }
        }
    }
}
