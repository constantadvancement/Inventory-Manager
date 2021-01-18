//
//  DetailHeader.swift
//  InventoryManager
//
//  Created by Ryan Mackin on 1/4/21.
//

import SwiftUI

struct DetailHeader: View {
    
    @State private var showingHistoryView = false
    
    var inventory: Inventory
    
    var body: some View {
        HStack {
            Button(action: {
                NotificationCenter.default.post(name: .closeDetailView, object: nil)
            }) {
                Image(systemName: "chevron.left")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 15)
                    .foregroundColor(Color.primaryHighlight)
            }

            Spacer()
            
            Text(inventory.holder.name)
                .foregroundColor(Color.primaryText)
                .padding(.leading, -15)
                .padding(.trailing, -18)
                .font(.headline)
            
            Spacer()
            
            Button(action: {
                self.showingHistoryView.toggle()
            }) {
                Image(systemName: "map")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 18)
                    .foregroundColor(Color.primaryText)
            }
            .sheet(isPresented: $showingHistoryView) {
                HistoryView(locationHistory: inventory.locations)
            }
        }
    }
}

struct DetailHeader_Previews: PreviewProvider {
    static var previews: some View {
        DetailHeader(inventory: INVENTORY)
    }
}
