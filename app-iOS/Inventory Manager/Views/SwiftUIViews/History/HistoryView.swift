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
                .applyHorizontalBorder(color: Color.tertiaryBackground, alignment: .bottom)
            
            HistoryList(locationHistory: locationHistory)
            
//            HistoryFilters()
//                .padding()
//                .applyHorizontalBorder(color: Color.tertiaryBackground, alignment: .top)
        }
        .background(Color.primaryBackground.ignoresSafeArea())
    }
}

struct InventoryHistory_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView(locationHistory: INVENTORY.locations)
    }
}
