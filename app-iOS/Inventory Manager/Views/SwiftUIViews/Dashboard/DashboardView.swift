//
//  Dashboard.swift
//  InventoryManager
//
//  Created by Ryan Mackin on 12/21/20.
//

import SwiftUI

struct DashboardView: View {
    
    @EnvironmentObject var userObject: UserObject
    @EnvironmentObject var inventoryObject: InventoryObject
    
    @State private var searchText = ""
    
    var body: some View {
        VStack(spacing: 0) {
            DashboardHeader(searchText: $searchText)
                .padding()
                .applyHorizontalBorder(color: Color.tertiaryBackground, alignment: .bottom)
            
            if inventoryObject.isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: Color.primaryHighlight))
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.secondaryBackground.ignoresSafeArea())
                    .onAppear {
                        // Fetchs ALL inventory items
                        inventoryObject.fetchInventory(apiKey: userObject.user?.apiKey ?? nil)
                    }
            } else {
                ScrollView {
                    VStack(spacing: 0) {
                        PullToRefresh() {
                            // Re-fetchs ALL inventory items
                            inventoryObject.fetchInventory(apiKey: userObject.user?.apiKey ?? nil)
                        }
                        
                        InventoryList(inventoryList: $inventoryObject.inventoryList, searchText: $searchText)
                    }
                }
                .coordinateSpace(name: String.pullToRefresh)
                .background(Color.secondaryBackground.ignoresSafeArea())
            }
        }
        .background(Color.primaryBackground.ignoresSafeArea())
    }
}

struct Dashboard_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
