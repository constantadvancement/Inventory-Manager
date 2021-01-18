//
//  Inventory_ManagerApp.swift
//  Inventory Manager
//
//  Created by Ryan Mackin on 12/11/20.
//

import SwiftUI

@main
struct Inventory_ManagerApp: App {
    
    @StateObject var user = User()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(user)
                .onAppear {
                    // App configuration
                    UIApplication.shared.addTapGestureRecognizer()
                }
        }
    }
}
