//
//  HistoryList.swift
//  InventoryManager
//
//  Created by Ryan Mackin on 1/5/21.
//

import SwiftUI

struct HistoryList: View {
    
    @State var locationHistory: [Location]
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 0) {
                ForEach(locationHistory, id: \.timestamp) { location in
                    HistoryRow(location: location)
                        .applyListRowStyle(separatorColor: Color.primaryBackground)
                }
            }
        }
        .background(Color.secondaryBackground.ignoresSafeArea())
    }
}

struct HistoryList_Previews: PreviewProvider {
    static var previews: some View {
        HistoryList(locationHistory: INVENTORY.locations)
    }
}
