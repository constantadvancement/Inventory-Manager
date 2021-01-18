//
//  HistoryHeader.swift
//  InventoryManager
//
//  Created by Ryan Mackin on 1/5/21.
//

import SwiftUI

struct HistoryHeader: View {
    
    var locationHistory: [Location]
    
    var body: some View {
        HStack {
            Text("Location History")
                .font(.headline)
                .foregroundColor(Color.primaryText)
            
            Spacer()
            
            Text("Showing \(locationHistory.count) \(locationHistory.count == 1 ? "result" : "results")")
                .font(.subheadline)
                .foregroundColor(Color.secondaryText)
        }
    }
}

struct HistoryHeader_Previews: PreviewProvider {
    static var previews: some View {
        HistoryHeader(locationHistory: INVENTORY.locations)
    }
}
