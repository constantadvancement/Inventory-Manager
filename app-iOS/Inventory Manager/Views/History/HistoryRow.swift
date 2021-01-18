//
//  HistoryRow.swift
//  InventoryManager
//
//  Created by Ryan Mackin on 1/8/21.
//

import SwiftUI

struct HistoryRow: View {
    
    var location: Location
    
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                Text("Address").fontWeight(.semibold)
                Spacer()
                Text(location.address)
            }
            
            HStack(alignment: .top) {
                Text("Timestamp").fontWeight(.semibold)
                Spacer()
                Text(location.timestamp)
            }
            
            HStack(alignment: .top) {
                Text("Status").fontWeight(.semibold)
                Spacer()
                Text(location.status)
            }
        }
        .fixedSize(horizontal: false, vertical: true)
        .foregroundColor(Color.primaryText)
    }
}

struct HistoryRow_Previews: PreviewProvider {
    static var previews: some View {
        HistoryRow(location: INVENTORY.locations[0])
    }
}
