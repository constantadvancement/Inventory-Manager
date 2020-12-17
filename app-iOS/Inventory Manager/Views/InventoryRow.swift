//
//  InventoryRow.swift
//  InventoryManager
//
//  Created by Ryan Mackin on 12/14/20.
//

import SwiftUI

struct InventoryRow: View {
    
    var inventory: Inventory
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(inventory.device.modelName)
                    .font(.headline)
                
                Text(inventory.holder.name)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
        }
    }
}

struct InventoryRow_Previews: PreviewProvider {
    static var previews: some View {
        InventoryRow(inventory: INVENTORY)
    }
}
