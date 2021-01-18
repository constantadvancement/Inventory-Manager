//
//  InventoryRow.swift
//  InventoryManager
//
//  Created by Ryan Mackin on 12/14/20.
//

import SwiftUI

struct InventoryRow: View {
    
    @State private var showingDetailView = false
    var inventory: Inventory
    
    var body: some View {
        Button(action: {
            self.showingDetailView.toggle()
        }) {
            HStack {
                VStack(alignment: .leading) {
                    Text(inventory.device.modelName)
                        .font(.headline)
                        .foregroundColor(Color.primaryText)

                    Text(inventory.holder.name)
                        .font(.subheadline)
                        .foregroundColor(Color.secondaryText)
                }

                Spacer()

                Image(systemName: "chevron.right")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 15)
                    .foregroundColor(Color.primaryHighlight)
            }
        }
        .fullScreenCover(isPresented: $showingDetailView) {
            DetailView(inventory: inventory)
        }
        .onReceive(NotificationCenter.default.publisher(for: .closeDetailView)) { _ in
            self.showingDetailView = false
        }
    }
}

struct InventoryRow_Previews: PreviewProvider {
    static var previews: some View {
        InventoryRow(inventory: INVENTORY)
    }
}
