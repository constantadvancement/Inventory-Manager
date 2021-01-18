//
//  InventoryList.swift
//  InventoryManager
//
//  Created by Ryan Mackin on 12/14/20.
//

import SwiftUI

struct InventoryList: View {
    
    @Binding var searchText: String
    @Binding var inventoryList: [Inventory]
    
    var body: some View {
        // Filtered inventory list
        let filteredInventoryList = inventoryList.filter({ inventory in
            searchText.isEmpty ? true : (inventory.holder.name.range(of: searchText, options: .caseInsensitive) != nil || inventory.device.modelName.range(of: searchText, options: .caseInsensitive) != nil)
        })
        
        if !filteredInventoryList.isEmpty {
            ScrollView {
                LazyVStack(spacing: 0) {
                    ForEach(filteredInventoryList, id: \.device.serialNumber) { inventory in
                        InventoryRow(inventory: inventory)
                            .applyListRowStyle(separatorColor: Color.primaryBackground)
                    }
                }
            }
            .background(Color.secondaryBackground.ignoresSafeArea())
            .gesture(DragGesture()
                .onChanged { _ in
                    // Hide keyboard on drag gesture
                    self.hideKeyboard()
                }
            )
        } else {
            VStack {
                Text("No results found for \n\"\(searchText)\"")
                    .foregroundColor(Color.primaryText)
                    .multilineTextAlignment(.center)
                
                Text("Try searching again using a different spelling \nor keyword.")
                    .font(.subheadline)
                    .foregroundColor(Color.secondaryText)
                    .multilineTextAlignment(.center)
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .background(Color.secondaryBackground.ignoresSafeArea())
        }
    }
}

struct InventoryList_Previews: PreviewProvider {
    static var previews: some View {
        InventoryList(searchText: .constant(""), inventoryList: .constant(INVENTORY_LIST))
    }
}
