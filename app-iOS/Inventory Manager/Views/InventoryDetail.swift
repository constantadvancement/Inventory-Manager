//
//  InventoryDetail.swift
//  InventoryManager
//
//  Created by Ryan Mackin on 12/14/20.
//

import SwiftUI

struct InventoryDetail: View {
    
    var inventory: Inventory
    
    var body: some View {
        Text(inventory.holder.name)
    }
}

struct InventoryDetail_Previews: PreviewProvider {
    static var previews: some View {
        InventoryDetail(inventory: INVENTORY)
    }
}
