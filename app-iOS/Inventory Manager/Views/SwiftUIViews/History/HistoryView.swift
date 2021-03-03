//
//  InventoryHistory.swift
//  InventoryManager
//
//  Created by Ryan Mackin on 1/5/21.
//

import SwiftUI

struct HistoryView: View {
    
    @State var locationHistory: [Location]
    
    var body: some View {
        VStack(spacing: 0) {
            HistoryHeader(locationHistory: locationHistory)
                .padding()
                .border(width: 2, edges: [.bottom], color: Color.tertiaryBackground)
                .background(Color.primaryBackground)
                .onLongPressGesture {
                    NotificationCenter.default.post(name: .closeHistoryView, object: nil)
                }
            
            HistoryList(locationHistory: locationHistory)
            
//            HistoryFilters()
//                .padding()
//                .border(width: 2, edges: [.bottom], color: Color.tertiaryBackground)
        }
        .background(Color.primaryBackground.ignoresSafeArea())
    }
}

struct InventoryHistory_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView(locationHistory: INVENTORY.locations)
    }
}
