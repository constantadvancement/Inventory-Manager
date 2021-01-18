//
//  Dashboard.swift
//  InventoryManager
//
//  Created by Ryan Mackin on 12/21/20.
//

import SwiftUI

struct DashboardView: View {
    
    @State private var isLoading = true
    @State private var searchText = ""
    @State private var inventoryList = [Inventory]()
    
    var body: some View {
        VStack(spacing: 0) {
            // Header
            DashboardHeader(searchText: $searchText)
                .padding()
                .applyHorizontalBorder(color: Color.tertiaryBackground, alignment: .bottom)
            
            // Body
            if isLoading {
                ProgressSpinner()
                    .background(Color.secondaryBackground.ignoresSafeArea())
                    .onAppear {
                        // Fetch event
                        fetchInventory()
                    }
            } else {
                InventoryList(searchText: $searchText, inventoryList: $inventoryList)
            }
        }
        .background(Color.primaryBackground.ignoresSafeArea())
        .onReceive(NotificationCenter.default.publisher(for: .updateInventory)) { _ in
            // Update event (triggers fetch event)
            self.isLoading = true
        }
        .onReceive(NotificationCenter.default.publisher(for: .deleteInventory)) { data in
            // Delete event
            deleteInventory(serialNumber: data.object as! String)
        }
    }
    
    // Helper functions
    
    private func fetchInventory() {
        let seconds = 1.0
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
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
                        inventoryList = data
                        isLoading = false
                    }
                } else {
                    // TODO; failed to decode... stop spinner and display an error message...
                    print("Failed to decode...")
                }
            }
        }
    }
    
    private func deleteInventory(serialNumber: String) {
        let inventoryList = self.inventoryList.filter { $0.device.serialNumber !=  serialNumber }
        self.inventoryList = inventoryList
        
        // TODO server side delete http call
    }
    
}



struct Dashboard_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
