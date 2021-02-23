//
//  HistoryFilters.swift
//  InventoryManager
//
//  Created by Ryan Mackin on 1/19/21.
//

import SwiftUI

struct HistoryFilters: View {
    var body: some View {
        VStack {
            HStack {
                Text("Filters")
                    .font(.headline)
                    .foregroundColor(Color.primaryText)
                
                Spacer()
            }
            
            // TODO filters

        }
    }
}

struct HistoryFilters_Previews: PreviewProvider {
    static var previews: some View {
        HistoryFilters()
    }
}
