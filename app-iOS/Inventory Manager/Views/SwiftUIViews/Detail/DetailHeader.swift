//
//  DetailHeader.swift
//  InventoryManager
//
//  Created by Ryan Mackin on 1/4/21.
//

import SwiftUI

struct DetailHeader: View {
    
    @State private var showingHistoryView = false
    @State var inventory: Inventory
    
    var body: some View {
        HStack {
            Button(action: {
                NotificationCenter.default.post(name: .closeDetailView, object: nil)
            }) {
                Image(systemName: "chevron.left")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 18)
                    .foregroundColor(Color.primaryHighlight)
            }
            .frame(width: 30, height: 30)
            
            Text(inventory.holder.name)
                .foregroundColor(Color.primaryText)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.leading, -30)
                .padding(.trailing, -30)
                .font(.headline)
            
            Button(action: {
                self.showingHistoryView.toggle()
            }) {
                Image(systemName: "map")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 18)
                    .foregroundColor(Color.primaryText)
            }
            .frame(width: 30, height: 30)
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
