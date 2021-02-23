//
//  HistoryRow.swift
//  InventoryManager
//
//  Created by Ryan Mackin on 1/8/21.
//

import SwiftUI

struct HistoryRow: View {
    
    @State var location: Location
    
    var body: some View {
        VStack(spacing: 8) {
            HStack(alignment: .top) {
                Text("Address").fontWeight(.semibold)
                    .frame(width: 150, alignment: .leading)
                Text(location.address)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            HStack(alignment: .top) {
                Text("Timestamp").fontWeight(.semibold)
                    .frame(width: 150, alignment: .leading)
                Text(location.timestamp)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            HStack(alignment: .top) {
                Text("Status").fontWeight(.semibold)
                    .frame(width: 150, alignment: .leading)
                Text(location.status)
                    .frame(maxWidth: .infinity, alignment: .leading)
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
